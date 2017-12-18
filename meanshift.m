% data : nxd, params: r, the size of the search window and t, threshold
% criterion, i: center index
function peak = meanshift(data, i, params)
    % center coordinates
    r_spectral = params(1);
    t = params(2);
    mode = params(3);
    r_spatial = params(4);
    center = data(i,:);
    if mode == 0
        while( true )
            dist =  sqrt(sum((data-center) .^ 2,2));
            window = data(dist<r_spectral,:);
			mean_center = mean(window,1);								   % ? 
			if euclidean_distance(center, mean_center) < t % change
				break;
			end
			center = mean_center;
        end
%     elseif mode == 1
%         spectral_features = data(i,1:3);
%         spatial_features = data(i,4:5);
%         spectral_center = spectral_features(i,:);
%         spatial_center = spatial_features(i,:);
% 
%         while( true )
%             center_spectral = spectral_features(i,:);
%             center_spatial = spatial_features(i,:);
%             dist_spectral = pdist2(spectral_features,center);
%             dist_spatial = pdist2(spatial_features, center_spatial);
%             logic = dist_spectral<r_spectral & dist_spatial<r_spatial;
%             %%%%%%%%%%%%%
%             window = data(logic,:);
% 			mean_center = mean(window,1);								   % ? 
% 			if norm(center - mean_center) < t
% 				break;
% 			end
% 			center = mean_center;
%         end
    end
    peak = center;
end

function D = euclidean_distance(X, Y)
    V = X - Y;
    D = sqrt(V * V');
    %D = bsxfun(@plus,dot(X,X,1)',dot(Y,Y,1))-2*(X'*Y);
end