# Flickr Image Captioning

Image captioning model built on the Flickr8k dataset. Coursework assignment **AS1 (LQOO56)**.

## Overview

Trains a deep learning model that generates natural-language captions for images. Uses a CNN encoder to extract visual features from the Flickr8k images and an RNN/Transformer decoder to produce captions, supervised on the five human-written captions per image.

## Project structure

```
flickr-image-captioning/
├── AS1_Image_captioning_LQOO56.ipynb   # Main notebook (training + evaluation)
├── data/
│   ├── captions.txt                    # Image -> caption mapping (40,455 rows)
│   └── Images/                         # 8,091 Flickr8k images (NOT in repo - download below)
├── scripts/
│   └── download_dataset.py             # Pull Flickr8k from Kaggle
├── requirements.txt
├── .gitignore
└── README.md
```

## Getting the dataset

The 1.1 GB Flickr8k image set is not tracked in git. Re-download it like this:

1. Get a Kaggle API token from https://www.kaggle.com/settings (Account -> Create New API Token) and save the resulting `kaggle.json` to `~/.kaggle/kaggle.json` (chmod 600).
2. Run:

```bash
pip install kaggle
python scripts/download_dataset.py
```

This drops the images into `data/Images/` and refreshes `data/captions.txt`.

## Running the notebook

```bash
pip install -r requirements.txt
jupyter notebook AS1_Image_captioning_LQOO56.ipynb
```

Or open it in Google Colab and mount your Drive / re-run the dataset download cell.

## Requirements

See `requirements.txt`. Core stack is PyTorch (or TensorFlow, depending on which path the notebook takes), torchvision/transformers, pandas, and NLTK for BLEU scoring.

## Dataset

[Flickr8k](https://www.kaggle.com/datasets/adityajn105/flickr8k) — 8,091 images, each with 5 captions written by Mechanical Turk workers. Standard benchmark for image-captioning research.

## Author

LQOO56 — coursework submission.
