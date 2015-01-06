%% this function is used to recover the signal from the input frames sequence
%% by gabor filter which is not in the multi-scale framework
%% you shoud addpath GaborFilter
function signal = recover_signal(image_dir, num_of_frames)
%% -----------------
addpath ./GaborFilter
%% ----------------
num = length(num_of_frames);
img = FrameRead(image_dir, num_of_frames(1));

%% apply gabor filter 
[~, gaborIM] = gaborfilter(img, 0.5, 3, pi/4, 0);
phi0 = angle(gaborIM);
Phi = zeros(num, 1);
h = waitbar(0,'Please wait...');
for k = 2 : num
     waitbar(k/num,h)
    img = FrameRead(image_dir, num_of_frames(k));  
    [~, gaborIM] = gaborfilter(img, 0.5, 3, pi/4, 0);
    phi = angle(gaborIM); 
    phi_diff = phi - phi0; 
    phi = abs(gaborIM).^2 .* phi_diff;
    Phi(k) = sum(phi(:));
end
% high pass filter
[B,A] = butter(2, 0.2, 'high');
signal = filter(B,A,Phi);
end