function outtext = textGen_cstm(mdl, first, min_length, nSamples)
%TEXTGEN generates random text based on a bigram or trigram language model
%   By default this function uses generates 5 senteces with minimum 5 words

if nargin == 3                                  % initialize default
    nSamples = 5;
elseif nargin == 2
    min_length = 5;
    nSamples = 5;
elseif nargin == 1
    first = newline; %% change
    min_length = 5;
    nSamples = 5;
end

outtext = cell(nSamples, 1);                    % initialize return value
N = 100;                                        % number of words
i = 1;                                          % initialize iterator
while sum(cellfun(@isempty, outtext)) ~= 0      % repeat to get nSamples
    sentence = cell(1, N);                      % accumulator
    sentence{1} = first;                        % begin the sentence
    
    if isa(mdl,'bigramClass')%% change
        for j = 2:N
            [next_word,~] =...                      % generate next word
                nextWord(sentence{j-1}, mdl);
            sentence{j} = next_word;            % add to the output
            if strcmp(next_word, newline)%% change
                break;                          % exit the loop
            end
        end
    else                                        % if a trigram model
        sentence{2} =...                        % we need to form a bigram
            nextWord(sentence{1}, mdl);         % using a bigram model first
        for j = 3:N
            prev = sentence(j-2:j-1);           % previous bigram
            prev = strjoin(prev, ' ');          % join them as string
            [next_word,~] =...                      % generate next word 
                nextWord(prev, mdl, 'tri');     % using a trigram model
            sentence{j} = next_word;            % add to the output
            if strcmp(next_word, newline)%% change
                break;                          % exit the loop
            end
        end
    end
    
    sentence(cellfun(@isempty, sentence)) = []; % remove empty cells
    %sentence(ismember(sentence,...              % remove <s> and </s>
    %    {'<s>', '</s>'})) = [];              %% removal
    if length(sentence) >= min_length           % if longer than min
        outtext{i} = strjoin(sentence, ' ');    % join words into a string
        i = i + 1;                              % increment iterator
    end
end

end

