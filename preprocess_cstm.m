% removes doubled newlines in input
function good_text = preprocess_cstm(raw_text)
    % Preallocates.
    n = length(raw_text);
    temp_text = blanks(n);
    i = 1; % char index for raw_text
    j = 1; % char index for temp_text
    while (i <= n)
        temp_text(j) = raw_text(i); % first stores word
        if ((raw_text(i) == newline) || raw_text(i) == 13) % 13 is carriage return
            if (i+1<n) % removes all following newlines and carriage returns
                while ((raw_text(i+1) == newline) || (raw_text(i+1) == 13))
                    i=i+1;
                end
            end
        end
        i=i+1;
        j=j+1;
    end
    good_text=temp_text(1:(j-1)); % good_text of appropriate length
end