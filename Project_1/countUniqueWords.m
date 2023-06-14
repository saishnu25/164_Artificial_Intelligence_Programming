%% -- Count Unique Words Function --  
function [uniqueWords, wordCounts] = countUniqueWords(text) % Function takes in a "text" argument and returns "uniqueWords" and "wordCounts" arrays.

    text = lower(text); % Converts the characters in the "text" variable to lowercase and reassigns them to "text".
    text = regexprep(text, '[^a-z\s]+', ''); % Removes all non-alphabetic characters from the "text" variable using regular expression and replaces them with an empty string.
    
    words = strsplit(text); % Splits the "text" variable into an array of words while using whitespace as the delimiter and stores the result in the "words" variable.
    
    words = words(~cellfun('isempty', words)); % Removes any empty elements from the "words" array using "cellfun" function and stores the result in the "words" variable again.
    
    [uniqueWords, ~, wordIndices] = unique(words); % Finding all the unique words in the "words" array and store them in the "uniqueWords" variable with their indices in the "wordIndices" variable.
    wordCounts = accumarray(wordIndices, 1); % Uses the "accumarray" function to count the number of occurrences of each unique word in the "words" array and is then stored in the "wordCounts" variable.
end 