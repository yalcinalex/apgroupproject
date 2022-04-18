% Adds whitespace around punctuation, context dependent.
% apostrophes in contractions should not have spaces inserted as
% contractions are treated as single words.
function good = preprocess_cstm2(raw)
    % max length of temp_text is thrice raw_text for all characters punc.
    i = 1; % raw_text index
    j = 1; % temp_text index
    n = length(raw);
    temp = blanks(3*n);
    % for the first character, contractions check not necessary.
    if (is_punc(raw(1)))
        temp(j+1) = raw(i);
        j = j+3;
    else
        temp(j) = raw(i);
        j = j+1;
    end
    i=2; % looping over middle cases
    while (i < n)
        % checks if apostrophe is not a contraction apostrophe
        if ((raw(i) == '''') && (~is_letter(raw(i-1)) || ~is_letter(raw(i+1))))
            temp(j+1) = raw(i); % as whitespace already present
            i = i+1; j = j+3;
        % checks for non-apostrophe punctuation
        elseif (is_punc(raw(i)) && (raw(i) ~= ''''))
            temp(j+1) = raw(i);
            i=i+1; j=j+3;
        % must be a contraction apostrophe or letter (no spacing)
        else
            temp(j) = raw(i);
            i = i+1; j = j+1;
        end
    end
    % final character does not need contraction checks
    if (is_punc(raw(n)))
        temp(j+1) = raw(i); % as whitespace already present
        j = j+3;
    else
        temp(j) = raw(i);
        j = j+1;
    end
    % carriage returns are replaced with newline characters for
    % consistency.
    good = temp(1:j-1);
    for i=1:j-1
        if (good(i) == 13)
            good(i) = newline;
        end
    end
end