# Voices of Protest - RStudio analysis

# Install these packages once if needed:
# install.packages("tidyverse")
# install.packages("tidytext")
# install.packages("textdata")

# Load packages
library(tidyverse)
library(tidytext)
library(textdata)

# Create folders for the results
if (!dir.exists("figures")) dir.create("figures")
if (!dir.exists("outputs")) dir.create("outputs")

# Load the lyrics file
# read_csv2() is used because the CSV file uses semicolons
lyrics <- read_csv2("data/lyrics.csv", show_col_types = FALSE)

# Check the dataset
head(lyrics)
str(lyrics)
nrow(lyrics)

# Turn the lyrics into single words
words <- lyrics %>%
  unnest_tokens(word, lyrics)

# Remove common stop words and repeated filler words
clean_words <- words %>%
  anti_join(stop_words, by = "word") %>%
  filter(!word %in% c("huh", "yeah", "uh", "ooh", "oh", "yall"))

# Count the most common words
word_counts <- clean_words %>%
  count(word, sort = TRUE)

# Show the 20 most common words
head(word_counts, 20)

# Save the word counts
write_csv(word_counts, "outputs/word_counts.csv")

# Plot the 20 most common words
word_plot <- word_counts %>%
  slice_max(n, n = 20) %>%
  ggplot(aes(x = reorder(word, n), y = n)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Most common words in protest song lyrics",
    x = "Word",
    y = "Frequency"
  )

word_plot

ggsave(
  "figures/figure_1_word_frequency.png",
  plot = word_plot,
  width = 8,
  height = 6,
  dpi = 300
)

# Sentiment analysis using the Bing lexicon
bing <- get_sentiments("bing")

sentiment_words <- clean_words %>%
  inner_join(bing, by = "word")

# Count positive and negative words in the complete dataset
sentiment_count <- sentiment_words %>%
  count(sentiment)

sentiment_count
write_csv(sentiment_count, "outputs/sentiment_count.csv")

# Plot overall sentiment
sentiment_plot <- ggplot(sentiment_count, aes(x = sentiment, y = n)) +
  geom_col() +
  labs(
    title = "Sentiment in protest song lyrics",
    x = "Sentiment",
    y = "Number of words"
  )

sentiment_plot

ggsave(
  "figures/figure_2_overall_sentiment.png",
  plot = sentiment_plot,
  width = 7,
  height = 5,
  dpi = 300
)

# Compare sentiment between the songs
sentiment_by_song <- sentiment_words %>%
  count(song, sentiment)

sentiment_by_song
write_csv(sentiment_by_song, "outputs/sentiment_by_song.csv")

# Plot sentiment by song
song_sentiment_plot <- ggplot(
  sentiment_by_song,
  aes(x = sentiment, y = n)
) +
  geom_col() +
  facet_wrap(~ song) +
  labs(
    title = "Sentiment by song",
    x = "Sentiment",
    y = "Word count"
  )

song_sentiment_plot

ggsave(
  "figures/figure_3_sentiment_by_song.png",
  plot = song_sentiment_plot,
  width = 11,
  height = 8,
  dpi = 300
)

# Save information about the R session and packages
writeLines(
  capture.output(sessionInfo()),
  "outputs/session_info.txt"
)
