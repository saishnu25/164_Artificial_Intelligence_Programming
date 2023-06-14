%% -- K-Means Function --
function [idx, C, D] = kmeans(X, k, nmaxiterations) % Function takes in three arguments 
%% Inputs
% X: data of size n x m
% n: number of examples
% n: number of features
% niterationsmax: maximum number of iterations
%% Outputs
%idx: cluster index for each example
%C: matrix containing the centroids for each cluster
%D: distance between an example to the different centroids

% Get the number of examples (n) and number of features (m) from X
[n,m] = size(X);

% Initialize the cluster index for each example to 0, the centroids to 0, and the distance to each centroid to 0.
idx = zeros(n, 1);
C = zeros(k ,m);
D = zeros(n,k);

% Initialization of the different clusters using examples from X
% We randomly pick k examples from X and set them as the initial centroids.
tmp = randperm(n);
for i = 1: k
    C(i,:) = X(tmp(i),:);
end

% Initialize the iteration, old index, and finished to start the K-means algorithm.
iteration = 0;
idx_old = zeros(n,1);
finished = false;

% Begin the K-means algorithm.
while ((iteration < nmaxiterations) && ~finished)
    %% Part 1
    % Assign to each example the corresponding cluster.
    % Calculate the Euclidean distance between each example and each centroid.
    % Assign each example to the closest centroid (i.e., the cluster with the smallest distance).
    for i = 1:n
        x = X(i,:);
        d = zeros(k, 1); % Contains the distances between example i and centroid of cluster j.
        for j = 1:k
            c=C(j,:);
            delta = x - c;
            d(j)=sqrt(delta * delta');
        end
        % Get the cluster with the minimum distance with x.
        [vmin, argmin] = min(d);
        idx(i) = argmin;
    end

    %% Part 2
    % Adjust the values of each centroid.
    % Update the centroid of each cluster by calculating the mean of all the examples assigned to it.
    for j = 1:k
        idx_cluster = find(idx==j);
        Xcluster= X(idx_cluster,:);
        C(j,:) = mean(Xcluster,1);
    end

    %% Part 3
    % Check whether the cluster index of each example has changed from the previous iteration.
    % If no change has occurred, stop the algorithm.
    delta_idx = idx_old - idx;
    distance_idx = sqrt(delta_idx'*delta_idx);
    if distance_idx == 0
        finished=true;
    else
        idx_old=idx;
    end

    % Increment the iteration count.
    iteration = iteration +1;
end