function main
    path = 'C:\Users\lenovo\Desktop\MeanShiftHW\cs484_hw3_data\';
    
    %%%%%%%%%%%%%%%%%%%% spatial + params %%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%% Found this piece of code on http://matlab.wikia.com/wiki/FAQ#How_can_I_process_a_sequence_of_files.3F
    if ~isdir(path)
      errorMessage = sprintf('Error: The following folder does not exist:\n%s', path);
      uiwait(warndlg(errorMessage));
      return;
    end
    %%%%%%%
    files = dir( strcat(path, '*.jpg' ));
    filename = strcat(path, files(1).name);
    img = imread(filename);
    img = imresize(img, 0.1);
    params= [0.2 0.1 1];
    [labels peaks] = segmentImage(img, params);
    figure, imshow(label2rgb(labels));
end