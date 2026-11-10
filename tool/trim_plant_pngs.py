from pathlib import Path

from PIL import Image


PLANT_ASSETS = Path(__file__).resolve().parents[1] / "assets" / "illustrations" / "plants"
ALPHA_THRESHOLD = 20
HORIZONTAL_PADDING = 4
TOP_PADDING = 4


def trim_plant_image(path: Path) -> None:
    with Image.open(path) as source:
        image = source.convert("RGBA")

    alpha_mask = image.getchannel("A").point(
        lambda value: 255 if value > ALPHA_THRESHOLD else 0
    )
    bounds = alpha_mask.getbbox()
    if bounds is None:
        raise ValueError(f"No visible plant pixels found in {path}")

    cropped = image.crop(bounds)
    trimmed = Image.new(
        "RGBA",
        (
            cropped.width + HORIZONTAL_PADDING * 2,
            cropped.height + TOP_PADDING,
        ),
    )
    trimmed.alpha_composite(cropped, (HORIZONTAL_PADDING, TOP_PADDING))
    trimmed.save(path, format="PNG")


def main() -> None:
    for path in sorted(PLANT_ASSETS.glob("*.png")):
        trim_plant_image(path)
        with Image.open(path) as image:
            print(f"{path.name}: {image.width}x{image.height}")


if __name__ == "__main__":
    main()
