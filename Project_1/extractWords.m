%% -- Extract Words Function -- 
function words = extractWords(text) % Function takes in a "text" argument and returns a "words" variable.
    % Converts all the characters in "text" variables to lowercase and reassigns it back to text.
    text = lower(text);

    % Removes all non-alphanumeric characters including punctuations from "text" variable by using a regular expression function, and replaces them with spaces. 
    text = regexprep(text, '[^a-z0-9 ]', ' ');

    % Splits the "text" variables into an array of words by using whitespaces as the delimiter and it stores the results in the "words" variable.
    words = split(text);
end   