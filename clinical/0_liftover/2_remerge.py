import sys
def main():
    for line in sys.stdin.buffer:
        line=line.decode()
        line=line.rstrip('\n').split('\t')
        output=[]
        output.append(line[0])#chromosome
        output.append(line[3])#name, containing hg19 position
        output.append(line[2])#position
        #now we need to extract the ref and alt variants from the name
        split_name=line[3].split("_")
        #this will have chr, pos, ref, alt
        output.append(split_name[2])
        output.append(split_name[3])
        print("\t".join(output))


if __name__=="__main__":
      main()
