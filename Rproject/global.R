library(tm)
library(wordcloud)
library(memoise)


# The list of valid books

books <<- list("A Mid Summer Night's Dream" = "summer",

                "The Merchant of Venice" = "merchant",

                "Romeo and Juliet" = "romeo")


# Using "memoise" to create a memoised copy of book it saves
#the answers of new invocations, and re-uses the answers of old ones

getTermMatrix <- memoise(function(book) {

# To avoid malicious user slip any name

if (!(book %in% books))

stop("Unknown book")
    
#Read some or all text lines from a connection.

text <- readLines(sprintf("./%s.txt.gz", book),encoding="UTF-8")

# the VectorSource(text) function create a vector source and interprets 
#each element of the vector text as a document.
#Corpora are collections of documents containing (natural language) text
#such corpora are represented via the virtual S3 class Corpus.

docs <- Corpus(VectorSource(text))

#Cleaning the text
#the tm_map()function is used to remove unnecessary white space, 
#to convert the text to lower case, to remove common stopwords like 
#'the', "we".
#The information value of 'stopwords' is near zero due to the fact that 
#they are so common in a language. Removing this kind of words is useful before further analysis. For 'stopwords', supported languages are danish, dutch, english, finnish, french, german, hungarian, italian, norwegian, portuguese, russian, spanish and swedish. Language names are case sensitive.

#You could also remove numbers and punctuation with removeNumbers and
#removePunctuationarguments.


#Text transformation
#Transformation is performed using tm_map() function to replace,
#for example, special characters from the text.
#Replacing "/", "@" and "|" with space


toSpace <- content_transformer(function (x , pattern )
         gsub(pattern, " ", x))
 docs <- tm_map(docs, toSpace, "/")
 docs <- tm_map(docs, toSpace, "@")
 docs <- tm_map(docs, toSpace, "\\|")
 

 #The R code below can be used to clean your text :
     # Convert the text to lower case
  docs <- tm_map(docs, content_transformer(tolower))
  # specify as Plain Text document.
  docs <- tm_map(docs, PlainTextDocument)
  # Remove punctuation
  docs = tm_map(docs, removePunctuation)
 # Remove numbers
  docs <- tm_map(docs, removeNumbers)
 
 # Remove your own stop word
 # specify your stopwords as a character vector
 
 docs = tm_map(docs, removeWords,
               c(stopwords("SMART"), "thy", "thou", "thee", "the", "and", "but"))
 # Remove the Whitespaces.
 docs <- tm_map(docs, stripWhitespace)
 
 #Another important preprocessing step is to make atext stemming which
 #reduces words to their root form. In other words, this process removes
 #suffixes from words to make it simple and to get the common origin. 
 #For example, a stemming process reduces the words "moving", "moved" 
 #and "movement" to the root word, "move".
 # Note that, text stemming require the package 'SnowballC'.
 
 library(SnowballC)
 docs <- tm_map(docs, stemDocument)
 

#Build a term-document matrix
#Document matrix is a table containing the frequency of the words. 
#Column names are words and row names are documents. 
#The function TermDocumentMatrix() from text mining package can be used 
#as follow :
     
dtm = TermDocumentMatrix(docs,control = list(minWordLength = 1))

m <- as.matrix(dtm)

 sort(rowSums(m),decreasing=TRUE)



})
