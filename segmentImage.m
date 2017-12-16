function [labels,peaks] = segmentImage (image, params)
    close all;
	x_size = size(image,1);
    y_size = size(image,2);
    data = zeroes(x_size*y_size); %floor(x_size/10), floor(y_size/10));
	% Prepare the spectral datapoints
    
	index = 1;
    for i=1:x_size                                                         % we can auto select increment according to size
        for j=1:y_size
			data(index) = image(i,j,:);
			index = index + 1;
        end
    end
       
	d = 3; % size(data,2);
    % We will do union-find on p_labels to label all the peaks.
    p_labels = 1:x_size*y_size;                                            % change this if you change data points
    peaks = zeros(x_size*y_size, d);
    r = params(1);
    t = params(2);
    mode = params(3);
    
    for i=1:x_size*y_size
		peaks(i,:) = meanshift(data, i, params);
        for j=1:i-1
			if pdist2(peaks(i),peaks(j)) < r/2                             % norm or pdist2
                p_labels(i) = get_root(p_labels, j);
                %break;
			end	
        end
    end
%     for i=1:x_size*y_size
%         for j=1:i-1                                                      
%             if pdist2(peaks(i),peaks(j)) < r/2 
%                 p_labels(get_root(p_labels,i)) = get_root(p_labels,j);
%             end
%         end
%     end
    show = peaks(unique(p_labels),1:2);
    scatter(peaks(:,1),peaks(:,2), 'Marker', '+', 'MarkerFaceColor', [1 0 0] );
    scatter(show(:,1),show(:,2), 'Marker', 's', 'MarkerFaceColor', [0 0 0] );  pause;
    clear;
end



% This functions returns the root of the ith node.
function root = get_root(nodes, i) 
    while nodes(i) ~= i
        i = nodes(i);
    end
    root = nodes(i);
end
