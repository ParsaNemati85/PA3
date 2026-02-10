function [valid, idx] = guess(playerList)
% Parsa Khodabandehlou
% Tuesday Feb 10th 2026
% pkhodab@ncsu.edu
%
% Guess.m
% Just a wrapper for the check guess function, kinda neat.
% input:
%       playerList - A list of guesses.
% output:
%       valid -- If the users guess is valid.
%       idx   -- The index of the users guess.
    
g = input("Guess the imposter: ", "s");
% This function returns true if the guess is valid, and also the index
% of the guess.

[valid, idx] = check_guess(g, playerList);


end