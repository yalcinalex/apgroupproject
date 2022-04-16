function isBadPunc = is_bad_punc(chara)
    isBadPunc = (chara == 34) || (chara == 39) || (chara == 95) || ...
    (chara == 8212) || (chara == 45) || (chara == 40) || (chara == 41);
end