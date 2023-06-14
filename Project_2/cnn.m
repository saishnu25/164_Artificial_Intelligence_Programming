%% -- Convolutional Neural Network Function --
% For this specific file, the Deep Learning Toolbox was installed as an
% add-on to the MATLAB application. It is a branch of machine learning that
% can teach computers to learn from experience. The toolbox provides the
% necessary commands that have been implemented in
% this program to create the layers for the neural network.
function cnn()

% From:
% https://www.mathworks.com/help/deeplearning/ug/create-simple-deep-learning-network-for-classification.html


% Load the digit sample data as an image datastore. imageDatastore automatically labels the images based on folder names and stores the data as an ImageDatastore object.
% An image datastore enables you to store large image data, including data that does not fit in memory,
% and efficiently read batches of images during training of a convolutional neural network.
digitDatasetPath = fullfile(matlabroot,'toolbox','nnet','nndemos', ...
    'nndatasets','DigitDataset'); % Assigning the directory path of the digit dataset.
imds = imageDatastore(digitDatasetPath, ...
    'IncludeSubfolders',true,'LabelSource','foldernames'); % Creating an ImageDatastore object of the digit dataset, automatically labeling the images based on folder names.

% Display some of the images in the datastore.
figure; % Creating figure window.
perm = randperm(10000,20); % Generate a random permutation of integers from 1 to 10000 and select 20 of them.
for i = 1:20 % Loops through the first 20 integers in perm.
    subplot(4,5,i); % Creating a subplot with 4 rows, 5 columns, and an index of i.
    imshow(imds.Files{perm(i)}); % Display the i-th image in the perm permutation.
end

% Calculate the number of images in each category. labelCount is a table that contains the labels and the number of images having each label.
% The datastore contains 1000 images for each of the digits 0-9, for a total of 10000 images.
% You can specify the number of classes in the last fully connected layer of your neural network as the OutputSize argument.

labelCount = countEachLabel(imds); % Count the number of images in each category of the dataset.

% You must specify the size of the images in the input layer of the neural network. Check the size of the first image in digitData.
% Each image is 28-by-28-by-1 pixels.

img = readimage(imds,1); % Read the first image in the dataset.
size(img) % Displays the size of the image.

% Divide the data into training and validation data sets, so that each category in the training set contains 750 images, and the validation
% set contains the remaining images from each label. splitEachLabel splits the datastore digitData into two new datastores, trainDigitData and valDigitData.

numTrainFiles = 750; % Set the number of training files per category
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize'); % Split the dataset into training and validation datastores, with the number of training files per category set to numTrainFiles and is then shuffled randomly


% Defining the Convolutional Neural Network architecture.
layers = [
    imageInputLayer([28 28 1]) % Define the input layer to accept 28 x 28 grayscale images.

    convolution2dLayer(3,8,'Padding','same') % Applying a convolution layer with 8 3x3 filters and padding, which preserves the image size.
    batchNormalizationLayer % Normalize the output of the convolutional layer.
    reluLayer % Apply the ReLU activation function.

    maxPooling2dLayer(2,'Stride',2) % Reduce the spatial dimension of the output using 2x2 max pooling with stride 2.

    convolution2dLayer(3,16,'Padding','same') % Apply another convolution layer with 16 3x3 filters and padding.
    batchNormalizationLayer % Normalize the output of the convolutional layer.
    reluLayer % Apply the ReLU activation function.

    maxPooling2dLayer(2,'Stride',2) % Reduce the spatial dimension of the output using 2x2 max pooling with stride 2.

    convolution2dLayer(3,32,'Padding','same') % Apply another convolution layer with 32 3x3 filters and padding.
    batchNormalizationLayer % Normalize the output of the convolutional layer.
    reluLayer % Apply the ReLU activation function.

    fullyConnectedLayer(10) % Connect all the features learned so far to 10 output nodes for each digit (0-9).
    softmaxLayer % Apply the softmax function to the output to obtain a probability distribution over the digits.
    classificationLayer]; % Compute the classification loss, which measures the difference between the predicted and true labels.

% Display the network.
analyzeNetwork(layers);

% Define the options for training the network.
options = trainingOptions('sgdm', ... % Use stochastic gradient descent with momentum.
    'InitialLearnRate',0.01, ... % Set the initial learning rate to 0.01.
    'MaxEpochs',4, ... % Set the maximum number of epochs to 4.
    'Shuffle','every-epoch', ... % Shuffle the data at the start of each epoch.
    'ValidationData',imdsValidation, ... % Use the validation set to monitor the performance of the network during training.
    'ValidationFrequency',30, ... % Evaluate the network on the validation set every 30 iterations.
    'Verbose',false, ... % Do not display the progress during training.
    'Plots','training-progress'); % Display the training progress.

% Train the network using the training set.
net = trainNetwork(imdsTrain,layers,options);

% Predict the labels of the validation data using the trained neural network, and calculate the final validation accuracy.
% Accuracy is the fraction of labels that the neural network predicts correctly.
% In this case, more than 99% of the predicted labels match the true labels of the validation set.
YPred = classify(net,imdsValidation);
YValidation = imdsValidation.Labels;

% Computes the accuracy of the algorithm.
accuracy = sum(YPred == YValidation)/numel(YValidation);
accuracyDisplay = sprintf('Accuracy = %.2f%%\n', accuracy*100);

% Computes the confusion matrix.
C = confusionmat(YValidation, YPred);

% Displays the confusion matrix.
figure; % Creating figure window
confusionchart(C);  % Displays chart figure of the confusion matrix.
title(sprintf('Convolutional Neural Network - Confusion Matrix || %s', accuracyDisplay)); % Shows the title of the figure with its accuracy.
xlabel('Predicted Label'); % X-Axis label name.
ylabel('True Label'); % Y-Axis label name.

% Computing the True Positives and False Negatives
TruePos = sum(diag(C)); % Summing the diagonals
FalseNeg = sum(sum(C,2)) - TruePos; % Summing the rows and subtracting from the TF
disp(TruePos); % Displays True Positives Total
disp(FalseNeg); % Displays False Negatives Total

end