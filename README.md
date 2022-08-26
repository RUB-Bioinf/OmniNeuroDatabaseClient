
[![GitHub Stars](https://img.shields.io/github/stars/RUB-Bioinf/OmniNeuroDatabaseClient.svg?style=social&label=Star)](https://github.com/RUB-Bioinf/OmniNeuroDatabaseClient) 
&nbsp;
[![GitHub Downloads](https://img.shields.io/github/downloads/RUB-Bioinf/OmniNeuroDatabaseClient/total?style=social)](https://github.com/RUB-Bioinf/OmniNeuroDatabaseClient/releases) 
&nbsp;
[![Follow us on Twitter](https://img.shields.io/twitter/follow/NilsFoer?style=social&logo=twitter)](https://twitter.com/intent/follow?screen_name=NilsFoer)

[![Contributors](https://img.shields.io/github/contributors/RUB-Bioinf/OmniNeuroDatabaseClient?style=flat)](https://github.com/RUB-Bioinf/OmniNeuroDatabaseClient/graphs/contributors)
&nbsp;
[![License](https://img.shields.io/github/license/RUB-Bioinf/OmniNeuroDatabaseClient?color=green&style=flat)](https://github.com/RUB-Bioinf/OmniNeuroDatabaseClient/LICENSE)
&nbsp;
![Size](https://img.shields.io/github/repo-size/RUB-Bioinf/OmniNeuroDatabaseClient?style=flat)
&nbsp;
[![Issues](https://img.shields.io/github/issues/RUB-Bioinf/OmniNeuroDatabaseClient?style=flat)](https://github.com/RUB-Bioinf/OmniNeuroDatabaseClient/issues)
&nbsp;
[![Pull Requests](https://img.shields.io/github/issues-pr/RUB-Bioinf/OmniNeuroDatabaseClient?style=flat)](https://github.com/RUB-Bioinf/OmniNeuroDatabaseClient/pulls)
&nbsp;
[![Commits](https://img.shields.io/github/commit-activity/m/RUB-Bioinf/OmniNeuroDatabaseClient?style=flat)](https://github.com/RUB-Bioinf/OmniNeuroDatabaseClient/)
&nbsp;
[![Latest Release](https://img.shields.io/github/v/release/RUB-Bioinf/OmniNeuroDatabaseClient?style=flat)](https://github.com/RUB-Bioinf/OmniNeuroDatabaseClient/)
&nbsp;
[![Release Date](https://img.shields.io/github/release-date/RUB-Bioinf/OmniNeuroDatabaseClient?style=flat)](https://github.com/RUB-Bioinf/OmniNeuroDatabaseClient/releases)

# Setup
This project has been programmed and compiled using *Java 11*.
Required libraries managed using *gradle* (see corresponding files included in this repository).

### Database
This project requires a *Postgre SQL* database to be set up previously.
Learn more about the database and the table's structure in the `/sql` directory in this repository.

# Download
You can download a precompiled client from the [Releases](https://github.com/RUB-Bioinf/OmniNeuroDatabaseClient/releases) page.

# Usage
After setting up the database (see above), you can input your credentials in the corresponding fields in the UI.

## Reading Data
To read data from raw input sheets, place them all in a single folder.
The supported input formats are:
 - AXIS Sheet (see [1])
 - UKN Sheet (see [1])
 
 Start the import using the button "Start Import".

### Unblinding Compounds
If you have blinded compounds, you can unblind them using the corresponding table in the Database.
Make sure to map the blinded names to the unblinded CAS before importing.

## Exporting Data
When you have imported data from the sheets, you can export using different pooling methods and data formats.
Choose your format from the tabs and set corresponding configurations and parameters.

The export methods are:
 - "Compound-wise Responses": A CSV file for every compound containing all corresponding responses. Configurations apply.
 - "Compoundwise Experiments": A CSV file for every compound containing all corresponding experiments. Configurations apply.
 - "Compact": A single CSV file. Shows all responses and endpoints in a compact overview.
 - "Assay Distribution": Lists every compound and counts its appearance in every registered Assay.

### Configurations
You can specify what data you want to be included in the exports.
These configurations are applied to some of the export formats (specified above).
Use configurations to limit data to be included to only specific Assays, compounds, endpoints, etc.

# Appendix

## Correspondence

[**Prof. Dr. Axel Mosig**](mailto:axel.mosig@rub.de): Bioinformatics, Center for Protein Diagnostics (ProDi), Ruhr-University Bochum, Bochum, Germany

http://www.bioinf.rub.de/

[**Prof. Dr. Ellen Fritsche**](mailto:ellen.fritsche@iuf-duesseldorf.de): IUF - Leibniz Research Institute for Environmental Medicine, Auf’m Hennekamp 50, 40225 Düsseldorf, Germany

https://iuf-duesseldorf.de/en/

## Feedback & Bug Reports

We strive to always improve and make this pipeline accessible to the public.
We hope to make it as easy to use as possible.

Should you encounter an error, bug or need help, please feel free to reach out to us via the [Issues](https://github.com/RUB-Bioinf/OmniNeuroDatabaseClient/issues) page.
Thank you for your help. Your feedback is much appreciated.

## References

This software has been used or contributed to these works:

1. Masjosthusmann, S., et al. Establishment of an a priori protocol for the implementation and interpretation of an in-vitro testing battery for the assessment of developmental neurotoxicity

This list may be incomplete.
If you like your work featured here, contact us (using *GitHub Issues* or see *Correspondence*).

***

**Funding**: This research received no external funding.

**Conflicts of Interest**: The authors declare no conflict of interest.