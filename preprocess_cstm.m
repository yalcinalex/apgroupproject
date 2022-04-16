function good_text = preprocess_cstm(raw_text)
    % Preallocates.
    n = length(raw_text);
    temp_text = blanks(n);
    i = 1; % char index for raw_text
    j = 1; % char index for good_text
    while (i <= n)
        temp_text(j) = raw_text(i);
        if ((raw_text(i) == newline) || raw_text(i) == char(13))
            if (i+1<n)
                %fprintf('notatend: '); fprintf('%i\n', i);
                while ((raw_text(i+1) == newline) || (raw_text(i+1) == char(13)))
                    %fprintf('newlinefound');
                    i=i+1;
                end
            end
        end
        i=i+1;
        j=j+1;
    end
    good_text=temp_text(1:(j-1));
end