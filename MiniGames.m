function win = MiniGames(gameNumber)
% Isaac Paolino, Naji Husseini, Amy Adkins, and Jakob Halbur
% ijpaolin@ncsu.edu
% 14 Jan 2026
% miniGames.m

% Function Description
% This function contains minigames playable by the user when called by the
% respective gameNumber. The function prints a message to the user with
% win status.

%   Games included:
%       Vowels
%       Type the code
%       Binary Numbers
%       Type the Third Character
%       Hidden Word

% Input:  gameNumber - selects the game corresponding to the gameNumber
% Output: win - boolean output reporting win or loss

%% Declarations
win = true;
msg = 'You win!';

%% Vowels
% BME Vowel Count Challenge
if gameNumber == 1

    bmeWords = ["Ultrasound", "Biomechanics", "Prosthetic", "Scaffold", ...
        "Bioinformatics", "Electrode", "Biosensor", "Imaging", ...
        "Hemodynamics", "Nanomedicine"];

    win = true;
    fprintf('To prove you aren''t the imposter and can keep calm, you have to solve this puzzle.\n')
    fprintf('Count the number of vowels (A, E, I, O, U) in the word.\n')


    randomIndex = randi(length(bmeWords));
    currentWord = bmeWords(randomIndex);
    lowerWord = lower(char(currentWord));

    vowelMask = ismember(lowerWord, 'aeiou');
    correctCount = sum(vowelMask);

    prompt = sprintf('How many vowels are in "%s"?\n', currentWord);
    userInput = input(prompt);

    if isempty(userInput) || userInput ~= correctCount
        win = false;
        msg = sprintf('Mission failed. "%s" has %i vowels.\n', currentWord, correctCount);
    else
        msg = sprintf('Congratulations! You completed the BME Vowel Challenge.\n');
    end

%% Type the Code
elseif gameNumber == 2

    alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    charIndices = randi(length(alphabet), 1, 10);
    randomCode = alphabet(charIndices);

    % isstrprop identifies 'digit' (0-9) characters
    digitMask = isstrprop(randomCode, 'digit');
    correctNumbers = randomCode(digitMask);

    fprintf('Your code is: %s\n', randomCode)
    fprintf('The vent is locked. You have to unlock it to escape the imposter.\n')
    fprintf('The code was encypted with letters that will not open the lock.\n')
    fprintf('Task: Type ONLY the numbers found in the code, in the order they appear.\n\n')

    userInput = input('Enter numbers: ', 's');

    if strcmp(userInput, correctNumbers)
        msg = sprintf('Success! Verification complete.\n');
    else
        msg = sprintf('Failure! The correct number sequence was: %s\n', correctNumbers);
        win = false;
    end

%% Binary Numbers
elseif gameNumber == 3
    numbers = 0:10;

    targetDec = numbers(randi(length(numbers)));

    correctBinary = dec2bin(targetDec, 4);
    fprintf('The reactor is about to explode but the computer has been sabotaged and won''t accept the password in base 10.\n')
    fprintf('Convert the decimal number. For example, 12 becomes 1100.\n')
    prompt = sprintf('What is %i in 4-bit binary? ', targetDec);
    userInput = input(prompt, 's');

    if ~strcmp(userInput, correctBinary)
        msg = sprintf('SYSTEM FAILURE! %i is %s in binary.\n', targetDec, correctBinary);
        win = false;
    else
        msg = sprintf('Data Verified. Correct!\n');
    end

%% Type the third character
elseif gameNumber == 4
    bmeWords = ["Ultrasound", "Biomechanics", "Prosthetic", "Scaffold", ...
        "Bioinformatics", "Electrode", "Biosensor", "Imaging", ...
        "Hemodynamics", "Nanomedicine"];

    numRounds = 3;
    win = true;
    fprintf('The O2 filter is clogged with BME terminology!\n')
    fprintf('Enter the 3rd letter of each code to open and clear the vents.\n')
    fprintf('Don''t choke under the pressure—one typo and the ship runs out of air!\n\n')
    fprintf('Type the THIRD letter of each word. One mistake and you lose!\n\n')
    randomInd = randperm(length(bmeWords), numRounds);

    for i = 1:numRounds
        currentWord = bmeWords(randomInd(i));

        charArray = char(currentWord);
        correctLetter = charArray(3);

        prompt = sprintf('Round %i: What is the 3rd letter of "%s"? ', i, currentWord);
        userInput = input(prompt, 's');

        if ~strcmpi(userInput, correctLetter)
            win = false;
            msg = sprintf('Game Over. Better luck next time.\n');
            break;
        else
            fprintf('Correct!\n\n')
            msg = sprintf('Congratulations! You passed the challenge.\n');

        end
    end

%% Hidden word
elseif gameNumber == 5

    bmeWords = ["HAND", "HEART", "MATLAB", "GENE", "SIGNAL", ...
        "BIOMEDICAL","LUNG","PHOTOPLETHYSMOGRAPHY"];

    targetWord = bmeWords(randi(length(bmeWords)));
    charWord = char(targetWord); % Convert to char to shuffle letters

    scrambledIndices = randperm(length(charWord));
    scrambledWord = charWord(scrambledIndices);

    fprintf('The code to the voting room is locked.\n')
    fprintf('You need to unscramble the BME related word to vote!\n')
    fprintf('Unscramble the following BME term: %s\n', scrambledWord)

    userInput = input('Your answer: ', 's');

    if strcmpi(userInput, targetWord)
        msg = sprintf('Correct! You unscrambled the word.\n');
    else
        msg = sprintf('Incorrect. The word was: %s\n', targetWord);
        win = false;
    end

%% Coin flip, I am lazy
elseif gameNumber == 6
    ht = randi(2); 

    fprintf("Heads or Tails?\n");
    fprintf("Enter 1 for Heads and 2 for Tails.\n\n")
    disp(ht)

    guess = input("Which will it be: ");

    if guess == ht
        win = true;
        msg = sprintf("Fate smiles upon thee!\n")
    end
    if guess ~= ht
        win = false;
        msg = sprintf("You shall not pass!\n");
    end

else
    win = false;
    msg = 'Invalid entry. You lose.';
end

%% Outputs
fprintf('%s',msg)