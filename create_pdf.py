#!/usr/bin/env python3

import os
from PIL import Image
import argparse

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("pdf_name", type=str, help="Name of the PDF file to create")
    parser.add_argument("--images", type=str, default="images")
    args = parser.parse_args()

    image_folder = os.path.abspath(args.images)
    pdf = args.pdf_name

    if not os.path.isdir(image_folder):
        print("Error! Image folder does not exist!")
        exit(1)

    if os.path.isfile(pdf):
        print("Error! PDF already exists!")
        exit(1)

    files = [f for f in os.listdir(image_folder)]
    files.sort()
    images = [Image.open(f"{image_folder}/{f}") for f in files]

    converted = []
    for image in images:
        rgb = Image.new("RGB", image.size, (255, 255, 255))
        rgb.paste(image, mask=image.split()[3])
        converted.append(rgb)

    converted[0].save(pdf, "PDF", resolution=100.0, save_all=True, append_images=converted[1:])

    for f in files:
        os.remove(f"{image_folder}/{f}")

if __name__ == "__main__":
    main()