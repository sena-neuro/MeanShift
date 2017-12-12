% data : nxd, params: r, the size of the search window and t, threshold
% criterion, c: center index
function peak = meanshift(data, c, params)
    % center coordinates
    center = data(c,:);
    
    while( ~is_coverged(center, mean_center) ) % change: they are not have to be equal
        peak
    end
    peak = center;
end

function is_coverged(center, mean_center)
end