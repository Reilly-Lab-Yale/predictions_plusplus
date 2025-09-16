#re-arrange columns, split every 50k lines
#input cols are
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
import sys
def main():
    output_root=sys.argv[1]
    output_file=None
    line_counter=50000
    chunk=-1
    for line in sys.stdin.buffer:
        
        if line_counter>=50000:
            if output_file:
                output_file.close()
            chunk=chunk+1
            output_file=open(f"{output_root}_chunk_{chunk}.tsv","w")
            line_counter=0
        
        line=line.decode()
        line=line.rstrip('\n').split('\t')
        #output cols are chrom, pos, name, ref, alt
        output=line[0:5]
        output_file.write("\t".join(output))
        output_file.write("\n")

        line_counter=line_counter+1
    output_file.close()
        

if __name__=="__main__":
    main()
