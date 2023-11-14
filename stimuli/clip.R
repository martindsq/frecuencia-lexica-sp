lsu <- read.csv('lsu.csv')
swow = read.csv('swow.csv')
anew = read.csv('anew.csv')
load('words_data.RData')

cleaned_words_data <- subset(words_data, target != "contrataria")

df <- data.frame('Term' = union(lsu$S.Word, cleaned_words_data$target))
df$ImageName <- paste(
  stringi::stri_trans_general(chartr(" ", "_", df$Term), "latin-ascii"),
  "png", 
  sep = '.'
)

print(
  paste(
    "Words in LSU and Words datasets union:",
    length(unique(df$Term))
  )
)
print(
  paste(
    "Unique words in LSU dataset:",
    length(unique(lsu$S.Word))
  )
)
print(
  paste(
    "Unique words in Words dataset:",
    length(unique(cleaned_words_data$target))
  )
)
print(
  paste(
    "Words in both LSU and Words dataset:",
    length(intersect(unique(lsu$S.Word), cleaned_words_data$target))
  )
)
print(
  paste(
    "Words in both LSU and SWOW dataset:",
    length(intersect(unique(lsu$S.Word), swow$response))
  )
)
print(
  paste(
    "Words in both LSU and ANEW dataset:",
    length(intersect(unique(lsu$S.Word), anew$S.Word))
  )
)

# setdiff(unique(lsu$S.Word), intersect(unique(lsu$S.Word), anew$S.Word))
# "coche" -> "auto"
# anew$S.Word

write.table(
 x = df[,c("Term", "ImageName")],
 file = '../frequencies/management/commands/seed.csv',
 sep = ',',
 col.names = FALSE,
 quote = FALSE,
 row.names = FALSE
)

unlink('../frequencies/static/terms', recursive = TRUE)
dir.create('../frequencies/static/terms')
for (i in 1:nrow(df)) {
  term <- df[i,]$Term
  image <- df[i,]$ImageName
  system(sprintf("convert -gravity center -pointsize 60 -extent 640x512 -size 640x512 -font Liberation-Serif caption:\"%s\" ../frequencies/static/terms/%s", term, image))
}
