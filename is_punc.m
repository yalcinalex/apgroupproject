% checks if the given character is punctuation, for the preprocesser so
% that punctuation can be treated as words.
function isPunc = is_punc(character)
    isPunc = ((character >= '!' && character <= '/') ...
        || (character >= ':' && character <= '@') ...
        || (character == newline) || (character == 13) ... % carriage return is 13
        || character == '—');
end
% carriage return is an alternative to newline, but it is a different
% character, so must be handled separately