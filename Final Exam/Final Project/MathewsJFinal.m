% Jibin Mathews
% ECE 3304 001 
% Final Matlab Project
% Program takes a recording and uses filter to remove noise

clc 
clear
% 1. Import Audio File 
    [Y,Fs] = audioread('Armstrong_Small_Step.ogg');

% 2. Find FFT of audio file
    y = fft(Y);
    N = Fs;
    P2 = abs(y/N);
    P1 = P2(1:N/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = Fs*(0:(N/2))/ N;
    subplot(2,1,1)
    plot(f,P1)
    title('Original Signal')
    xlabel('Frequency')
    ylabel('Amplitude')
    
    

audioinfo('Armstrong_Small_Step.ogg')

% 3. Determine Filter needed (Need to change around values)
%       May need multiple filters (Cascade) but make sure to find fft for each
%       process


filter1 = filter(LowPass, Y);
%filter2 = filter(HighPass,filter1);

    out = fft(filter1);
    N = Fs;
    out2 = abs(out/N);
    out1 = out2(1:N/2+1);
    out1(2:end-1) = 2*out1(2:end-1);
    f = Fs*(0:(N/2))/ N;
    subplot(2,1,2)
    plot(f,out1)
    title('Filtered Signal')
    xlabel('Frequency')
    ylabel('Amplitude')

sound(filter1,Fs)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Low Pass Filter

% Allows Frequency Below Cutoff Frequency to Pass

function Hd = LowPass
%LOWPASS Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.11 and Signal Processing Toolbox 8.7.
% Generated on: 03-May-2022 10:08:18

% Butterworth Lowpass filter designed using FDESIGN.LOWPASS.

% All frequency values are in Hz.
Fs = 11025;  % Sampling Frequency

Fpass = 3000;        % Passband Frequency
Fstop = 3500;        % Stopband Frequency
Apass = 1;           % Passband Ripple (dB)
Astop = 80;          % Stopband Attenuation (dB)
match = 'stopband';  % Band to match exactly

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.lowpass(Fpass, Fstop, Apass, Astop, Fs);
Hd = design(h, 'butter', 'MatchExactly', match);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% High Pass Filter
% Allows Frequency Above Cutoff Frequency to Pass

function Hd = HighPass
%HIGHPASS Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.11 and Signal Processing Toolbox 8.7.
% Generated on: 03-May-2022 10:18:30

% Butterworth Highpass filter designed using FDESIGN.HIGHPASS.

% All frequency values are in Hz.
Fs = 11025;  % Sampling Frequency

Fstop = 3000;        % Stopband Frequency
Fpass = 3500;        % Passband Frequency
Astop = 80;          % Stopband Attenuation (dB)
Apass = 1;           % Passband Ripple (dB)
match = 'stopband';  % Band to match exactly

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.highpass(Fstop, Fpass, Astop, Apass, Fs);
Hd = design(h, 'butter', 'MatchExactly', match);
end

