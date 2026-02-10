% Parsa Khodabandehlou
% Sat. Feb 7th 2026
% pkhodab@ncsu.edu
%
% PA3_KHODABANDEHLOU.m


clear
clc
close all
%% Declerations

gameState = true;

guessList = [];

validGuess = [];

numGuess = 3;

scaryMode = false;

isLost = true;

timeOut = false;

timeLimit = 500;

runningTime = 0;

possibleColors = ["blue", "magenta", "red", "green",...
    "yellow"];

possibleSus = 2; % by default number of sus players is 2
if possibleSus >= length(possibleColors)
    possibleSus = length(possibleColors);
end

% Creating empty array of crewmates
players = Crewmate.empty(0, length(possibleColors));

maxGuess = numGuess;

%% Calculations

% making players!
for k = 1:length(possibleColors)
    players(k) = Crewmate(possibleColors(k));
end

idxs = randperm(numel(players));
players = players(idxs);

susdex = 1;
% assigning sussy levels
while susdex <= possibleSus
    players(susdex).sus = true;
    fprintf("\nsus: %s\n", players(susdex).color)  % hey grader! You can see which are
    % imposters here! just uncomment me!
    susdex = susdex + 1;
end

idxs = randperm(numel(players));
players = players(idxs);

% displaying valid guess begin
for k = 1:length(players)
    validGuess = [validGuess, players(k).color];
end

% main game loop
while gameState

    fprintf("\nvalid guesses are: \n")
    disp(validGuess)
    % displaying valid guess end

    %checking player guess:
    guessing = true;
    while guessing & numGuess ~= 0

        % scary mode means the player got one imposter, the other one is
        % ready to kill em.
        if scaryMode
            if numGuess < maxGuess
                winLoseMini = MiniGames(randi(6));
                if ~winLoseMini
                    guessing = false;
                    gameState = false;
                    break
                end
            end
            tic
            fprintf("You have %f seconds left!\n", timeLimit - runningTime)
            last_guess = input("You only got one shot to live another day: "...
                , "s");
            runningTime = toc + runningTime;
            if runningTime > timeLimit
                guessing = false;
                gameState = false;
                timeOut = true;
                break
            end
            [valid, idx] = check_guess(last_guess, validGuess);
            if ~valid | ~players(idx).sus
                guessing = false;
                gameState = false;
                fprintf("\n")

                break
            end

            if valid
                isLost = false;
                guessing = false;
                gameState = false;
                fprintf("\n")
                break
            end

        end
        tic
        fprintf("You have %f seconds left!\n", timeLimit - runningTime)
        g = input("Guess the imposter: ", "s");
        runningTime = runningTime + toc;
        if runningTime > timeLimit
            guessing = false;
            gameState = false;
            timeOut = true;
            break
        end

        if ~scaryMode
            [valid, idx] = check_guess(g, validGuess);
            if valid
                % check if were an imposter:
                if players(idx).sus
                    fprintf("%s was an imposter!\n", validGuess(idx))
                    numGuess = numGuess - 1;
                    validGuess(idx) = [];
                    scaryMode = true;
                    guessing = false;
                    fprintf("\n")
                    continue
                end
                if ~players(idx).sus
                    fprintf("%s was not the imposter!\n", validGuess(idx))
                    validGuess(idx) = [];
                    numGuess = numGuess - 1;
                    if numGuess == 0
                        fprintf("Game Over! No more guesses left.\n");
                        break;
                    end
                    guessing = false;
                    fprintf("\n")
                    continue
                end
            end

            if ~valid
                numGuess = numGuess - 1;
                if numGuess == 0
                    continue
                end
                fprintf("\nYou got %f guesses left", numGuess)
                fprintf("\n")
                continue
            end

        end

        if numGuess == 0
            break
        end
    end

    if numGuess == 0
        break
    end
end


%% Output

if ~isLost
    disp("congrats! You won!")
end

if isLost
    disp("You lose!")
end

%% simplified version
clear, clc, close all
% Check for input
%   - is it an element of the list
%       - if yes return the element and its index
%       - if no return false and 0
%   - if it is an element, check if we are an imposter.
%       - if we are an imposter
%


gameState = true;

guessList = [];

validGuess = [];

numGuess = 3;

scaryMode = false;

isLost = true;

timeOut = false;

timeLimit = 500;

runningTime = 0;

possibleColors = ["blue", "magenta", "red", "green",...
    "yellow"];


possibleSus = 2; % by default number of sus players is 2
if possibleSus >= length(possibleColors)
    possibleSus = length(possibleColors);
end

% making players!
for k = 1:length(possibleColors)
    players(k) = Crewmate(possibleColors(k));
end

idxs = randperm(numel(players));
players = players(idxs);

susdex = 1;
% assigning sussy levels
while susdex <= possibleSus
    players(susdex).sus = true;
    fprintf("\nsus: %s\n", players(susdex).color)  % hey grader! You can see which are
    % imposters here! just uncomment me!
    susdex = susdex + 1;
end

idxs = randperm(numel(players));
players = players(idxs);

% displaying valid guess begin
for k = 1:length(players)
    validGuess = [validGuess, players(k).color];
end

% Function returns true if the guess is valid
% also returns its index, we use it to go through
% the logic.

while (gameState) & (numGuess > 0)
    colors = [players.color];

    % Should ask the user for a guess AND verify it.
    [valid, idx] = guess(colors);


    if (valid) && (players(idx).sus)
        % the user has guessed the correct impostor.

        % remove the correct impostor from everything.
        players(idx) = [];
        colors(idx) = [];
        
        % Sabotage event
        game = MiniGames(randi(6));

        % Make the user re guess after sabotage.
        [valid, idx] = guess(colors);
        valid =  game & valid;

        if (valid) && (players(idx).sus)
            gameState = false;
            numGuess = 0;
            disp("congrats! You win!")
        else
            gameState = false;
            numGuess = 0;
            disp("You lose!")
        end


    elseif valid && ~(players(idx).sus)
        % the user has guessed a valid crewmate but not the correct
        % imposter.
        players(idx) = [];
        numGuess = numGuess - 1;


    elseif ~valid
        % the user has NOT made a valid guess.
        numGuess = numGuess - 1;


    else
        error("something is horribly wrong.")
    end


end