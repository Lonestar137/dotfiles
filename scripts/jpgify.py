# /// script
# requires-python = ">=3.13"
# dependencies = [ "pillow==12.0.0" ]
# ///

# dependencies = [ "pillow==9.0.0" ]
# To use -
# cd to directory with pngs and then run:
# uv run jpgify.sh
#
# uv: package=pillow==9.0.0

import os
import glob
import shutil
import time
from PIL import Image

def convert_images():
    # Create a temporary directory
    folder = f"/tmp/{os.path.basename(os.getcwd())}"
    os.makedirs(folder, exist_ok=True)

    # Get the list of PNG files
    png_files = glob.glob("*.png")
    if not png_files:
        print("No PNG files found.")
        return

    # Process each file
    for original_file in png_files:
        try:
            # Create a timestamp prefix
            timestamp = time.strftime("%Y%m%d_%H%M%S")
            # Prepare the new filename
            new_filename = f"{timestamp}_{os.path.splitext(original_file)[0]}.jpg"
            # Convert PNG to JPG
            with Image.open(original_file) as img:
                img.convert("RGB").save(new_filename, "JPEG")
            # Move the original file to the temporary directory
            shutil.move(original_file, folder)
            print(f"Converted and moved: {original_file} to {new_filename} and {folder}")
        except Exception as e:
            print(f"Failed to process {original_file}: {e}")
            continue

    # Cleanup: Remove original PNG files after successful conversion
    try:
        for png_file in png_files:
            os.remove(os.path.join(folder, png_file))
        print("Cleaned up original PNG files.")
    except Exception as e:
        print(f"Failed to clean up PNG files: {e}")

if __name__ == "__main__":
    convert_images()
