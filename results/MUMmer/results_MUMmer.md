# MUMmer
nucmer and mummer used to compare assebmled genomes aginst a reference genome.

## Dot Plot
- reference sequence represented on x axis
- assembly (query) sequence representedon y axis
- for each match between reference and assembly a dot/line is drawn
- violet represent forward matches
- blue represents reverse matches
- shows how similar the two sequences are

## flye vs reference genome
![image](/results/MUMmer/flye_vs_ref_plot.png)
- some small inversions
- gaps between violet lines and shifted to right and top --> insertion in assembly

## hifiasm vs reference genome
![image](/results/MUMmer/hifiasm_vs_ref_plot.png)
- some inversions
- some inversions and translocations (ptg0000031)
- gaps between violet lines; shifted to right and top --> insertion in assembly
gaps between violet lines; shifted to the right and down --> insertion in reference or deletion in assembly?
- more fragmented than other two

## lja vs reference genome
![image](/results/MUMmer/lja_vs_ref_plot.png)
- some small inversions
- gaps between violet lines and shifted to right and top --> insertion in assembly

## flye vs hifiasm
![image](/results/MUMmer/flye_vs_hifiasm_plot.png)
- a lot of inversions and translocations

## flye vs lja
![image](/results/MUMmer/flye_vs_lja_plot.png)
- a lot of inversions and translocations
## hifiasm vs lja
![image](/results/MUMmer/hifiasm_vs_lja_plot.png)
- best aligned, most similar