load("bach_fugue.mat")  % load "theVoices" structure with bach fugue info.

melody = cell(1,length(theVoices)); % pre-fill melody cell-array

% Iterate through the three different bach fugue melodies in theVoices
for idx=1:length(theVoices)
    % Starting pulse of the note. Used for arranging placements of notes
    % relative to each other.
    startPulses = theVoices(idx).startPulses;
    % Duration of note in "pulses". Later converted to time duration
    durations   = theVoices(idx).durations;
    % Note Number later coverted to a frequency in sinusoidal eg(A4=440 Hz)
    noteNumbers = theVoices(idx).noteNumbers;
    % Store melody output in cell array
    melody{idx} = get_melody(startPulses, durations, noteNumbers);
end
bach = sum([melody{:}],1);  % Sum melody cell-arrays into one bach song

filename = 'bach_fugue.wav';
audiowrite(filename,bach,11025);
