clear all;
close all;
clc;

addpath ./GaborFilter
addpath ./GA_code


%% node : syn;single;single;single;double;double;dboue;music
video1_node = [1 780; 1741 2700; 2701 3660; 3661 4620;...
               5661 6520; 6561 7520; 7521 8480; 9441 16160];
video2_node = [1 660; 1621 2580; 2581 3540; 3541 4500;...
               5461 6420; 6421 7380; 7381 8340; 9280 16000];        
           
           
input_filename1 = 'data/Video1';
input_filename2 = 'data/Video2';

video_signal1 = cell(max(size(video1_node)), 1);
video_signal2 = cell(max(size(video2_node)), 1);
video_freq1 = cell(max(size(video1_node)), 1);
video_freq2 = cell(max(size(video2_node)), 1);

% video1 = struct('signal', video_signal1, 'frequency', video_freq1);
% video2 = struct('signal', video_signal2, 'frequency', video_freq2);


%h = waitbar(0,'Please wait...');
iter_num = max(size(video1_node));
for i = 1: iter_num
    %waitbar(i/iter_num,h);
    tmp_node1 = video1_node(i,1):video1_node(i,2);
    tmp_node2 = video2_node(i,1):video2_node(i,2);
    video_signal1{i} = recover_signal(input_filename1, tmp_node1);
    video_signal2{i} = recover_signal(input_filename2, tmp_node2);
end


for i = 1:numel(video_signal1)
    if i <= 4
        [~, video_freq1{i}] = cal_freq(video_signal1{i}, 1);
        [~, video_freq2{i}] = cal_freq(video_signal2{i}, 1);
    elseif i > 4 && i < numel(video_signal1)
        [~, video_freq1{i}] = cal_freq(video_signal1{i}, 2);
        [~, video_freq2{i}] = cal_freq(video_signal2{i}, 2);
    else
        [denoise1 FS1] = SpeechDenoise(resample(video_signal1{i},8192,960), 8192);
        [denoise2 FS2] = SpeechDenoise(resample(video_signal2{i},8192,960), 8192);
        denoise1 = mapminmax(denoise1')';
        denoise2 = mapminmax(denoise2')';
    end
end

wavwrite(denoise1,'denoise1.wav');
wavwrite(denoise2,'denoise2.wav');

video1 = struct('signal', video_signal1, 'frequency', video_freq1, 'music', denoise1);
video2 = struct('signal', video_signal2, 'frequency', video_freq2, 'music', denoise2);
wavwrite(denoise1, 'denoise1.wav');
wavwrite(denoise2, 'denoise2.wav');



