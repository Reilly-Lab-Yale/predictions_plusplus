import sys

def main():

    chromosomes=[f"chr{i}" for i in range(1,22+1)]
    chromosome_pairs=[i for i in zip(chromosomes,chromosomes[::-1])][:11]
    #lookup table : which chromosomes to which pairs
    chr_lut={
        k:f"{a}_{b}"
        for a,b in chromosome_pairs
        for k in (a,b)
    }
    #change chromosome pairs to be just text
    chromosome_pairs=[f"{key}_{val}" for key, val in chromosome_pairs]

    #create output files
    #file_handles maps chr pair to each file handle...
    file_handles={}
    for chr_pair in chromosome_pairs+["default"]:
         file_handles[chr_pair]=open(f"/home/mcn26/project_pi_skr2/mcn26/clinical_by_chromosome/{chr_pair}.tsv","w")

    #for each input line / variant...
    for line in sys.stdin.buffer:
        line=line.decode()
        
        #split on tabs. line[0] is the chromosome
        line=line.rstrip('\n').split('\t')

        output_pair=chr_lut.get(line[0],"default")

        file_handles[output_pair].write("\t".join(line)+"\n")
    #close files
    for key in file_handles:
         file_handles[key].close()

if __name__=="__main__":
      main()


