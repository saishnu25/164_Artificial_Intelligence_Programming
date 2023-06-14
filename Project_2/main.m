%% Saishnu Ramesh Kumar (300758706)
%% CSCI 164 - Project 2

%% -- Main --

close all % Closes all open figures.
clear % Clears all variables from current workspace.
clc % Clears the command window.

%% -- Test and Train Data --
% Loading the test data file and assigning to X.
X = load('data_mnist_test_original.mat');

% Loading the train data file and assigning to Y.
Y = load('data_mnist_train_original.mat');

num_examples = 500; % Number of examples that will be needed from the datasets.

% -- Test and Train Data --
% The first 500 images from the matrix of 28 x 28 x 10000 is extracted to create a new matrix of 28 x 28 x 500.
% The reshape function then reshapes the matrix into a matrix of 500 x 784 and it then normalizes the pixel
% values to be between 0 and 1 and divides it by 255 to get the test_data.
test_data = double(reshape(X.imgs(:, :, 1:num_examples), [], num_examples)') / 255;

% The first 500 images from the matrix of 28 x 28 x 60000 is extracted to create a new matrix of 28 x 28 x 500.
% The reshape function then reshapes the matrix into a matrix of 500 x 784 and it then normalizes the pixel
% values to be between 0 and 1 and divides it by 255 to get the train_data.
train_data = double(reshape(Y.imgs(:, :, 1:num_examples), [], num_examples)') / 255;

% -- Test and Train Labels --
% The first 500 labels from the matrix of 10000 x 1 is extracted to create a new matrix of 500 x 1.
% We can then access the first 500 examples of the test label.
test_labels = X.labels(1:num_examples);

% The first 500 labels from the matrix of 60000 x 1 is extracted to create a new matrix of 500 x 1.
% We can then access the first 500 examples of the train label.
train_labels = Y.labels(1:num_examples);

%% -- K Nearest Neighbor (KNN) --
fprintf('Getting K Nearest Neighbor Results...\n'); % Displays this message on command window.
knn(train_data, train_labels, test_data, test_labels); % K Nearest Neighbor function called which will then display the confusion matrix and accuracy.

%% -- K-Means --
rng(0); % Setting the random seed to 0, this ensures that the results obtained will be the same every time it is run.
k_values = [10, 20, 30]; % Number of clusters to assess.
maxiterations = 100;  % Maximum number of iterations.

fprintf('\nGetting K-Means Results...\n'); % Displays this message on command window.

for i = 1:length(k_values)  % Loops through each value of the k_values to run K-Means with different values.

    % Matrix for the cluster labels of the train data, initialized with zeros.
    cluster_labels_train = zeros(size(train_labels));

    % Matrix for the cluster labels of the test data, initialized with zeros.
    cluster_labels_test = zeros(size(test_labels));

    % Running the K-Means algorithm on the train_data to obtain the cluster indices (idx_train) and the cluster centroids (C_train).
    [idx_train, C_train, ~] = kmeans(train_data, k_values(i), maxiterations);

    % Running the K-Means algorithm on the test_data to obtain the cluster indices (idx_test) and the cluster centroids (C_test).
    [idx_test, C_test,  ~] = kmeans(test_data, k_values(i), maxiterations);

    % Loops through each cluster to assign a label to each data point in the cluster.
    for j = 1:k_values(i)

        % Finding the index of the data points in the train data that belong to cluster j.
        idx_itrain = find(idx_train == j);

        % Finding the index of the data points in the test data that belong to cluster j.
        idx_itest = find(idx_test == j);

        % Assigning the most common label in each train cluster to all examples within that cluster.
        cluster_labels_train(idx_itrain) = mode(train_labels(idx_itrain));

        % Assigning the most common label in each test cluster to all examples within that cluster.
        cluster_labels_test(idx_itest) = mode(test_labels(idx_itest));
    end

    % Computes the accuracy of the algorithm.
    accuracy = sum(cluster_labels_test == test_labels) / length(test_labels);
    accuracyDisplay = sprintf('Accuracy = %.2f%%\n', accuracy*100);

    % Computes the confusion matrix.
    C = confusionmat(test_labels, cluster_labels_train); % Comparing test labels with the train.  

    % Displays the confusion matrix.
    figure;  % Creating figure window for each k_values.
    confusionchart(C); % Displays chart figure of the confusion matrix.
    title(sprintf('K-Means - Confusion Matrix (k = %d) || %s', k_values(i), accuracyDisplay)); % Shows the title of the figure with its accuracy. 
    xlabel('Predicted Label'); % X-Axis label name.
    ylabel('True Label'); % Y-Axis label name.

    % Computing the True Positives and False Negatives 
    TruePos = sum(diag(C)); % Summing the diagonals 
    FalseNeg = sum(sum(C,2)) - TruePos; % Summing the rows and subtracting from the TF
    disp(TruePos); % Displays True Positives Total
    disp(FalseNeg); % Displays False Negatives Total

end

%% -- Multilayer Perceptron (MLP) --
fprintf('\nGetting Multilayer Perceptron Results...\n'); % Displays this message on command window.
% Train and test the MLP with 50 hidden layers.
hidden_size = 50; % Assigning the function to use 50 hidden layers.
mlp(train_data, train_labels, test_data, test_labels, hidden_size); % MLP function called which will then display the confusion matrix and accuracy.

% Train and test the MLP with 100 hidden layers.
hidden_size = 100; % Assigning the function to use 100 hidden layers.
mlp(train_data, train_labels, test_data, test_labels, hidden_size); % MLP function called which will then display the confusion matrix and accuracy.

%% -- Convolutional Neural Network (CNN) --
fprintf('\nGetting Convolutional Neural Network Results...\n'); % Displays this message on command window.
cnn(); % CNN function called which will then display the confusion matrix, accuracy, handwritten digits, and graph.