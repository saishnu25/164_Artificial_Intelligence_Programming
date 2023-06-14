%% -- Plot Distribution Function -- 
function plotWordDistribution(filename) % Function takes in "filename" as argument and displays a graph. 

    % Reading the text file.
    text = fileread(filename);
    
    text = lower(text);  % Converts all the characters in "text" variables to lowercase and reassigns it back to text.
    text = regexprep(text, '[^a-z\s]+', ''); % Removes all non-alphanumeric characters including punctuations from "text" variable by using a regular expression function, and replaces them with spaces. 
    
    words = strsplit(text); % Splits the "text" variables into an array of words by using whitespaces as the delimiter and it stores the results in the "words" variable.
    
    % Removes any empty elements from the "words" array using "cellfun" function and stores the result in the "words" variable again.
    words = words(~cellfun('isempty', words));
    
    % Finding all the unique words in the "words" array and store them in the "uniqueWords" variable with their indices in the "wordIndices" variable.
    [uniqueWords, ~, wordIndices] = unique(words);
    wordCounts = accumarray(wordIndices, 1);
    
    % Sorting the unique words by counting them in descending order (Most Counts to Least Counts).
    [sortedCounts, sortedIndices] = sort(wordCounts, 'descend');
    sortedWords = uniqueWords(sortedIndices);
    
    % Plotting the distribution of the 50 unique words.
    figure('Position', [100, 100, 1000, 400]); % Creating the figure to display graph.
    bar(sortedCounts(1:50)); % Creating a bar chart for the 50 unique words.
    set(gca, 'XTick', 1:50, 'XTickLabel', sortedWords(1:50)); % Setting the X-axis tick marks and labels.
    xtickangle(68); % Angle set to display tick labels for more readability. 
    xlabel('Word'); % X-Axis Label.
    ylabel('Count'); % Y-Axis Label.
    title('Distribution of 50 Unique Words'); % Title of figure.
    
end