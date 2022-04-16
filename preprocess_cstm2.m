% Adds whitespace around punctuations.
function good = preprocess_cstm2(raw)
    % max length of temp_text is twice raw_text
    i = 1; % raw_text index
    j = 1; % temp_text index
    n = length(raw);
    temp = blanks(3*n);
    % handle i=1 case here
    if (is_punc(raw(1)))
        temp(j+1) = raw(i);
        j = j+3;
    else
        temp(j) = raw(i);
        j = j+1;
    end
    i=2;
    while (i < n) % checks for punctuation: if there is a space (or newline) on one side then another is placed on the other side
        if ((raw(i) == '''') && (~is_letter(raw(i-1)) || ~is_letter(raw(i+1))))
            temp(j+1) = raw(i); % as whitespace already present
            i = i+1; j = j+3;
        elseif (is_punc(raw(i)) && (raw(i) ~= 39))
            temp(j+1) = raw(i);
            i=i+1; j=j+3;
        else
            temp(j) = raw(i);
            i = i+1; j = j+1;
        end
    end
    % handle i=n case here
    if (is_punc(raw(n)))
        temp(j+1) = raw(i); % as whitespace already present
        j = j+3;
    else
        temp(j) = raw(i);
        j = j+1;
    end
    %% this is bad coding but I am tired
    good = temp(1:j-1);
    for i=1:j-1
        if (good(i)==13)
            good(i)=newline;
        end
    end
end