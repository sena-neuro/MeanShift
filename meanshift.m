% data : nxd, params: r, the size of the search window and t, threshold
% criterion, i: center index
function peak = meanshift(data, i, params)
    % center coordinates
    center = data(i,:);
	
    r = params(1);
    t = params(2);
    mode = params(3);
	% n = size(data,1);													   % check
    %mean_center = -100;												   % check
    % k = 1 ;
    if mode == 0
        while( true )
            dist = norm(data-center);
            window = data(dist<r,:);
% 			for i=1:n  
% 				if( pdist2(data(i,:), center) < r ) % in_window_spectral(center, data(point,:), r) )
% 					window(k,:) = data(i,:);
%                     k = k + 1;
% 				end
% 			end
			mean_center = mean(window,1);									   % ? 
			if pdist2(center, mean_center) < t
				break;
			end
			center = mean_center;
        end
    elseif mode == 1
        while( true )
			for point=1:n  
				if(	in_window_spectral(center, data(point,:), r_spectral) && ...
                    in_window_spatial(center, data(point,:), r_spatial) )
					window(point,:) = (data(point,:));
				end
			end
			mean_center = mean(list);									   % ? 
			if norm(center - mean_center) < t
				break;
			end
			center = mean_center;
        end
    end
    peak = center;
end
	
	
   

% function val = in_window_spectral(a, b, r)
% 	r1 = a(1);
%     g1 = a(2);
%     b1 = a(3);
% 	r2 = b(1);
%     g2 = b(2);
%     b2 = b(3);
%     val =  (( r1 - r2 < r/2 || r2 - r1 < r/2 ) && ...
%             ( g1 - g2 < r/2 || g2 - g1 < r/2 ) && ...
%             ( b1 - b2 < r/2 || b2 - b1 < r/2 )) ;
% end
% 
% function val = in_window_spatial(a, b, r)
%     x1 = a(1);
%     y1 = a(2);
% 	x2 = b(1);
%     y2 = b(2);
%     val =  (( x1 - x2 < r/2 || x2 - x1 < r/2 ) && ...
%             ( y1 - y2 < r/2 || y2 - y1 < r/2 ) ) ;
% end