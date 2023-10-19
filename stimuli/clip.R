df = read.csv('terms.csv', sep = ',')

df$ImageName <- fs::path_sanitize(paste(df$Term, "png", sep = '.'))

write.csv(
 x = df[,c("Term", "ImageName")],
 file = 'processed-terms.csv',
 quote = FALSE,
 row.names = FALSE,
)

unlink('./terms', recursive = TRUE)
dir.create('./terms')
for (i in 1:nrow(df)) {
  term <- df[i,]$Term
  image <- df[i,]$ImageName
  system(sprintf("convert -gravity center -size 320x240 -extent 640x480 caption:%s ./terms/%s", term, image))
}