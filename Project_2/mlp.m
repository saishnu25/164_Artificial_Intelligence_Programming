%% -- Multilayer Perceptron Function --
function mlp(train_data, train_labels, test_data, test_labels, hidden_size) % Function take fives arguments.
% train_data = Gets the train_data values obtained from the train file.
% train_labels = Gets the train_labels obtained from the train file.
% test_data = Gets the test_data values obtained from the test file.
% test_labels = Gets the test_labels obtained from the test file.
% hidden_size = Extracts the hidden layer variables that have been set in
% the main file.

% Convert the training and test labels to categorical data to ensure that
% the fitcnet function is able to use the data obtained.
train_labels = categorical(train_labels);
test_labels = categorical(test_labels);

% MLP (multi layer perceptron = feedforward neural network with 1 hidden
% layer).
% Trains a feedforward neural network that contains one hidden layer by
% using the fitcnet function that is used to train neural network
% classification models. The variables mentioned train the network along
% with the number of neurons that are initialized for the hidden layer
% size.
Mdl_nn = fitcnet(train_data, train_labels, "LayerSizes", hidden_size);

% Evaluate the MLP on the test data.
[YtestMLP, ~] = predict(Mdl_nn, test_data); % Uses the trained neural network in order to predict the labels for the test_data.

% Computing the confusion matrix.
CMtestMLP = confusionmat(test_labels, categorical(YtestMLP));

% Computes the accuracy of the algorithm.
accuracy = sum(diag(CMtestMLP)) / sum(CMtestMLP(:));
accuracyDisplay = sprintf('Accuracy = %.2f%%\n', accuracy*100);

% Displays the confusion matrix.
figure;  % Creating figure window for each hidden_size.
confusionchart(CMtestMLP); % Displays chart figure of the confusion matrix.
title(sprintf('Multilayer Perceptron - Confusion Matrix (Hidden Layers = %d) || %s', hidden_size, accuracyDisplay)); % Shows the title of the figure with its accuracy.
xlabel('Predicted Label'); % X-Axis label name.
ylabel('True Label'); % Y-Axis label name.

% Computing the True Positives and False Negatives
TruePos = sum(diag(CMtestMLP)); % Summing the diagonals
FalseNeg = sum(sum(CMtestMLP,2)) - TruePos; % Summing the rows and subtracting from the TF
disp(TruePos); % Displays True Positives Total
disp(FalseNeg); % Displays False Negatives Total

end