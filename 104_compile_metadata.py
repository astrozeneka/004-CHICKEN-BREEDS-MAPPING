import os
from glob import glob
import xml.etree.ElementTree as ET
import pandas as pd

if __name__ == '__main__':
    genome_list = open("genomes-all.txt").read().strip().split("\n")
    sra_dict = open("biosamples.tsv").read().strip().split("\n")
    sra_dict = [a.split("\t") for a in sra_dict]
    bios_dict = {a:b for a,b in sra_dict}

    df = pd.DataFrame(index=genome_list, columns=["breed"])
    for genome in genome_list:
        fn = f"data/biosamples-docs/{bios_dict[genome]}.xml"
        if not os.path.exists(fn):
            continue
        try:
            tree = ET.parse(fn)
            breed_element = tree.find(".//Attribute[@attribute_name='breed']")
            breed_element = tree.find(".//Attribute[@attribute_name='isolate']") if breed_element is None else breed_element
            if breed_element is not None:
                breed = breed_element.text
                df['breed'][genome] = breed
        except:
            print("Parse error")
    df.to_csv("data/breed-names.csv", sep=",", header=True)
    print()
