"A geometric approach to spectral subtraction"
Speech Communication 50 (2008) 453-466
Yang Lu, Philipos C. Loizou
University of Texas at Dallas
2008
Email:
luyang1980@gmail.com  
loizou@utdallas.edu

revision: 
line 98:
 ksi2 = aa*Xk_prev./noise_mu2_old + (1-aa)*post_SNR;
The previous line 97 (now commented) is the "Decision-Directed", as noted in the first released code, "OLD a priori SNR"
Yang Lu Nov 2, 2008 


Usage:
xfinal = GA_SE(filename,outfile);
Input: 
    filename: the file name of the noisy speech
    outfile:  the file name of the enhanced speech
Output:   
    xfinal:   the time-signal of the enhanced speech

i.e.
GA_SE('sp0501_babble_sn5.wav','out.wav');


