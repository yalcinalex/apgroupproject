% removes annoying punctuation that makes the output of textGen less
% readable.
function good = preprocess_cstm3(raw)
    i=1; j=1; % indices of raw and temp, respectively
    n = length(raw);
    temp = blanks(n);
    while (i <= n)
        % checks for non apostrophe bad punctuation, and skips it
        if is_bad_punc(raw(i)) && raw(i) ~= ''''
            i = i+1;
        % checks for apostrophes that are not part of contractions
        elseif raw(i) == '''' && ~(is_letter(raw(i-1)) && is_letter(raw(i+1)))
            i = i+1;
        % otherwise, passed
        else
            temp(j) = raw(i);
            j=j+1; i=i+1;
        end
    end
    good = temp(1:j-1); % without unnecessary spacing at the end
end