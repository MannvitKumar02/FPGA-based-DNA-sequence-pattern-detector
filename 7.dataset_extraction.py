# Dataset Extraction Script for Smith-Waterman DNA Similarity Detection
# Extracts chimpanzee and COVID-19 DNA sequences from source files

import pandas as pd

# --- Extract Chimpanzee DNA ---
with open("chimpanzee.txt", 'r') as file:
    data = file.readlines()
    dna = ""
    for i in range(1, len(data)):
        dna += data[i].split('\t')[0]

with open("chimpanzee_dna.txt", 'w') as file:
    file.write(dna)

print(f"Chimpanzee DNA extracted: {len(dna)} bases written to chimpanzee_dna.txt")

# --- Extract COVID-19 DNA ---
df = pd.read_csv("Covid.csv")
dna = df["SEQ"]

with open("covid_dna.txt", "w") as f:
    f.write(dna[0])

print(f"COVID DNA extracted: {len(dna[0])} bases written to covid_dna.txt")
