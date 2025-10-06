# merqury
Tool to evaluate genome assemblies with k-mers. It compares k-mers of an assembly with the k-mers of unassembled high-accuracy reads (e.g. Illumina or PacBio HiFi reads). With this approach the quality and completeness of an assembly can be estimated without the need of a high quality reference genome.

## flye
- total number of erroneous k-mers: 317
    - low
    - almost perfect consensus
- total assembly length: 134'693'556 bp
    - close to expected genome size of A. thaliana
- consensus QV: 68.84
    - ~1 error per 7.6 million bases
    - high quality
- error rate: 1.31x10^-7
    - low
    - almost error-free assembly
- completness: 99.34%

## hifiasm
- total number of erroneous k-mers: 8041
    - high
- total assembly length: 149'551'402 bp
    - larger than expected genome size of A. thaliana
- consensus QV: 55.25
    - ~1 error per 0.3 million bases
- error rate: 2.99x10^-6
    - higher than flye
-completness: 96.19%

## LJA
- total number of erroneous k-mers: 5816
    - high
- total assembly length: 140'509'613 bp
    - larger than expected genome size of A. thaliana
- consensus QV: 56.38
    - ~1 error per 0.4 million bases
- error rate: 2.3x10^-6
    - higher than flye
- completness: 99.42%

## Questions

### What are the consensus quality QV and error rate values of your assemblies?
#### flye
- consensus QV: 68.84
- error rate: 1.31x10^-7
#### hifiasm
- consensus QV: 55.25
- error rate: 2.99x10^-6
#### lja
- consensus QV: 56.38
- error rate: 2.3x10^-6

-> fly eproduces most accurate consensus  
-> hifiasm & LJA good but not best consensus quality (higher duplications or less effective pooling?)  


### What is the estimated completeness of your assemblies?
- flye: 99.34%
    - very high
    - almost all k-mers from read set present in assembly
- hifiasm: 96.19%
    - slightly lower than flye
    - some k-mers missing
    - collapsed regions or gaps?
    - lower completness might explain why it had higher error rate in QV
- LJA: 99.42%
    - like flye

### How does your copy-number spectra look like? Do they confirm the expected coverage?
### flye
- 1-copy k-mers: peak at ~28x at ~6.9x10^6
- grey peak: k-mers present in raeds but missing form assembly
    - very small
- some duplication around 40x-70x
- flye captured nearly all k-mers, single copy regions match expected coverage, very clean

![image](/results/merqury/flye.flye_hifi_assembly.spectra-cn.fl.png)

### hifiasm
- read-only: peak at round 28x at ~6.6x10^6
- some read-only from 20x to 40x: present in reads but not assembly -> colapsed duplications, unresolved repeats, missing sequences?
- some duplication around 40x-70x
- more missing or misrepresented sequences; consistens with slightly lower completness and lower QV

![image](/results/merqury/hifiasm.hifiasm_Edi-0.asm.bp.p_ctg.spectra-cn.fl.png)

### LJA
- similar to flye
- assembly highly complete and accurate with mininmal missing sequences

![image](/results/merqury/lja.lja_assembly.spectra-cn.fl.png)

### Does one assembly perfom better than the other?
- flye has highest QV and smallest error rate
- lja and flye high completness
- hifiasm godd but slightly lwoer WV and completeness