
# BUSCO
![Busco Results](/results/busco/busco_figure.png)

## Whole Genome Assembly
### flye
	***** Results: *****

	C:99.3%[S:97.7%,D:1.6%],F:0.0%,M:0.7%,n:4596	   
	4564	Complete BUSCOs (C)			   
	4489	Complete and single-copy BUSCOs (S)	   
	75	Complete and duplicated BUSCOs (D)	   
	2	Fragmented BUSCOs (F)			   
	30	Missing BUSCOs (M)			   
	4596	Total BUSCO groups searched		   

    Assembly Statistics:
        87	Number of scaffolds
        87	Number of contigs
        134695035	Total length
        0.000%	Percent gaps
        6 MB	Scaffold N50
        6 MB	Contigs N50

- few missing genes
- low fragmentation
- maximum gene completeness

### hifiasm
    ***** Results: *****

	C:95.7%[S:94.1%,D:1.6%],F:0.1%,M:4.2%,n:4596	   
	4395	Complete BUSCOs (C)			   
	4323	Complete and single-copy BUSCOs (S)	   
	72	Complete and duplicated BUSCOs (D)	   
	6	Fragmented BUSCOs (F)			   
	195	Missing BUSCOs (M)			   
	4596	Total BUSCO groups searched		   

    Assembly Statistics:
	520	Number of scaffolds
	520	Number of contigs
	149560242	Total length
	0.000%	Percent gaps
	19 MB	Scaffold N50
	19 MB	Contigs N50

- number of missing genes higher than for flye or LJA
- many contigs -> high fragmentation
- long contigs but fragmented and less complete
- for strucutral analyses

### LJA
	***** Results: *****

	C:99.3%[S:97.7%,D:1.6%],F:0.0%,M:0.7%,n:4596	   
	4563	Complete BUSCOs (C)			   
	4488	Complete and single-copy BUSCOs (S)	   
	75	Complete and duplicated BUSCOs (D)	   
	2	Fragmented BUSCOs (F)			   
	31	Missing BUSCOs (M)			   
	4596	Total BUSCO groups searched		   

    Assembly Statistics:
	517	Number of scaffolds
	517	Number of contigs
	140518402	Total length
	0.000%	Percent gaps
	16 MB	Scaffold N50
	16 MB	Contigs N50

- few missing genes
- high fragmentation
- high BUSCO completness with high contiguity -> good balance
### Question: How do your genome assemblies look according to your BUSCO results?
- flye and LJA high completeness with onyl few missing genes or fragmented BUSCOs
    - nearly all expected conserved genes persent and intact
    - very good quality in terms of gene content
- hifiasm sligthly weaker in completeness & more missing BUSCOs
    - parts of gene space absent or unrsolved

### Question: Is one genome assembly better than the other?
- Flye: cleanest, most compact assembly
- LJA: high BUSCO completeness but more contigs and larger assembly size
- hifiasm: longest contigs but assembly size inflated and completeness lower

## Transcriptome Assembly
### Trinity
	***** Results: *****

	C:79.4%[S:38.8%,D:40.6%],F:3.2%,M:17.4%,n:4596	   
	3649	Complete BUSCOs (C)			   
	1782	Complete and single-copy BUSCOs (S)	   
	1867	Complete and duplicated BUSCOs (D)	   
	147	Fragmented BUSCOs (F)			   
	800	Missing BUSCOs (M)			   
	4596	Total BUSCO groups searched		   

    Assembly Statistics:
	44145	Number of scaffolds
	44145	Number of contigs
	59075595	Total length
	0.000%	Percent gaps
	1 KB	Scaffold N50
	1 KB	Contigs N50

- modereate recovery of expected conserved genes
- high duplication (redundant transcipts)
- high missing gene content
- highly redundant and fragmented with substantial missing content

### Question: How does your transcriptome assembly look? Are there many duplicated genes?
- highly redundant and fragmented with substantial missing content
- yes, many duplicated genes

### Question: Can you explain the differences with the whole genome assemblies?
- much more fragmented and redundant
- higher duplication in transcriptome expected but 40% too high
    - high duplication + low completeness indicates poor/over-assembled transcriptome rather than healthy biological complexity