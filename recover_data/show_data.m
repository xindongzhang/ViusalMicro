clear all;
close all;
clc;

addpath ../
addpath ../GA_code

load ./video1.mat
load ./video2.mat

for i = 1:numel(video1)
    if i <= 4
        [~, video_freq1{i}] = cal_freq(video1(i).signal, 1);
        [~, video_freq2{i}] = cal_freq(video2(i).signal, 1);
    elseif i > 4 && i < numel(video1)
        [~, video_freq1{i}] = cal_freq(video1(i).signal, 2);
        [~, video_freq2{i}] = cal_freq(video2(i).signal, 2);
    else
        [denoise1 FS1] = SpeechDenoise(resample(video1(i).signal,8192,960), 8192);
        [denoise2 FS2] = SpeechDenoise(resample(video2(i).signal,8192,960), 8192);
        denoise1 = mapminmax(denoise1')';
        denoise2 = mapminmax(denoise2')';
    end
end

disp(['press any key to play the fist music']);
pause();

sound(denoise1);

disp(['press any key to play the second music']);
pause();


disp(['the frequency of the result are in video_freq1 and video_freq2'])
sound(denoise2);