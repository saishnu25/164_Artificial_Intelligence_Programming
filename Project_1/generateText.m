%% -- Generate Text Function --
% Includes two constraints that have been added as well.
function textGenerated = generateText(text, startWord, numWords, constraint) % Function that takes in four arguments "text", "startWord", "numWords", "constraint" and returns a generated text.

% Creating a dictionary for all unique words in the text, alongside their frequency count.
words = extractWords(text);
[uniqueWords, wordCount] = countWords(words);
dict = containers.Map(uniqueWords, wordCount);

% Creating a transition matrix that represents the probability of each word following another word with Laplace smoothing.
V = length(uniqueWords);  % Size of the vocabulary.
transitionMatrix = zeros(V); % Creating a matrix of zeros that will store the transition probabilities.
for i = 1:length(words)-1 % For loop to iterate through each word in the input text except the last word.
    currentWord = words{i}; % Gets the current word.
    nextWord = words{i+1}; % Gets the next word.
    currentWordIndex = find(strcmp(uniqueWords, currentWord)); % Gets the index of the current word in the "uniqueWords" array.
    nextWordIndex = find(strcmp(uniqueWords, nextWord)); % Gets the index of the next word in the "uniqueWords" array.
    transitionMatrix(currentWordIndex, nextWordIndex) = transitionMatrix(currentWordIndex, nextWordIndex) + 1; % Incrementing the count for the transition from the current word to the next word in the "transitionMatrix".
end

% Applying Laplace smoothing for non-zero probability.
transitionMatrix = (transitionMatrix + 1) ./ (sum(transitionMatrix, 2) + V);

% Generating the text by starting with the seed word (start word) and using the transition matrix to predict the next word.
textGenerated = startWord; % Setting the generated text to be the start word.
currentWord = startWord; % Setting the current word to be the start word.

if ~isempty(constraint) % Checks if there is a constraint
    while ~ismember(currentWord, constraint) % The while loop will loop until the current word is in constraint.
        currentWordIndex = find(strcmp(uniqueWords, currentWord)); % Getting the index of the current word in the vocabulary.
        nextWordIndex = randsample(V, 1, true, transitionMatrix(currentWordIndex, :)); % Randomly sampling the index of the next word from the probability distribution given the current word.
        currentWord = uniqueWords{nextWordIndex}; % Updating the current word to be the next word.
    end
    textGenerated = currentWord; % Sets the generated text to be the start word in the constraint.
end

for i = 1:numWords-1 % For loop to loop through the desired number of words to generate a minus one (we do this since the first word is already set to be the start word).
    currentWordIndex = find(strcmp(uniqueWords, currentWord)); % Getting the index of the current word in the "uniqueWords" array.
    nextWordIndex = randsample(V, 1, true, transitionMatrix(currentWordIndex, :)); % Randomly sampling the index of the next word based on the transition probability from the current word to all of the possible "nextWord".
    nextWord = uniqueWords{nextWordIndex}; % Getting the actual word corresponding to the randomly sampled index. 

    while ~ismember(nextWord, constraint) % If the next word is not in the constraint list, we will keep sampling until we find one that is.
        nextWordIndex = randsample(V, 1, true, transitionMatrix(currentWordIndex, :)); % Randomly sampling the index of the next word again.
        nextWord = uniqueWords{nextWordIndex}; % Getting the actual word corresponding to the new index set.
    end

    textGenerated = strcat(textGenerated, {' '}, nextWord); % We append the next word to the generated text which is separated by a space.
    currentWord = nextWord; % Update the current word to be the next word, so we can repeat the process for the next word.
end
end