import re
import unicodedata
import os

def clean_input(text):
    text = text.strip()
    text = unicodedata.normalize("NFKC", text)
    text = text.replace("“", "\"").replace("”", "\"")
    text = text.replace("‘", "'").replace("’", "'")
    text = text.replace("–", "-").replace("—", "-")
    text = re.sub(r"[.۔…]{2,}", ".", text)
    text = re.sub(r"\s+", " ", text)
    return text.strip()

def clean_translation(text):
    text = re.sub(r"[.۔…]+$", "", text)
    return text.strip()

input_file_path = "/home/f237809/training_Data/testsets/flores.urd_Arab"
output_dir = "/home/f237809/Indic/Outputs/"
output_file_path = os.path.join(output_dir, "flores.urd_Arab")

# Ensure output directory exists
os.makedirs(output_dir, exist_ok=True)

# Load and clean input lines
with open(input_file_path, "r", encoding="utf-8") as infile:
    raw_lines = [line.strip() for line in infile if line.strip()]
    sents = [clean_input(line) for line in raw_lines]

# Further clean and save
with open(output_file_path, "w", encoding="utf-8") as outfile:
    for sent in sents:
        cleaned = clean_translation(sent)
        outfile.write(cleaned + "\n")

print(f"Cleaned data saved to {output_file_path}")
