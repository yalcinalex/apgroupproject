% takes in a list of input words and generates the corresponding outputs
% syllable counts
% takes in a row cell array
function counts = syllable_counts(words)
    % common variables
    n = length(words);
    % initialise counts
    counts = zeros(1,n); % row or column vector should not matter
    for i = 1:n
        % single character words have a default of 0 (as it is punctuation)
        % while multi character words have default 1
        % further changes are made separately to ensure counts is correct.
        if (length(words{i}) == 1)
            if (~is_punc(words{i}) && ~is_space(words{i}))
                counts(i) = syllable_count(words{i}, 0, i);
            end
        else
            counts(i) = syllable_count(words{i}, 1, i);
        end
    end
end