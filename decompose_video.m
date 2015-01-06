function num_of_frames = decompose_video(input_filename, output_filename)

%exam
%input_filename = 'WildLife.wmv';
%output_filename = 'output';

if ~isdir(output_filename)
    mkdir(output_filename)
end


mycmd = ['ffmpeg-win32\bin\ffmpeg -i ' input_filename ' ' output_filename '\%d.jpg'];
system(mycmd);
clc;
num = dir(output_filename);
num_of_frames = numel(num) - 2;
disp(['video decomposition is over!']);
disp(['the number of the frame is ' num2str(num_of_frames)]);

end


