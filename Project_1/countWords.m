%% -- Count Words Function --
function [uniqueWords, wordCount] = countWords(words) % Function that takes in a "words" array and returns the "uniqueWords" and "wordCount" arrays.

uniqueWords = unique(words); % Finds all the unique words in the "words" array and stores them in the "uniqueWords" variable.
wordCount = zeros(size(uniqueWords)); % Creates an array of zeros with the same size as the "uniqueWords" variable and stores it in the "wordCount" variable.

for i = 1:length(uniqueWords) % Creating a for loop that will iterate over all the unique words in the "uniqueWords" array.
    % Counts the number of times each unique word appears in the "words" array by using "strcmp" to compare each word in "words" with the current unique word, and then summing the results. 
    % The count is then stored in the element of "wordCount".
    wordCount(i) = sum(strcmp(words, uniqueWords{i})); 
end                                                        
end 