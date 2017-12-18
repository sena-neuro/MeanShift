function [labels peaks] = segmentImage (image, params)
	x_size = size(image,1);
    y_size = size(image,2);
    d = 3; % size(data,2);
    data = zeros(x_size*y_size, d); %floor(x_size/10), floor(y_size/10));
    labels = zeros(x_size,y_size);
	% Prepare the spectral datapoints
    
	index = 1;
    for i=1:x_size                                                         % we can auto select increment according to size
        for j=1:y_size
			data(index,:) = image(i,j,:);
			index = index + 1;
        end
    end
       
    % We will do union-find on p_labels to label all the peaks.
    p_labels = 1:x_size*y_size;                                            % change this if you change data points
    peaks = zeros(x_size*y_size, d);
    r = params(1);
    
    
    for i=1:x_size*y_size
		peaks(i,:) = meanshift(data, i, params);
        for j=1:i-1
			if euclidean_distance(peaks(i),peaks(j)) < r/2                               % norm or pdist2
                p_labels(i) = get_root(p_labels, j);
                break;                                                     % may comment if results get worse
			end	
        end
    end

    % label all image    
	index = 1;
    for i=1:x_size                                                         
        for j=1:y_size
			labels(i,j) = p_labels(index);
			index = index + 1;
        end
    end
end

% This functions returns the root of the ith node.
function root = get_root(nodes, i) 
    while nodes(i) ~= i
        i = nodes(i);
    end
    root = nodes(i);
end

function D = euclidean_distance(X, Y)
    V = X - Y;
    D = sqrt(V * V');
    %D = bsxfun(@plus,dot(X,X,1)',dot(Y,Y,1))-2*(X'*Y);
end