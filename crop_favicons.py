from PIL import Image, ImageDraw, ImageOps
import os

files = [
    "FORTI MAIN.png",
    "FORTI design.png",
    "FORTI tech.png",
    "FORTI security.png"
]

def crop_to_circle(img_path):
    if not os.path.exists(img_path):
        print(f"File not found: {img_path}")
        return

    try:
        img = Image.open(img_path).convert("RGBA")
        
        # Create a circular mask
        mask = Image.new('L', img.size, 0)
        draw = ImageDraw.Draw(mask)
        draw.ellipse((0, 0) + img.size, fill=255)
        
        # Apply mask
        output = ImageOps.fit(img, img.size)
        output.putalpha(mask)
        
        # Save
        output.save(img_path)
        print(f"Processed: {img_path}")
        
    except Exception as e:
        print(f"Error processing {img_path}: {e}")

if __name__ == "__main__":
    for f in files:
        full_path = os.path.join(os.getcwd(), f)
        crop_to_circle(full_path)
