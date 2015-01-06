function [spectrum Freq] = cal_freq(signal, flags)

%% applying a low-pass filter
% [B,A] = butter(2, 0.93, 'low');
% signal = filter(B,A,signal);

Len = max(size(signal));
spectrum = fftshift(abs(fft(signal)));
ref = -1:1/(Len/2):1-1/(Len/2);
spectrum(find(abs(ref) <= 0.1458)) = 0;


if flags == 1
    figure;
    plot(-1:1/(Len/2):1-1/(Len/2),abs(spectrum),'r');
    index = max(find(abs(spectrum) == max(abs(spectrum))));
    omega = index * 1/(Len/2) - 1;
    Freq = omega * 480;
else
    thresh = 100;
    figure;
    plot(-1:1/(Len/2):1-1/(Len/2),abs(spectrum),'r');
    sorted = sort(spectrum,'descend');
    
    for i = 1:100
        if i == 1
            %index = find(spectrum == sorted(i));
            index = max(find(abs(spectrum) == sorted(i)));
            omega = index * 1/(Len/2) - 1;
            Freq(1) = omega * 480;
        else
            index = max(find(abs(spectrum) == sorted(i)));
            omega = index * 1/(Len/2) - 1;
            if abs(omega * 480 - Freq(1)) > thresh
                Freq(2) = omega * 480;
                break;
            else
                continue;
            end
        end 
    end
    
end