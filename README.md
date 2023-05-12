# green-fuzzing-artifacts

Artifacts for the paper: ***Green Fuzzing :seedling:: A Saturation-based Stopping Criterion using Vulnerability Prediction***

## :seedling: Publication

<a href=""><img src="https://raw.githubusercontent.com/sphl/green-fuzzing-artifacts/main/paper_thumbnail.png" align="right" width="280"></a>

- [Stephan Lipp](https://www.cs.cit.tum.de/sse/lipp/) (TU Munich)
- [Daniel Elsner](https://www.cs.cit.tum.de/sse/elsner/) (TU Munich)
- [Severin Kacianka](https://www.cs.cit.tum.de/sse/kacianka/) (TU Munich)
- [Alexander Pretschner](https://www.cs.cit.tum.de/sse/pretschner/) (TU Munich)
- [Marcel Böhme](https://mboehme.github.io/) (MPI-SP, Monash University)
- [Sebastian Banescu](https://github.com/banescusebi) (TU Munich)

```bibtex
@inproceedings{GreenFuzzing2023,
    title     = {Green Fuzzing: A Saturation-based Stopping Criterion using Vulnerability Prediction},
    author    = {Lipp, Stephan and Elsner, Daniel and Kacianka, Severin and Pretschner, Alexander and B{\"o}hme, Marcel and Banescu, Sebastian},
    year      = 2023,
    booktitle = {Proceedings of the ACM SIGSOFT International Symposium on Software Testing and Analysis},
    series    = {ISSTA'23},
    numpages  = 13
}
```

### Overview

Fuzzing is a widely used automated testing technique that uses random inputs to provoke program crashes indicating security breaches. A difficult but important question is when to stop a fuzzing campaign. Usually, a campaign is terminated when the number of crashes and/or covered code elements has not increased over a certain amount of time. To avoid premature termination when a ramp-up time is needed before vulnerabilities are reached, code coverage is often preferred over crash count as the stopping criterion. However, a campaign might only increase the coverage on non-security-critical code or repeatedly trigger the same crashes. For these reasons, both code coverage and crash count tend to overestimate the fuzzing effectiveness, unnecessarily increasing the duration and thus the cost of the testing process.

This study explores the tradeoff between the amount of saved fuzzing time and number of missed bugs when stopping campaigns based on the saturation of covered, potentially vulnerable functions rather than triggered crashes or regular function coverage. In a large-scale empirical evaluation of 30 open-source C programs with a total of 240 security bugs and 1,280 fuzzing campaigns, we first show that binary classification models trained on software with known vulnerabilities (CVEs), using lightweight ML features derived from findings of static application security testing tools and proven software metrics, can reliably predict (potentially) vulnerable functions. Second, we show that our proposed stopping criterion terminates 24-hour fuzzing campaigns 6-12 hours earlier than the saturation of crashes and regular function coverage while missing (on average) fewer than 0.5 out of 12.5 contained bugs.

## :seedling: Getting Started

### Required Software

The analysis performed in this study is made available in the form of an [R](https://www.r-project.org/about.html) Jupyter notebook called `analysis.ipynb`. To run this notebook, we recommend using [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/getting_started/overview.html), a web-based interactive development environment for R (and Python) code. JupyterLab can be installed either via different package management tools (cf. the instructions [here](https://jupyterlab.readthedocs.io/en/stable/getting_started/installation.html)) or (as in this tutorial) via [Jupyter Docker Stacks](https://jupyter-docker-stacks.readthedocs.io/en/latest/), which provide ready-to-use Docker images containing Jupyter applications. For this, ensure you have Docker installed on your machine; if not, detailed documentation explaining how to install Docker on various operating systems can be found [here](https://docs.docker.com/get-docker/).

### Installing and Running JupyterLab

Follow the steps below to run `analysis.ipynb` using JupyterLab.

#### Step 1: Creating a JupyterLab Docker Container

Run the command

```bash
docker run -p 8888:8888 -v <artifact-dir>:/home/jovyan/work jupyter/r-notebook:latest
```

in the terminal to download the latest `jupyter/r-notebook` image from [Docker Hub](https://hub.docker.com/r/jupyter/scipy-notebook).

Here, `<artifact-dir>` must be replaced with the directory path to this artifact repository. This directory is then mounted to `/home/jovyan/work` within the Docker container.

After downloading the image, a Jupyter server container is automatically launched, with the container's internal port `8888` exposed to the same port on the host machine.

#### Step 2: Opening the Jupyter Notebook

Launch JupyterLab by entering `http://127.0.0.1:8888/?token=<token>` in your web browser, with `<token>` being output to the terminal in **step 1**. Next, navigate in the file browser (left pane) to the directory containing the artifacts and open the `analysis.ipynb` notebook.

#### Step 3: Installing Required R Packages

In the notebook, first run

```r
install.packages("pacman")
library(pacman)`
```

to install the R package manager [pacman](https://www.rdocumentation.org/packages/pacman/versions/0.5.1).

Secondly, execute

```r
pacman::p_load(caret, devtools, doParallel, dplyr, gbm, ggcorrplot, ggplot2, ggtext, kernlab, Metrics, modelr, parallel, plotROC, pROC, randomForest, RColorBrewer, scales, stringr, tidyr, tidyverse)
```

to install and load all required R packages.

<font size=3>:tada: **Everything is now set up to ( re-)run the analysis in the Jupyter notebook** :tada:</font>

## :seedling: Detailed Description

### Dataset

#### ML-based Vulnerability Prediction

- `ml_feature_data.csv`: Contains the feature data to train and test the machine-learned vulnerability prediction models.
- `ml_model_config.csv`: Contains the ML models and cutoff values for each subject program that we use in the evaluation.
- `ml_vuln_prediction.csv`: Contains the vulnerability prediction (i.e., the potentially vulnerable functions) of the programs used for the tradeoff analysis of our (saturation-based) fuzzing stopping criterion.

#### Fuzzing Saturation / Stopping Criteria Analysis

- `fuzzer_cov_data.csv`: Contains the code and bug coverage of various fuzzers at different time points (15-minute intervals) within 24-hour fuzzing campaigns.
- `fuzzer_cov_saturation.csv`: Contains the times at which the fuzzing campaigns are terminated according to the different saturation-based stopping criteria examined in this study.
- `fuzzer_crashes.csv`: Contains the fuzzer crashes, including the time points when they were triggered and the deduplication (column `Bug_ID`[^1]) for extracting the unique bugs.

### Pre-trained Vulnerability Prediction Models

The pre-trained models can be found in the `./models` directory. Please refer to section `Green Fuzzing ... > ML-based Vulnerability Prediction > Vulnerability Prediction` in the `analysis.ipynb` notebook to see how these models can be used to predict potentially vulnerable functions.

[^1]: Crashes with the same bug ID have the same top $N=3$ stack frames and are therefore considered to have the same underlying vulnerability.
