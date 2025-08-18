import sys

def main():
    for line in sys.stdin.buffer:
        line=line.decode()
        line=line.rstrip('\n').split('\t')
        #each line is [chrom, pos, id, ref, alt, info]
        if len(line[3]) < 20 and len(line[4])<20:
            print("\t".join(line))

if __name__=="__main__":
    main()
