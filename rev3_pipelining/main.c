#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

#define BLOCK_SIZE 16
#define SEARCH_RANGE 7

// Function to calculate SAD for a block using software pipelining
unsigned short calculate_sad(unsigned char *current, unsigned char *reference, int x, int y, int ref_x, int ref_y, int width, int height) {
    unsigned short sad = 0;
    int i = 0, j = 0;

    // Prologue
    for (; i < 3; i++) {
        for (j = 0; j < BLOCK_SIZE; j++) {
            int cur_index = (y + i) * width + (x + j);
            int ref_index = (ref_y + i) * width + (ref_x + j);
            if (cur_index < width * height && ref_index < width * height) {
                sad += abs((int)current[cur_index] - (int)reference[ref_index]);
            }
        }
    }

    // Steady state loop
    for (; i < BLOCK_SIZE - 3; i++) {
        int cur_indices[4], ref_indices[4];
        unsigned short sads[4] = {0};

        // Load indices
        for (int k = 0; k < 4; k++) {
            for (j = 0; j < BLOCK_SIZE; j++) {
                cur_indices[k] = (y + i + k) * width + (x + j);
                ref_indices[k] = (ref_y + i + k) * width + (ref_x + j);
                if (cur_indices[k] < width * height && ref_indices[k] < width * height) {
                    sads[k] += abs((int)current[cur_indices[k]] - (int)reference[ref_indices[k]]);
                }
            }
        }

        // Sum the intermediate sads
        for (int k = 0; k < 4; k++) {
            sad += sads[k];
        }
    }

    // Epilogue
    for (; i < BLOCK_SIZE; i++) {
        for (j = 0; j < BLOCK_SIZE; j++) {
            int cur_index = (y + i) * width + (x + j);
            int ref_index = (ref_y + i) * width + (ref_x + j);
            if (cur_index < width * height && ref_index < width * height) {
                sad += abs((int)current[cur_index] - (int)reference[ref_index]);
            }
        }
    }

    return sad;
}

// Function to find the best match for a block in the reference frame
void find_best_match(unsigned char *current, unsigned char *reference, int x, int y, int width, int height, signed char *best_x, signed char *best_y) {
    unsigned short min_sad = USHRT_MAX;
    for (int i = -SEARCH_RANGE; i <= SEARCH_RANGE; i++) {
        for (int j = -SEARCH_RANGE; j <= SEARCH_RANGE; j++) {
            int ref_x = x + j;
            int ref_y = y + i;
            if (ref_x >= 0 && ref_y >= 0 && ref_x + BLOCK_SIZE <= width && ref_y + BLOCK_SIZE <= height) {
                unsigned short sad = calculate_sad(current, reference, x, y, ref_x, ref_y, width, height);
                if (sad < min_sad) {
                    min_sad = sad;
                    *best_x = (signed char)(ref_x - x);
                    *best_y = (signed char)(ref_y - y);
                }
            }
        }
    }
}

// Function to perform motion estimation for the entire frame
void motion_estimation(unsigned char *current, unsigned char *reference, int width, int height, signed char *motion_vectors) {
    for (int y = 0; y < height; y += BLOCK_SIZE) {
        for (int x = 0; x < width; x += BLOCK_SIZE) {
            signed char best_x = 0, best_y = 0;
            find_best_match(current, reference, x, y, width, height, &best_x, &best_y);
            int index = (y / BLOCK_SIZE) * (width / BLOCK_SIZE) + (x / BLOCK_SIZE);
            motion_vectors[2 * index] = best_x;
            motion_vectors[2 * index + 1] = best_y;
        }
    }
}

// Function to read image data from a text file
unsigned char* read_image_from_text(const char *filename, int width, int height) {
    FILE *file = fopen(filename, "r");
    if (!file) {
        perror("Error opening file");
        exit(EXIT_FAILURE);
    }
    unsigned char *image = (unsigned char *)malloc(width * height);
    if (!image) {
        perror("Error allocating memory");
        exit(EXIT_FAILURE);
    }
    for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
            unsigned int pixel;
            fscanf(file, "%u", &pixel);
            image[i * width + j] = (unsigned char)pixel;
        }
    }
    fclose(file);
    return image;
}

int main() {
    int width = 320;
    int height = 240;
    unsigned char *current_frame = read_image_from_text("../utils/current_frame.txt", width, height);
    unsigned char *reference_frame = read_image_from_text("../utils/reference_frame.txt", width, height);

    signed char *motion_vectors = (signed char *)malloc(2 * (width / BLOCK_SIZE) * (height / BLOCK_SIZE) * sizeof(signed char));
    motion_estimation(current_frame, reference_frame, width, height, motion_vectors);

    // Print motion vectors
    for (int i = 0; i < (width / BLOCK_SIZE) * (height / BLOCK_SIZE); i++) {
        printf("Block %d: MVx = %d, MVy = %d\n", i, motion_vectors[2 * i], motion_vectors[2 * i + 1]);
    }

    free(current_frame);
    free(reference_frame);
    free(motion_vectors);
    return 0;
}
