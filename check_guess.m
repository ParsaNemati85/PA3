function [isValid, idx] = check_guess(guess, listValid)
% Parsa Khodabandehlou
% Sat Feb. 7 2026
% pkhodab@ncsu.edu
% 
% check_guess.m
% checks guess of the user against some index of valid guesses.
%
% inputs:
%        guess     -- user guess (char/string)
%        listValid -- list to run the guess against (list of str/char)
% outputs: 
%        isValid   -- bool for checking if the user guess is valid

% user guess is valid iff the length of the guess is 1, AND
% the guess itself matches the start of at least one element
% in listValid.

if length(guess) ~= 1
    isValid = false;
    idx = 0;
end

for k = 1:length(listValid)
    % Direct indexing isnt allowed for some reason??????
    % listValid(k)(1) would be ideal, but this is a work around.
    temp = char(listValid(k));
    if temp(1) == guess
        isValid = true;
        idx = k;
        return
    end
end

isValid = false;
idx = 0;


end