%% -- Unigram Function -- 
function counts = unigram(text) % Function that takes in a "text" argument and returns a "counts" array.
    words = split(text); % Splits the "text" variable into an array of words by using whitespace as the delimiter and stores the result in "words".
    uniqueWords = unique(words); % Finding the unique words in the "words" array and storing them in "uniqueWords".
    counts = zeros(size(uniqueWords)); % Creating an array of zeros with the same size as the "uniqueWords" array and storing it in "counts".
    
    for i = 1:length(uniqueWords) % Creating a for loop that iterates over each unique word in the "uniqueWords" array.
        counts(i) = sum(strcmp(words, uniqueWords(i))); % Then calculate the number of times the current unique word appears in the "words" array using "strcmp" and store the result in the "counts" array at the same index as the current unique word.
    end
end  