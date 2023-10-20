df = read.csv('terms.csv', sep = ',')

df$ImageName <- fs::path_sanitize(paste(df$Term, "png", sep = '.'))

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
  system(sprintf("convert -gravity center -pointsize 60 -extent 640x512 -font Liberation-Serif caption:%s ../frequencies/static/terms/%s", term, image))
}