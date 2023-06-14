%% -- Read Text File Function -- 
function text = readTextFile(filename) % Function that takes in a "filename" argument and returns a "text" variable.
    fileID = fopen(filename,'r'); % Opens the file specified by the filename argument and assigns a file identifier to fileID.
    text = fscanf(fileID,'%c'); % Reads the contents of the file as characters and uses the file identifier and stores the result in the "text" variable.
    fclose(fileID); % Closes the file.
end