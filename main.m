function main
    close all;
    clear;
    path = 'cs484_hw3_data\';
   
    %%%%%%% Found this piece of code on http://matlab.wikia.com/wiki/FAQ#How_can_I_process_a_sequence_of_files.3F
    if ~isdir(path)
      errorMessage = sprintf('Error: The following folder does not exist:\n%s', path);
      uiwait(warndlg(errorMessage));
      return;
    end
    %%%%%%%
    
    files = dir( strcat(path, '*.jpg' ));
    files_gt = dir( strcat(path, '*.png' ));
    %params= [0.02 0.1 1 0];
    se = strel('disk', 1);
    rsz = 0.4;
    t = 3;
    for r=19:1:23
        params = [r t 0 0];
        for i=1:20
            filename_imgs = strcat(path, files(i).name);
            img = imread(filename_imgs);
            img = imresize(img, rsz);
            %figure, imshow(img); hold on;
            lab = rgb2lab(img);

            [labels, ~] = segmentImage(lab, params);
            %figure, imshow(label2rgb(labels));
            bounds = edge(labels, 'canny');
            img( img & bounds ) = 255; % red
            figure, imshow(img);
            name = strcat('a\',num2str(i),'r',num2str(r),'t',num2str(t),'.jpg');
            imwrite(img,name);

            filename_gt = strcat(path, files_gt(i).name);
            gt = imread(filename_gt);
            gt = imresize(gt, rsz);
            boundaries = edge(gt, 'canny');
            gt_bounds_dilated = imdilate(boundaries, se);
            %figure, imshow(label2rgb(gt_bounds_dilated));

            true_bounds = bounds & gt_bounds_dilated;
            n_gt_bounds_dilated = sum(gt_bounds_dilated);
            n_boundaries = sum(boundaries);
            n_true_bounds = sum(true_bounds);
            n_bounds = sum(bounds);
            precision = n_true_bounds / n_bounds;
            recall = n_true_bounds / n_boundaries;
            disp(strcat('t: ',num2str(params(2)),'r: ',num2str(params(1))));
            disp(strcat('precision:', num2str(precision), 'recall:', num2str(recall)));
        end
    end
end