% syllable counts for words
function cnt = syllable_count(word, default, index)
    % finds the word in datamuse most similar to the given word, and its
    % syllable count. Prints to output if there is a difference.
    api_word = webread("https://api.datamuse.com/words?sp="+string(word)+"&md=s&max=1");
    % error handling
    if (isempty(api_word))
        fprintf("error: %s (at index %i) has no matches\n", string(word), index);
        cnt = default;
        return;
    end
    cnt = api_word.numSyllables;
end