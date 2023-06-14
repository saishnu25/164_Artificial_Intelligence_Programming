%% Saishnu Ramesh Kumar (300758706)
%% CSCI 164 - Project 1 

%% -- Main -- 

close all % Closes all open figures.
clear % Clears all variables from current workspace.
clc % Clears the command window.

%% -- Part 1 -- 
% Function to read the textfile containing the book.
filename = 'alice_in_wonderland.txt'; % The text file that we are assigning to filename.
text = readTextFile(filename); % Uses the function to read in the textfile.

%% -- Part 2 -- 
% Function to get all the document in lower case and extract the words.
words = extractWords(text); % Uses the function to extract the words from the text. 

%% -- Part 3 -- 
% Function to count the words.
wordCount = countWords(words); % Uses the function to count the number of words within the text. 

%% -- Part 4 -- 
% Function to get the number of unique words. 
uniqueWordCount = countUniqueWords(text); % The function will count the number of unique words that are found within the text. 

%% -- Part 5 -- 
% Function to get the number of unique words where there is the minimum number of characters in the word. 
minChars = 5; % Setting the minimum character. 
uniqueWordCountMin = countUniqueWordsWithMinChars(text, minChars); % This function will count the number of unique words with the minimum number of characters in the word.

%% -- Part 6 --
% Function to count the occurence of each word (unigram).
unigramCounts = unigram(text); % Calls the respective function in order to count its word occurence. 

%% -- Part 7 -- 
% Function to get the matrix to get the number of words, based on the
% previous words (bigram). 
bigramCounts = bigram(text); % Calls the respective function in order to get the matrix to get the number of words that is based on the previous word.

%% -- Part 8 --
% Function that generates text based on the probability of the words, by
% using the previous word as the prior information.
% Additional: Constraint 1 - To make sure that the generated text contains
%             a specific set of words or phrases.
%             Constraint 2 - Laplace Smoothing to ensure the words have a
%             non-zero probability.
constraint = {'the','rabbit','hole'}; % Set of words or phrase to include for the constraint.
startWord = 'Alice'; % Starting word for text generation.
numWords = 10; % Number of words to generate for the constraint.
generatedText = generateText(text, startWord, numWords, constraint); % Calls the respective function in order to get the text generation.

%% -- Part 9 -- 
% Function that plots the distribution of the unique words.
plotWordDistribution(filename); % Calls the respective function to display the bar chart created. 