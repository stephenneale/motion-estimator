#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

#define BLOCK_SIZE 16
#define SEARCH_RANGE 7

// Function to calculate SAD for a block with loop unrolling
unsigned short calculate_sad(unsigned char *current, unsigned char *reference, int x, int y,
                             int ref_x, int ref_y, int width, int height) {
    unsigned short sad = 0;
    for (int i = 0; i < BLOCK_SIZE; i++) {
        for (int j = 0; j < BLOCK_SIZE; j += 4) { // Unrolling by a factor of 4
            int cur_index0 = (y + i) * width + (x + j);
            int ref_index0 = (ref_y + i) * width + (ref_x + j);

            int cur_index1 = (y + i) * width + (x + j + 1);
            int ref_index1 = (ref_y + i) * width + (ref_x + j + 1);

            int cur_index2 = (y + i) * width + (x + j + 2);
            int ref_index2 = (ref_y + i) * width + (ref_x + j + 2);

            int cur_index3 = (y + i) * width + (x + j + 3);
            int ref_index3 = (ref_y + i) * width + (ref_x + j + 3);

            if (cur_index0 < width * height && ref_index0 < width * height) {
                sad += abs((int)current[cur_index0] - (int)reference[ref_index0]);
            }

            if (cur_index1 < width * height && ref_index1 < width * height) {
                sad += abs((int)current[cur_index1] - (int)reference[ref_index1]);
            }

            if (cur_index2 < width * height && ref_index2 < width * height) {
                sad += abs((int)current[cur_index2] - (int)reference[ref_index2]);
            }

            if (cur_index3 < width * height && ref_index3 < width * height) {
                sad += abs((int)current[cur_index3] - (int)reference[ref_index3]);
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
