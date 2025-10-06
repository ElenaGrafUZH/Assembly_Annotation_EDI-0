# QUAST

## Without Reference

### flye
- number of contigs:  86
    - genome assembled in long continuous pieces
- total length: 134'694'543 b -> ~ 134.7 Mb
    - close to expected genome size (135 Mb)
- N50: ~7 Mb
    - the higher the number the more contiguous assembly
    - good contiguity
- GC content: 36.35%
    - close to expected content in Arabidopsis
- Conclusion: clean, compact assembly with expected genome size and good continuity
### hifiasm
- number of contigs:  520
    - higher than flye
    - fewer is better
    - more fragmented
- total length: 149'569'242 b -> ~ 149.6 Mb
    - higher than expected genome size (135 Mb)
    - contaminaton or duplication?
- N50: ~19 Mb
    - the higher the number the more contiguous assembly
    - higher than with flye
- GC content: 36.83%
    - close to expected content in Arabidopsis
Conclusion: very contiguous contigs, but inflated assembly size suggests redundnat sequence or uncollapsed haplotypes

### LJA
- number of contigs:  517
    - higher than flye
    - similar to hifiasm
    - fewer is better
- total length: 140'518'402 b -> ~ 140.5 Mb
    - higher than expected genome size (135 Mb)
    - duplicated sequences or contamination?
- N50: ~16 Mb
    - the higher the number the more contiguous assembly
    - higher than with flye
    - a bit lower than hifiasm
- GC content: 36.98%
    - close to expected content in Arabidopsis
- Conclusios: balanced between flye and hifiasm; good contiguity, slighlty too large (duplications?)

## With Reference

### flye
- Number of missassemblies: 6227
    - lower better
    - high counts suggest chimeric joins or structural artifacts
- number of missassembled contigs: 37
- types of missassemblies (6227):
    - relocations: 4005
    - translocations: 2181
    - inversions: 41
- indels: 142501
- genome fractoin: 90.895%
    - precentage of reference genome covered by assembly
    - higher -> more complete coverage
- fully unaligned contigs: 0
- Conclusion: good overall alignment and coverage; moderate strucutral inconsistencies (variation or local misjoins?)

### hifiasm

### LJA
- Number of missassemblies: 8248
    - lower better
    - high counts suggest chimeric joins or structural artifacts
    - higher structural error rate than flye
- number of missassembled contigs: 259
- types of missassemblies (8248):
    - relocations: 5848
    - translocations: 2367
    - inversions: 33
- indels: 146394
- genome fractoin: 90.971%
    - precentage of reference genome covered by assembly
    - higher -> more complete coverage
- fully unaligned contigs: 2
- Conclusion: Sllightly more complete but structurally less consistent assembly

## Questions
### How do your genome assemblies look according to your QUAST results? Is one genome assembly better than the other?
- all 3 assemblies good genome coverage and similar GC content -> overall accurate reconstructions
- flye: fewest contigs, genome size closest to expected -> compact and clean assembly
- hifiasm & LJA larger total sizes and more contigs but higher N50 values
- flye produces most balanced assembly, while hifiasm has highest contiguity but possible redundancy; LJA in between

### What additional information you get if you have a reference available?
- missassemblies
- unaligned contigs
- genome fraction (precentage of reference genome covered by assembly)
- provides information about structural accuracy and completeness at sequence level