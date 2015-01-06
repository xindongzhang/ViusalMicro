clear all;
close all;
clc;

addpath ./textureSynth/matlabPyrTools/;
addpath ./textureSynth/matlabPyrTools/MEX;
addpath ./GaborFilter

%% add your input video directory
%% decompose the video into image sequence
input_video_dir = 'test.wmv';
output_image_dir = 'Test_Dir';

%% first need to decompose your video into images
num_of_frames = decompose_video(input_video_dir, output_image_dir);

%% recover the signal from given video
signal = recover_signal(output_image_dir, 1:num_of_frames);
%% calculate its frequency

Len = max(size(signal));

freq = fftshift(abs(fft(signal)));
figure;
plot(-1:1/(Len/2):1-1/(Len/2),abs(freq),'r');
title('frequency');

index = max( find(abs(freq) == max(abs(freq))));
omega = index * 1/(Len/2) - 1;
Fre = omega * 480;

disp(['the frequency of the signal is: ' num2str(Fre)]);


