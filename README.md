# Basic-Duo-ShinyApp
Very basic R Shiny application using Duolingo language data from a study by Settle and Meeder (2016).

B. Settles and B. Meeder. 2016. A Trainable Spaced Repetition Model for Language Learning. In Proceedings of the Association for Computational Linguistics (ACL), pages 1848-1858.

This app is for some simple practice with Shiny, around layout. 

The git repository for this study is:

https://github.com/duolingo/halflife-regression 

## Data
The data was downloaded originally from a sa gzip file containing a csv:
https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/N8XJME

Once the data is downloaded it was read in and saved as an rds file as follows:

```
zz=gzfile(".../Downloads/settles.acl16.learning_traces.13m.csv.gz",'rt')  #unzip
dat=read.csv(zz,header=T) # read as csv
write_rds(dat, ".../Data/lang_data.rds") # write into r format
```

This is then read into the app

# Additional info
There is a really nice overview of analysis done with the data here:

http://acsweb.ucsd.edu/~btomosch/duodata.html
