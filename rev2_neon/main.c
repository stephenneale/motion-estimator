#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <arm_neon.h>

#define BLOCK_SIZE 16
#define SEARCH_RANGE 7

// Function to calculate SAD for a block using NEON intrinsics
unsigned short calculate_sad(unsigned char *current, unsigned char *reference, int x, int y, int ref_x, int ref_y, int width, int height) {
    unsigned short sad = 0;
    uint16x8_t vsad = vdupq_n_u16(0);  // Initialize a vector to accumulate SAD

    for (int i = 0; i < BLOCK_SIZE; i++) {
        for (int j = 0; j < BLOCK_SIZE; j += 8) {  // Process 8 pixels at a time
            int cur_index = (y + i) * width + (x + j);
            int ref_index = (ref_y + i) * width + (ref_x + j);

            if (cur_index + 7 < width * height && ref_index + 7 < width * height) {
                uint8x8_t vcur = vld1_u8(&current[cur_index]);
                uint8x8_t vref = vld1_u8(&reference[ref_index]);
                uint8x8_t vdiff = vabd_u8(vcur, vref);
                vsad = vaddw_u8(vsad, vdiff);
            }
        }
    }

    // Accumulate the values from the vector
    sad += vgetq_lane_u16(vsad, 0);
    sad += vgetq_lane_u16(vsad, 1);
    sad += vgetq_lane_u16(vsad, 2);
    sad += vgetq_lane_u16(vsad, 3);
    sad += vgetq_lane_u16(vsad, 4);
    sad += vgetq_lane_u16(vsad, 5);
    sad += vgetq_lane_u16(vsad, 6);
    sad += vgetq_lane_u16(vsad, 7);

    return sad;
}

// Function to find the best match for a block in the reference frame
void find_best_match(unsigned char *current, unsigned char *reference, int x, int y, int width, int height, char *best_x, char *best_y) {
    unsigned short min_sad = USHRT_MAX;
    for (int i = -SEARCH_RANGE; i <= SEARCH_RANGE; i++) {
        for (int j = -SEARCH_RANGE; j <= SEARCH_RANGE; j++) {
            int ref_x = x + j;
            int ref_y = y + i;
            if (ref_x >= 0 && ref_y >= 0 && ref_x + BLOCK_SIZE < width && ref_y + BLOCK_SIZE < height) {
                unsigned short sad = calculate_sad(current, reference, x, y, ref_x, ref_y, width, height);
                if (sad < min_sad) {
                    min_sad = sad;
                    *best_x = (char)(ref_x - x);
                    *best_y = (char)(ref_y - y);
                }
            }
        }
    }
}

// Function to perform motion estimation for the entire frame
void motion_estimation(unsigned char *current, unsigned char *reference, int width, int height, char *motion_vectors) {
    for (int y = 0; y < height; y += BLOCK_SIZE) {
        for (int x = 0; x < width; x += BLOCK_SIZE) {
            char best_x = 0, best_y = 0;
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

    char *motion_vectors = (char *)malloc(2 * (width / BLOCK_SIZE) * (height / BLOCK_SIZE) * sizeof(char));
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