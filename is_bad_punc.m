% Several instances of punctuation (_, -, ") are not handled well, so are
% removed. This returns a boolean value of whether removal is necessary.
function isBadPunc = is_bad_punc(chara)
    isBadPunc = (chara == '"') || (chara == '''') || (chara == '_') || ...
    (chara == '—') || (chara == '-') || (chara == '(') || (chara == ')');
end