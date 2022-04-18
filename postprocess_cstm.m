function proc = postprocess_cstm(raw)
    % This function processes the output from textGen_cstm to make it more
    % readable and grammatically consistent.
    % proc is a single character array, raw is a cell array of strings
    rawtext = [raw{1:end}];
    % Removes the first newline character for simplicity.
    rawtext = [rawtext(2:end),newline];
    
    % Removes: newline at start of each line, spaces before standard
    % punctuation, spaces after first " and before second "
    i = 1; j = 1; % indeces of rawtext and proc
    n = length(rawtext);
    temp = blanks(n); % temporary array for storing before proc defined at end
    quote = 0; % boolean for currently in quote
    while i < n
        % newline check: all newlines are doubled, removes half
        if (rawtext(i) == newline)
            temp(j) = rawtext(i);
            i = i+2; % skip newline and space
            j = j+1;
        % spaces before punctuation
        elseif (rawtext(i) == ' ' && is_punc(rawtext(i+1)))
            % check quote mark
            if (rawtext(i+1) == 34)
                if (quote) % this quote mark is endquote
                    temp(j) = rawtext(i+1);
                    i = i+2; % skip space before "
                    j = j+1; % supports punctuation after endquote
                else % beginquote
                    temp(j+1) = rawtext(i+1); % leave space
                    i = i+3; % skip space after "
                    j = j+2; % space and " added to char array
                end
                quote = ~quote; % quote = 1-quote; could also work
            % standard punc
            else
                  i = i+1; % just skip the space
            end
        % default case
        else
            temp(j) = rawtext(i);
            i = i+1; j = j+1;
        end
    end
    proc = temp(1:j-1); % shorten processed text to best length
end