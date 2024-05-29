import xml.etree.ElementTree as ET

if __name__ == '__main__':

    genome_list = open("genomes-all.txt").read().strip().split("\n")
    table = []
    biosample_list = []
    for genome in genome_list:
        print(genome)
        try:
            tree = ET.parse(f"data/sra-docs/{genome}.xml")
            root = tree.getroot()
            biosample_element = root.find(".//Biosample")

            if biosample_element is not None:
                biosample_content = biosample_element.text
                biosample_list.append(biosample_content)
            table.append(f"{genome}\t{biosample_content}")
        except:
            print("File not found")
    open("biosamples.txt", "w").write("\n".join(biosample_list))
    open("biosamples.tsv", "w").write("\n".join(table))
    print("Done")