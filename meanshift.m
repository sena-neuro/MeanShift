% data : nxd, params: r, the size of the search window and t, threshold
% criterion, i: center index
function peak = meanshift(data, i, params)
    % center coordinates
    center = data(i,:);
	
    r, t, mode = params;
	n = size(data,1);															% check
    mean_center = -100;															% check
	list = []
	if( mode == 'spectral')
		while( true )
			for( point=1:n ) 
				if(	inwindow(center, point, r) )
					list.append(point);
				end
			end
			mean_center = mean(list);											% ? 
			if (norm(center - mean_center) < t)
				break;
			end
			center = mean_center
		end
	end
	peak = center;
end

function in_window(x, y, r)
	r1, g1, b1 = x;
	r2, g2, b2 = y;
	return if(	r1 - r2 < r/2 || r2 - r1 < r/2 ...
				g1 - g2 < r/2 || g2 - g1 < r/2 ...
				b1 - b2 < r/2 || b2 - b1 < r/2 );
end