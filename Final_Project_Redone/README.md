# Voices of Protest: final project files

This folder contains the files used for the final project **Anti-War Sentiment in Popular Music Lyrics During the Vietnam War**.

## Files

- `Final_Project.docx` - the final paper.
- `analysis.R` - the complete RStudio script.
- `data/lyrics.csv` - the twelve song lyrics used in the analysis.
- `data/metadata.csv` - information about song title, artist, year, period, word count, and the available source information.
- `figures/` - the three figures used in the paper.
- `outputs/` - result tables created when the script is run.
- `Voices_of_Protest.Rproj` - the RStudio project file.
- `SOURCES.md` - a list of the historical, methodological, and website sources used in the project.

## How to reproduce the analysis

1. Download or clone the entire repository.
2. Open `Voices_of_Protest.Rproj` in RStudio.
3. Open `analysis.R`.
4. Install the packages listed at the top of the script if they are not already installed.
5. Run the complete script from top to bottom.

The script imports the semicolon-separated CSV with `read_csv2()`, creates the `figures` and `outputs` folders if needed, and saves the figures and result tables.

## Source note

The dataset contains twelve complete song records. The exact lyric webpage used for each transcription was not recorded when the dataset was created. This limitation is stated in `data/metadata.csv` rather than assigning sources that cannot be confirmed.
