
# fastqc
## Whole genome PacBio Hifi reads for accession Edi-0
### read length
- 61 - 236'963 bp

### Quality
- messed up per sequence GC-content
    - chloroplast/mitochondiral DNA
- High presence of PolyA adapters

## whole transcriptome Illumina RNAseq Sha
### read length
- 101 bp

### Quality
- per base sequence quality drops drastically towards the end of the read
- per base sequence content pairs messed up
- high sequence duplication levels → PCR amplification?
- overrepresented sequences (2) → contamination?

# fastp
## whole transcriptome Illumina RNAseq Sha
- How many reads where trimmed/filtered and did the quality improve?
        - total number of bases before filtering: 4.569377 G $\approx$ 4’569’377’000 bp
        - total number of bases after filtering: 4.061965 G $\approx$ 4’061’965 ‘000 bp
        - yes the quality did improve


## PacBio Hifi reads for accession Edi-0
- What kind of coverage do you expect from the Pacbio WGS reads? 
    - Coverage (X)= Total bases sequence/Genome size
    - Genome size *Arabidopsis thaliana* ~135Mb $\approx$ 135’000’000 bp
    - EDI-0 total number of bases: 5.113481 G $\approx$ 5’113’481’000 bp
    - EDI-0: $\text{Coverage(X)} = \frac{5'113'481'000}{135'000'000} \approx 37.88$
    - This is a solid coverage for PacBio HiFi WGS and sufficient for a high-quality de novo assembly of *Arabidopsis thaliana*.


# k-mer counting / GenomeScope 
## Edi-0
- max k-mer coverage = 3'000, k-mer size = 21
### estimated genome size
- 127'666'751 bp
- expected: 120 - 130 mb
--> estimation close to expection  

### % of heterozygousity
- 0.045%
- low heterozygousity expected due to selfing
--> estimation as expected

### coverage expected
- 28.2x
- expected around 30-40x
--> a bit low, maybe problems in assembly

### Why are we using canonical k-mers? (use Google)
- howl genome sequencing indifferent from direction
- does not make sense to count k-mer and reverse k-mer as two
- pool together k-mer and reverse k-mer into a single count → canonical k-mer

Link to GenomeScope Analysis: http://genomescope.org/genomescope2.0/analysis.php?code=C85cIoUQPwUSv993nqyc

### Class Discussion

- short k-mers not unique in the genome
    - the larger the genome the larger the k-mer size should be
    - too large leads to k-mer with sequencing error (1% sequencing error, k-mer = 100 → 1 sequencing error)
- max k-mer coverage set to -1
    - limit k-mer count
    - cut input file to only show k-mers above max kmer coverage
    - reasoning to set filter threshold high (3000): k-mer that occurs many many times → nucleus, mitochondria, chloroplast → exclude for better results → set max kmer such that you cut off before peak on the right of the graph
- can have thousands of repeats in genome
- when cutting away k-mers we could loose those repeats and get a wrong genome size estimation so be careful and get to know your organism
