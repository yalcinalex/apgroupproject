% checks to see if a given character is whitespace
function isSpace = is_space(chara)
    isSpace = (chara == newline || chara == 13 || chara == ' ');
end
% 13 is carriage return