# Breeder Notebook
A [Jupyter Docker Stack](https://jupyter-docker-stacks.readthedocs.io/en/latest/) for plant scientists and [breeders](https://en.wikipedia.org/wiki/Plant_breeding).

## What's included?
This Docker image includes software broadly useful for bioinformaticians, with a specific focus on plant scientists and plant breeders.

If there is software that you think should be included here but isn't, please [open an issue](https://github.com/maize-genetics/breeder-notebook/issues/new/choose) to discuss! You can also easily extend any of the existing Jupyter Docker Stacks with software for your specific case ([that's what we did](https://github.com/maize-genetics/breeder-notebook/blob/main/Dockerfile#L1)).

### Buckler Lab Software
Software developed by members of the [Buckler Lab](https://maizegenetics.net):
* [TASSEL](https://tassel.bitbucket.io/)
* The [Practical Haplotype Graph](https://www.maizegenetics.net/phg)
* [rTASSEL](https://rtassel.maizegenetics.net/) and [rPHG](https://rphg.maizegenetics.net/)

### Innovation Lab for Crop Improvement
Software developed by members of the [Feed the Future Innovation Lab for Crop Improvement](https://ilci.cornell.edu/):
* [BrAPI](https://brapi.org/) Helper JupyterLab extension that provides GUI for managing database connections to breeding management systems (e.g. [BMS](https://integratedbreeding.net/), [BreedBase](https://breedbase.org/), [GIGWA](https://gigwa.southgreen.fr/gigwa/))
* Templates (using [JupyterLab Templates](https://github.com/finos/jupyterlab_templates)) providing instruction on common bioinformatics and data science pipelines for breeders

### Common Bioinformatics Tools
* [minimap2](https://github.com/lh3/minimap2)
* [samtools & bcftools](http://www.htslib.org/)
* [bwa (Burrow-Wheeler Aligner)](https://github.com/lh3/bwa)

### Programming Languages
The JupyterLab environment comes with [kernels](https://docs.jupyter.org/en/latest/projects/kernels.html) for the following:
* [Python](https://www.python.org/)
* [R](https://www.r-project.org/)
* [Kotlin](https://kotlinlang.org/)
