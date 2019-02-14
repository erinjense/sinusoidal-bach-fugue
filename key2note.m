function xx = key2note(X, keynum, dur)
% KEY2NOTE Produce a sinusoidal waveform corresponding to a given
%   piano key number
%
%     xx = the output sinusoidal waveform
%      X = complex amplitude for the sinusoid
% keynum = the piano keyboard number of the desired note
%    dur = the duration (in seconds) of the output note
%

f49    = 440;       % the frequency of A4 or key 49. 440 [Hz]
keypos = keynum-49; % position of key relative to the 49th key(A-440)
fnote  = f49 * 2^(keypos/12);  % frequency of note. Converted from keynum

fs = 11025;        % sample frequency. [Hz]
tt = 0:(1/fs):dur; % time vector

xx = real(X.*exp(1i*2*pi*fnote*tt)); % real part of pure complex sinusoid
