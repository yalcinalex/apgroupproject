function isLetter = is_letter(character)
    isLetter = ((character >= 65 && character <= 90) ...
        || (character >= 97 && character <= 122));
end