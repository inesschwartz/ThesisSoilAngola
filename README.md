Angola Soils Thesis – Analysis Scripts

This repository contains the Jupyter Notebook scripts used to conduct the analyses for the Angola soils master’s thesis.
The notebooks are organized into folders and numbered according to the sequential steps of the analytical workflow.

Repository Structure and Workflow
1. Data Cleaning and Preparation (data_cleaning/)

Initial preprocessing and preparation of raw datasets:

1_V2_datacleaning.ipynb – Data cleaning and quality control

2_dataprep.ipynb – Data preparation for exploratory analysis and modeling

2. Exploratory Data Analysis (EDA) (EDA/)

Exploration of soil and environmental variables and initial carbon stock calculations:

3_calc_carbon_stock.ipynb – Calculation of soil organic carbon (SOC) stocks

general_EDA.ipynb – Summary of key observations and exploratory analyses conducted during the EDA phase

3. Modeling (Model/)

Model development and spatial prediction workflow:

Step 6: Prefiltering of the dataset

Step 7: Feature selection

Step 8: Declustering of the training dataset

Step 9: Construction of the prediction grid from the final training dataset

Step 10: Model execution on each declustered dataset, generation of bagged ensemble raster maps, and calculation of SOC stocks

4. Validation (validation/)

Model evaluation and comparison:

Performance metrics

Validation of Random Forest (RF) and Random Forest + Ordinary Kriging (RF+OK) models against the held-out test dataset

5. Results (results/)

Scripts used to generate figures, tables, and analyses presented in the Results section of the thesis.

Notes

All notebooks are numbered to reflect their execution order

Scripts are intended for research reproducibility

File paths may need adjustment depending on local directory structure