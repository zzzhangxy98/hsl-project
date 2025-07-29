# MATLAB Code for "Constructing a holistic map of cell fate decision by hyper solution landscape"

This repository contains the official MATLAB source code for the research paper titled "Constructing a holistic map of cell fate decision by hyper solution landscape". The code allows for the construction, analysis, and visualization of the **Hyper Solution Landscape (HSL)** for various gene regulatory networks.

## Abstract

The Hyper Solution Landscape (HSL) is a novel conceptual framework designed to visualize and analyze the high-dimensional dynamics of complex systems, such as gene regulatory networks. This codebase provides the necessary tools to replicate the figures presented in the paper, offering insights into cell fate decisions. The key applications demonstrated include constructing a basic Solution Landscape (SL), building a complete HSL for a **Cross Inhibition and Self-activation (CIS)** motif, quantifying different evolutionary routes, and applying the HSL framework to a Seesaw model.

## System Requirements

*   **MATLAB Version**: `R2022a`
*   **Dependencies**: No external toolboxes or libraries are required.

## Project Structure

```
.
├── Figure1/                # Basic Solution Landscape (SL) construction
├── Figure2/                # Hyper Solution Landscape (HSL) construction for CIS motif
│   ├── sample/
│   ├── effsample/
│   └── bifurcation/
├── Figure3/                # Quantitative analysis of different routes in CIS motif
│   ├── directandgradual/
│   ├── longandshort/
│   └── gmam/
├── Figure4/                # Quantitative analysis of Progression vs. Accuracy routes
└── Figure5/                # HSL construction and time course analysis for Seesaw model
    ├── sample/
    ├── effsample/
    ├── bifurcation/
    └── timecourse/
        ├── ce/
        └── im/
```

## Usage and Step-by-Step Guide

This section provides a detailed walkthrough of the code organized by the corresponding figure in the paper.

### Figure1: Basic Solution Landscape (SL) Construction

*   **Directory**: `/Figure1`
*   **Description**: This folder contains the fundamental code for constructing a basic Solution Landscape (SL), which forms the foundation of the HSL.
*   **Workflow**:
    1.  The core executable script is `figure1.m`.
    2.  The key function, `makesl.m`, is called within the script. It requires three inputs:
        *   The model function: `parforodefunall.m`
        *   The parameter file: `opt23.mat`
        *   An output filename (string).
    3.  Supporting functions include `HiOSD_H.m`, `cal_index.m`, and `maxmode.m`, which are essential for the construction process.
    4.  The `plotodefun.m` script can be used independently to plot the nullclines and flow fields of the function for visualization and validation.

### Figure2: Hyper Solution Landscape (HSL) Construction

*   **Directory**: `/Figure2`
*   **Description**: This folder details the multi-step process for constructing a complete HSL for the CIS motif. The process is divided into node sampling and edge construction.

*   **Step 1: Initial Node Sampling (`/sample`)**
    1.  Run `sample.m` to perform initial sampling and generate `spall.mat`.
    2.  Run `panduansl.m` to process the samples into `indexall10.mat`.
    3.  Run `mkparaset.m` to create the final parameter set for this stage, `paraset10.mat`.

*   **Step 2: Effective Supplementary Sampling (`/effsample`)**
    1.  This step refines the landscape by sampling under-represented regions.
    2.  Process the results from `sample.m` to produce a symmetric parameter set `symparaset10.mat`.
    3.  Merge `paraset10.mat` and `symparaset10.mat` using `mkparasetall.m`.
    4.  Run `effsample.m` for further sampling.
    5.  **Manual Step**: The new results must be manually integrated back into `paraset10.m`.

*   **Step 3: Edge Construction (`/bifurcation`)**
    1.  This step identifies transitions (edges) between states using bifurcation analysis.
    2.  It requires the final `paraset.mat` from the previous steps.
    3.  Execute the scripts `runbifu1.m` through `runbifu11.m`, which correspond to searches for different indices. The core logic is implemented in `bifu4point.m`.
    4.  Finally, run `newedgemat.m` to process the bifurcation results and generate the transition probability matrix.

### Figure3: Quantifying Different Routes in the CIS Motif

*   **Directory**: `/Figure3`
*   **Description**: This folder provides tools to quantitatively analyze different types of transition routes within the CIS motif's landscape.

*   **`/directandgradual` (Direct vs. Gradual Route)**
    *   Run `dands.m` to get the final cell count distributions for both the direct and gradual routes.

*   **`/longandshort` (Long vs. Short Route)**
    *   **Simulation**: Execute `continuechange*.m` scripts (`*=1, 2, 3,...`) multiple times to generate independent simulation replicates.
    *   **Analysis**: Run `analrepeat.m` to analyze the collected results and compute the final cell count distributions for the long and short routes.

*   **`/gmam` (Action/Quasi-potential Calculation)**
    *   **Pre-requisite**: Before running, you must know the precise locations of the attractors and saddle points of interest.
    *   **Execution**: Run `test.m` to calculate the quasi-potential.

### Figure4: Progression vs. Accuracy Route Analysis

*   **Directory**: `/Figure4`
*   **Description**: This folder contains code to quantitatively analyze the "Progression Route" versus the "Accuracy Route".
*   **Workflow**:
    1.  **Simulation**: Run the main script `singlepara4paall.m`. It simulates all scenarios (varying noise, initial barrier heights) and generates all data for Figure 4. It uses `jiluini4pa.mat` as the initial cell distribution.
    2.  **Analysis & Plotting**:
        *   Use `celltypeandplot.m` to analyze and visualize the simulation output.
        *   **Manual Step**: Before running the analysis, you must manually select a single trajectory from the results and save it as either `ajiluall4plot.mat` (for an Accuracy Route) or `pjiluall4plot.mat` (for a Progression Route).

### Figure5: HSL and Time Course for the Seesaw Model

*   **Directory**: `/Figure5`
*   **Description**: This folder applies the HSL framework to the Seesaw model and computes time course dynamics.

*   **HSL Construction (Seesaw Model)**
    *   The structure (`sample`, `effsample`, `bifurcation`) is similar to Figure2, but the initial sampling workflow is unique.
    *   **`/sample` Workflow**:
        1.  Run `sample.m`.
        2.  Run `downgraph.m`.
        3.  Run `jiluG.m` and `jilusp.m`.
        4.  Run `mkparaset4seesaw.m` to produce the final `paraset.mat` for the Seesaw model.
    *   **`/effsample` and `/bifurcation`**: These folders function similarly to their Figure2 counterparts, using the `paraset.mat` generated above.

*   **Time Course Calculation (`/timecourse`)**
    *   This folder contains scripts to calculate dynamics for two different routes discussed in the paper.
    *   Run `ce/ce.m` for the first route.
    *   Run `im/im.m` for the second route.

## References

Please cite the following paper if you use this code in your research:

> [Constructing a holistic map of cell fate decision by hyper solution landscape](https://doi.org/10.1101/2024.11.28.625944). *bioRxiv* 2024.11.28.625944; doi: https://doi.org/10.1101/2024.11.28.625944

## License

This project is licensed under the MIT License. Please see the `LICENSE` file for details.

## Contact

For questions or inquiries, please contact Xiaoyi Zhang at xyzhang@stu.pku.edu.cn.