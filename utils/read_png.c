// read_png.c
#include <stdio.h>
#include <stdlib.h>
#include <png.h>

// Function to read PNG image data from a file using libpng
unsigned char* read_png_image(const char *filename, int *width, int *height) {
    FILE *fp = fopen(filename, "rb");
    if (!fp) {
        perror("Error opening file");
        exit(EXIT_FAILURE);
    }

    png_structp png = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
    if (!png) {
        perror("Error creating png read struct");
        exit(EXIT_FAILURE);
    }

    png_infop info = png_create_info_struct(png);
    if (!info) {
        perror("Error creating png info struct");
        exit(EXIT_FAILURE);
    }

    if (setjmp(png_jmpbuf(png))) {
        perror("Error during png creation");
        exit(EXIT_FAILURE);
    }

    png_init_io(png, fp);
    png_read_info(png, info);

    *width = png_get_image_width(png, info);
    *height = png_get_image_height(png, info);
    png_byte color_type = png_get_color_type(png, info);
    png_byte bit_depth = png_get_bit_depth(png, info);

    if (bit_depth == 16)
        png_set_strip_16(png);

    if (color_type == PNG_COLOR_TYPE_PALETTE)
        png_set_palette_to_rgb(png);

    if (color_type == PNG_COLOR_TYPE_GRAY && bit_depth < 8)
        png_set_expand_gray_1_2_4_to_8(png);

    if (png_get_valid(png, info, PNG_INFO_tRNS))
        png_set_tRNS_to_alpha(png);

    if (color_type == PNG_COLOR_TYPE_RGB ||
        color_type == PNG_COLOR_TYPE_GRAY ||
        color_type == PNG_COLOR_TYPE_PALETTE)
        png_set_filler(png, 0xFF, PNG_FILLER_AFTER);

    if (color_type == PNG_COLOR_TYPE_GRAY ||
        color_type == PNG_COLOR_TYPE_GRAY_ALPHA)
        png_set_gray_to_rgb(png);

    png_read_update_info(png, info);

    unsigned char *image_data = (unsigned char*) malloc(png_get_rowbytes(png, info) * (*height));
    if (!image_data) {
        perror("Error allocating memory");
        exit(EXIT_FAILURE);
    }

    png_bytep *row_pointers = (png_bytep*) malloc(sizeof(png_bytep) * (*height));
    for (int y = 0; y < *height; y++) {
        row_pointers[y] = (png_byte*)(image_data + y * png_get_rowbytes(png, info));
    }

    png_read_image(png, row_pointers);

    fclose(fp);
    png_destroy_read_struct(&png, &info, NULL);
    free(row_pointers);

    return image_data;
}

// Function to write image data to a text file
void write_image_to_text(const char *filename, unsigned char *image_data, int width, int height) {
    FILE *file = fopen(filename, "w");
    if (!file) {
        perror("Error opening file");
        exit(EXIT_FAILURE);
    }
    for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
            fprintf(file, "%u ", image_data[i * width + j]);
        }
        fprintf(file, "\n");
    }
    fclose(file);
}

int main() {
    int width, height;

    unsigned char *current_frame = read_png_image("../assets/current_frame.png", &width, &height);
    unsigned char *reference_frame = read_png_image("../assets/reference_frame.png", &width, &height);

    write_image_to_text("current_frame.txt", current_frame, width, height);
    write_image_to_text("reference_frame.txt", reference_frame, width, height);

    free(current_frame);
    free(reference_frame);

    return 0;
}
