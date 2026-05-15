"""Download the Flickr8k dataset from Kaggle into data/.

Requirements:
    pip install kaggle
    ~/.kaggle/kaggle.json with your Kaggle API token (chmod 600)

Run from the repo root:
    python scripts/download_dataset.py
"""

import os
import shutil
import subprocess
import sys
from pathlib import Path

DATASET = "adityajn105/flickr8k"
ROOT = Path(__file__).resolve().parent.parent
DATA_DIR = ROOT / "data"


def main() -> int:
    DATA_DIR.mkdir(exist_ok=True)

    # Sanity check: kaggle CLI present?
    if shutil.which("kaggle") is None:
        print("ERROR: 'kaggle' CLI not found. Install with: pip install kaggle")
        return 1

    # Sanity check: credentials present?
    creds = Path.home() / ".kaggle" / "kaggle.json"
    if not creds.exists():
        print(f"ERROR: {creds} not found.")
        print("Get a token at https://www.kaggle.com/settings (Create New API Token)")
        print("and save it to that path (chmod 600).")
        return 1

    print(f"Downloading {DATASET} -> {DATA_DIR}")
    result = subprocess.run(
        [
            "kaggle", "datasets", "download",
            "-d", DATASET,
            "-p", str(DATA_DIR),
            "--unzip",
        ],
        check=False,
    )
    if result.returncode != 0:
        print("kaggle download failed.")
        return result.returncode

    # The Kaggle archive unzips to data/Images/ and data/captions.txt
    images_dir = DATA_DIR / "Images"
    if images_dir.exists():
        n = sum(1 for _ in images_dir.iterdir())
        print(f"Done. {n} images extracted to {images_dir}")
    else:
        print(f"WARNING: expected {images_dir} after unzip — check the archive layout.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
