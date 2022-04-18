% syllable counts for words
% index is only used in the case of an error for debugging purposes
function count = syllable_count(word, default, index)
    % finds the word in datamuse, and its syllable count. Prints to output
    % if there is no return, setting syllable count to a default value.
    api_word = webread("https://api.datamuse.com/words?sp="+string(word)+"&md=s&max=1");
    % error handling
    if (isempty(api_word))
        fprintf("error: %s (at index %i) has no matches\n", string(word), index);
        count = default;
        return; % a return statement is used to indicate that this is
        % unexpected behaviour, and to prevent errors.
    end
    count = api_word.numSyllables;
end