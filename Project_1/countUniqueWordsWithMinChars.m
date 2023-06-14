%% -- Count Unique Words With Min Chars Function -- 
function count = countUniqueWordsWithMinChars(text, minChars) % Function that takes in a "text" argument and a "minChars" argument and will return a "count" value.
    words = split(text); % Splits the "text" variable into an array of words using whitespace as the delimiter and stores the result in the "words" variable.
    longWords = words(cellfun('length', words) >= minChars); % Creating a new array called "longWords" that contains only the words from the "words" array that are at least what minChar is set to, in this case, 5 characters.
    
    uniqueWords = unique(longWords); % Finds all the unique words in the "longWords" array and stores them in the "uniqueWords" variable.
    count = length(uniqueWords); % Calculates the length number of unique words in the "uniqueWords" array and stores the result in "count".
end 