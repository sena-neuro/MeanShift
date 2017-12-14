function [labels,peaks] = segmentImage(image, params)
	
	% Prepare the datapoints
	index = 1
	for i=1:10:size(image,1)													% we can auto select increment according to size
		for j=1:10:size(image,2)
			data[index] = image(i,j,:);
			index++;
		end
	end
	
	%labels = []
	params = [10,10,'spectral']
	
	size_of_peaks = 0;																		% k : number of accepted peaks
	%temp_labels[1] = 1;
	
	for i=1:index-1
		poss_peak = meanshift(data, i, params);
		not_peak = false;
		for j=1:size_of_peaks
			if (norm(poss_peak, peaks(j)) < r/2)
				not_peak = true;
			end	
		end
		if ~not_peak
			size_of_peaks++;
			peaks(k,:) = poss_peak;
		end
	end
	
	% for i=1:
	

end