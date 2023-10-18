import xml.etree.ElementTree as ET

if __name__ == '__main__':

    genome_list = open("genomes-all.txt").read().strip().split("\n")
    table = []
    biosample_list = []
    for genome in genome_list:
        genome = "SRR19880162"
        tree = ET.parse(f"data/sra-docs/{genome}.xml")
        root = tree.getroot()
        biosample_element = root.find(".//Biosample")

        if biosample_element is not None:
            biosample_content = biosample_element.text
            biosample_list.append(biosample_content)
        table.append(f"{genome}\t{biosample_content}")
    open("biosample.txt", "w").write("\n".join(biosample_list))
    open("biosample.tsv", "w").write("\n".join(table))