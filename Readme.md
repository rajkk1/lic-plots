# Licence Plots

Scripts to record and plot hourly use of Mathematica and Matlab network license usage

## Prerequisites

Need to have R installed: https://cran.r-project.org/
Need to have the following packages in R installed:
* lubridate
* ggplot2
* gridExtra
* zoo

## File Descriptions
* MatlabLicScript - Takes in current date, time & Matlab licenses being used and appends them to MatlabLicStat.txt in CSV format.
* MathematicaLicScript - Takes in current date, time & Mathematica licenses being used and appends them to MathematicaLicStat.txt in CSV format.
* licensePlots.R -  Plots Matlab and Mathematica licenses used each month for the last 12 months and outputs it to lic-usage-plot.png
* (optional) lic-usage.php - Website displaying plot

## Installation
* Put MatlabLicScript and MathematicaLicScript in whichever directory you want. Let's call that path to that directory [exePath]
* Put licencePlots.R in whichever directory you want. Let's call that path to that directory [dataPath] 
* Create two empty text files in [dataPath] and call them "MatlabLicStat.txt" and "MathematicaLicStat.txt"
* In all 3 files (licencePlots.R, MatlabLicScript and MathematicaLicScript) replace "[dataPath]" with the above path, and "[matlabPath]", "[flexnetPath]" and "[wolframPath]" with the respective directory paths of the matlab, flexnet and mathematica license manager.
* Make MatlabLicScript and MathematicaLicScript run hourly by typing
```
crontab -e
```
and adding these two lines to the bottom:
```
42 * * * * /[exePath]/MatlabLicScript
42 * * * * /[exePath]/MathematicaLicScript
```
This causes the scripts to run every hour (on the 42nd minute).
* (optional) replace "[dataPath]" in lic-usage.php with the correct path.

## Sample output of lic-usage-plot.png

[![lic-plots plot](https://github.com/rajkk1/lic-plots/raw/master/lic-usage-plot.png)]