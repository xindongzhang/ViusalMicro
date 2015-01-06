function imgout = FrameRead(image_dir, num)

%get specific frame from image_dir
filename = strcat(image_dir, '\', num2str(num), '.jpg');
imgout = imread(filename);
imgout = rgb2gray(imgout);