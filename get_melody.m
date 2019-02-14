function xx = get_melody(startPulses,durations,noteNumbers)
% GET_MELODY  Create a sequence of notes made up of pure sinusoidal
%              waveforms that vary in duration/frequency
%
%           xx = the output array of notes that make a musical melody
%  startPulses = Starting Pulse of a note
%    durations = the note's duration in pulses
%  noteNumbers = The note's Key number such as (C3,..A4,..G5,etc)
%

fs = 11025; % Sampling frequency, [samples/sec]

% Find seconds_per_pulse to convert "durations" input from pulses to time
bpm = 120; %  Beats Per Minute
beats_per_second = bpm/60;
seconds_per_beat = 1/beats_per_second;
seconds_per_pulse = seconds_per_beat / 4;
time_dur_per_note = durations * seconds_per_pulse;

length_xx = ceil(sum(time_dur_per_note)+1)*fs;
xx = zeros(1,length_xx);    % pre-fill max size of melody
x = 1; % Default value for complex amplitude input to key2note
n1=startPulses(1);  % Begin melody at starting place of 1st note
for kk = 1:length(noteNumbers)

    keynum = noteNumbers(kk);
    dur = time_dur_per_note(kk);
    note = key2note(x,keynum,dur);  % x=1 before for loop.
    
    E_length = length(note); % Envelope length must be same as note length
    
    upramp   = round( 0.1 * E_length ); % Percentage of note for ramp
    downramp = round( 0.2 * E_length ); % Percentage of note for downramp
    hold     = E_length-upramp-downramp; % Percentage of note to hold max
     
    E_upramp = linspace(0,1,upramp);   % ramp up from 0 to 1
    E_hold   = ones(1,hold);           % hold note at max value
    E_deramp = linspace(1,0,downramp); % down ramp from 1 to 0
     
    % Create an envelope, E, that linearly 
    % ramps up from 0 to 1, holds, then ramps down to 0 at set intervals
    E = [ E_upramp E_hold E_deramp ];
    % E: truncate extraneous values due to rounding
    E = E(1:length(note));
    % Multiply note by E envelope
    note = E.*note;
    
    n2 = n1 + length(note) - 1;     % Find end of note's "sub-array"
    xx(n1:n2) = xx(n1:n2) + note;   % Insert note's "sub-array" into melody
    n1 = startPulses(kk)+n2;        % Find start of next note's "sub-array"
end