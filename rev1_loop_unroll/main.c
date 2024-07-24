#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

#define BLOCK_SIZE 16
#define SEARCH_RANGE 7

// Function to calculate SAD for a block with loop unrolling
unsigned short calculate_sad(unsigned char *current, unsigned char *reference, int x, int y, int ref_x, int ref_y, int width, int height) {
    unsigned short sad = 0;
    for (int i = 0; i < BLOCK_SIZE; i++) {
        for (int j = 0; j < BLOCK_SIZE; j += 4) {  // Unrolling by a factor of 4
            int cur_index0 = (y + i) * width + (x + j);
            int ref_index0 = (ref_y + i) * width + (ref_x + j);
            int cur_index1 = cur_index0 + 1;
            int ref_index1 = ref_index0 + 1;
            int cur_index2 = cur_index0 + 2;
            int ref_index2 = ref_index0 + 2;
            int cur_index3 = cur_index0 + 3;
            int ref_index3 = ref_index0 + 3;

            if (cur_index3 < width * height && ref_index3 < width * height) {
                sad += abs(current[cur_index0] - reference[ref_index0]);
                sad += abs(current[cur_index1] - reference[ref_index1]);
                sad += abs(current[cur_index2] - reference[ref_index2]);
                sad += abs(current[cur_index3] - reference[ref_index3]);
            }
        }
    }
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

int main() {
    // Example usage
    int width = 320;
    int height = 240;
    unsigned char *current_frame = (unsigned char *)malloc(width * height);
    unsigned char *reference_frame = (unsigned char *)malloc(width * height);

    // Initialize frames with some data (this should be replaced with actual frame data)
    for (int i = 0; i < width * height; i++) {
        current_frame[i] = rand() % 256;
        reference_frame[i] = rand() % 256;
    }

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
