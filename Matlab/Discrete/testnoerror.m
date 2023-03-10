clc
clear

[Y , Fs] = audioread('Armstrong_Small_Step.ogg'); % Input Audio Signal to Matlab


Filtered_Audio = filter(HighPass, Y);


audioinfo('Armstrong_Small_Step.ogg')

sound(Filtered_Audio,Fs);


% To filter again...
% Find FFT of Filtered_Audio
% out = filter( FUNCTION FILTER, Filtered_Audio)
% type filterDesigner in command window



[N , P] = size(Y); % Determines how many samples audio file has

sampling_period = 1 / Fs ; % Sampling Period

t_max = (N-1)*sampling_period;

t = 0:sampling_period:t_max;


subplot(2,2,1)
plot(t , Y) % Plot Original Audio File
xlabel('Time (S)');
ylabel('Amplitude');
title('Original Audio File (Unfiltered)')




f = -Fs/2:Fs/(N-1):Fs/2; % Used for plotting frequency Spectrum

fft_Y = fftshift(fft(Y)); % Applies Fourier Transform to Audio File
subplot(2,2,2)
plot(f,abs(fft_Y));
xlabel('Power');
ylabel('Frequency');
title('Frequency vs Power Graph (Unfiltered)')





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5%%%% Low Pass Filter
% Allows Frequency Below Cutoff Frequency to Pass

function Hd = LowPass
%LOWPASS4K Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.12 and Signal Processing Toolbox 9.0.
% Generated on: 02-May-2022 22:09:02

% Equiripple FIR Lowpass filter designed using the FIRPM function.

% All frequency values are in Hz.
Fs = 11025;  % Sampling Frequency

Fpass = 3000;            % Passband Frequency
Fstop = 4000;           % Stopband Frequency
Dpass = 0.057501127785;  % Passband Ripple
Dstop = 0.0001;          % Stopband Attenuation
dens  = 16;              % Density Factor

% Calculate the order from the parameters using FIRPMORD.
[N, Fo, Ao, W] = firpmord([Fpass, Fstop]/(Fs/2), [1 0], [Dpass, Dstop]);

% Calculate the coefficients using the FIRPM function.
b  = firpm(N, Fo, Ao, W, {dens});
Hd = dfilt.dffir(b);
end
% [EOF]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5%%%% Band Pass Filter
% Allows frequency within the range of First and second cutoff to pass

function Hd = BandPass
%BANDPASS Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.12 and Signal Processing Toolbox 9.0.
% Generated on: 02-May-2022 22:17:45

% Butterworth Bandpass filter designed using FDESIGN.BANDPASS.

% All frequency values are in Hz.
Fs = 11025;  % Sampling Frequency

N   = 1000;    % Order
Fc1 = 1000;   % First Cutoff Frequency
Fc2 = 2000;  % Second Cutoff Frequency

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.bandpass('N,F3dB1,F3dB2', N, Fc1, Fc2, Fs);
Hd = design(h, 'butter');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5%%%% High Pass Filter
% Allows Frequency Above Cutoff Frequency to Pass

function Hd = HighPass
%HIGHPASS Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.11 and Signal Processing Toolbox 8.7.
% Generated on: 03-May-2022 08:17:05

% Butterworth Highpass filter designed using FDESIGN.HIGHPASS.

% All frequency values are in Hz.
Fs = 11025;  % Sampling Frequency

Fstop = 1000;        % Stopband Frequency
Fpass = 3000;       % Passband Frequency
Astop = 80;          % Stopband Attenuation (dB)
Apass = 1;           % Passband Ripple (dB)
match = 'stopband';  % Band to match exactly

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.highpass(Fstop, Fpass, Astop, Apass, Fs);
Hd = design(h, 'butter', 'MatchExactly', match);
end

