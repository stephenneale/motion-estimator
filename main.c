#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

#define BLOCK_SIZE 16
#define SEARCH_RANGE 7

// Function to calculate SAD for a block
int calculate_sad(unsigned char *current, unsigned char *reference, int x, int y, int ref_x, int ref_y, int width, int height) {
    int sad = 0;
    for (int i = 0; i < BLOCK_SIZE; i++) {
        for (int j = 0; j < BLOCK_SIZE; j++) {
            int cur_index = (y + i) * width + (x + j);
            int ref_index = (ref_y + i) * width + (ref_x + j);
            if (cur_index < width * height && ref_index < width * height) {
                sad += abs(current[cur_index] - reference[ref_index]);
            }
        }
    }
    return sad;
}

// Function to find the best match for a block in the reference frame
void find_best_match(unsigned char *current, unsigned char *reference, int x, int y, int width, int height, int *best_x, int *best_y) {
    int min_sad = INT_MAX;
    for (int i = -SEARCH_RANGE; i <= SEARCH_RANGE; i++) {
        for (int j = -SEARCH_RANGE; j <= SEARCH_RANGE; j++) {
            int ref_x = x + j;
            int ref_y = y + i;
            if (ref_x >= 0 && ref_y >= 0 && ref_x + BLOCK_SIZE < width && ref_y + BLOCK_SIZE < height) {
                int sad = calculate_sad(current, reference, x, y, ref_x, ref_y, width, height);
                if (sad < min_sad) {
                    min_sad = sad;
                    *best_x = ref_x;
                    *best_y = ref_y;
                }
            }
        }
    }
}

// Function to perform motion estimation for the entire frame
void motion_estimation(unsigned char *current, unsigned char *reference, int width, int height, int *motion_vectors) {
    for (int y = 0; y < height; y += BLOCK_SIZE) {
        for (int x = 0; x < width; x += BLOCK_SIZE) {
            int best_x = 0, best_y = 0;
            find_best_match(current, reference, x, y, width, height, &best_x, &best_y);
            int index = (y / BLOCK_SIZE) * (width / BLOCK_SIZE) + (x / BLOCK_SIZE);
            motion_vectors[2 * index] = best_x - x;
            motion_vectors[2 * index + 1] = best_y - y;
        }
    }
}

int main() {
    // Example usage
    int width = 640;
    int height = 480;
    unsigned char *current_frame = (unsigned char *)malloc(width * height);
    unsigned char *reference_frame = (unsigned char *)malloc(width * height);

    // Initialize frames with some data (this should be replaced with actual frame data)
    for (int i = 0; i < width * height; i++) {
        current_frame[i] = rand() % 256;
        reference_frame[i] = rand() % 256;
    }

    int *motion_vectors = (int *)malloc(2 * (width / BLOCK_SIZE) * (height / BLOCK_SIZE) * sizeof(int));
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
