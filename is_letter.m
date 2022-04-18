% checks if the given character is a letter, which is used to determine the
% context of particular punctuation (apostrophe).
function isLetter = is_letter(character)
    isLetter = ((character >= 'A' && character <= 'Z') ...
        || (character >= 'a' && character <= 'z'));
end