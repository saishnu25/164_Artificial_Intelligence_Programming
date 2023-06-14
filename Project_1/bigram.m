%% -- Bigram Function -- 
function counts = bigram(text) % Function that takes in a "text" argument and returns a "counts" array.
    words = split(text); % Splits the "text" variable into an array of words by using whitespace as the delimiter and stores the result in "words".
    uniqueWords = unique(words); % Finds all the unique words in the "words" array and stores them in "uniqueWords".
    counts = zeros(length(uniqueWords)); % Creating a square matrix of zeros with the same number of rows and columns as the "uniqueWords" array and store it in "counts".
    
    for i = 2:length(words) % Creating a for loop that iterates over each word in the "words" array. Do note that we start from the second word because we need to grab them in pairs.
        prevWord = find(strcmp(uniqueWords, words(i-1))); % Finds the index of the previous word in the "uniqueWords" array using "strcmp" and stores the result in "prevWord".
        currWord = find(strcmp(uniqueWords, words(i)));   % Finds the index of the current word in the "uniqueWords" array using "strcmp" and stores the result in "currWord".
        counts(prevWord, currWord) = counts(prevWord, currWord) + 1; % Incrementing the count of the bigram that contains the previous and current word in the "counts" matrix.
    end
end 