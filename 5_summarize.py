import pandas as pd

if __name__ == '__main__':
    genome_list = open("genomes-all.txt").read().strip().split("\n")
    sequences = ['LTR', 'LTR+Int+LTR', 'ENS-1-x2', 'ENS-1-x3', 'ENS-1-x4', 'FlankL+LTR1', 'FlankL', 'FlankR', 'LTR+FlankR']
    df = pd.DataFrame(index=genome_list, columns=['an']+sequences)

    entries = open("data/mapping-plain.tsv").read().strip().split("\n")
    entries = [e.split() for e in entries]
    for seq, an, val in entries:
        df[seq][an] = val
    df.to_csv("data/mapping.csv", sep=",", header=True)
    print()