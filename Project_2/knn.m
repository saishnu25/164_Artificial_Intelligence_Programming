%% -- K Nearest Neighbor Function --
function knn(train_data, train_labels, test_data, test_labels) % Function takes in four input arguments.
% train_data = Gets the train_data values obtained from the train file.
% train_labels = Gets the train_labels obtained from the train file.
% test_data = Gets the test_data values obtained from the test file.
% test_labels = Gets the test_labels obtained from the test file.

k_values = [1, 5, 10]; % The values to assess for K Nearest Neighbor accuracy.
num_examples_train = size(train_data, 1); % Obtains the number of examples from the size of the train data.
num_examples_test = size(test_data, 1); % Obtains the number of examples from the size of the test data.



for k = k_values % For loop to iterate over the the k values.
    % Creating a column vector as we will only use 1 column because the data points can only be assigned to 1 class.  
    predicted_labels = zeros(num_examples_test,1);

    for i = 1:num_examples_test % For loop to iterate through the test_data in order to calculate the distance of the test_data from the train_data.
        % Compute the Euclidean distance between the test example and all
        % the points in the training examples.
        distances = sqrt(sum((train_data - repmat(test_data(i,:), num_examples_train,1)).^2, 2)); % Repmat is used here to ensure that the test_data and train_data have the same dimensions.

        % Finds the indices of the k smallest value within the distances
        % and assigns it to idx.
        [~, idx] = mink(distances,k);

        % Obtains the most common labels found from the train_labels
        % matrix.
        predicted_labels(i) = mode(train_labels(idx));
    end

    % Computes the accuracy of the algorithm.
    accuracy = sum(predicted_labels == test_labels) / num_examples_test;
    accuracyDisplay = sprintf('Accuracy = %.2f%%\n', accuracy*100);

    % Computes the confusion matrix.
    C = confusionmat(test_labels, predicted_labels);

    % Displays the confusion matrix.
    figure;  % Creating figure window for each k_values.
    confusionchart(C); % Displays chart figure of the confusion matrix. 
    title(sprintf('K Nearest Neighbor - Confusion Matrix (k = %d) || %s', k, accuracyDisplay)); % Shows the title of the figure with its accuracy.
    xlabel('Predicted Label'); % X-Axis label name.
    ylabel('True Label'); % Y-Axis label name.
    
    % Computing the True Positives and False Negatives 
    TruePos = sum(diag(C)); % Summing the diagonals 
    FalseNeg = sum(sum(C,2)) - TruePos; % Summing the rows and subtracting from the TF
    disp(TruePos); % Displays True Positives Total
    disp(FalseNeg); % Displays False Negatives Total
end
end
