%% This editted function matches syllable counts to a list.
% Checks against the syllable count with up to syll_att generated

function outtext = textGen_cstm2(mdl, first, min_length, nlines, syll_target, syll_att, syll_count_ref_data)
%TEXTGEN generates random text based on a bigram or trigram language model
%   By default this function uses generates 5 senteces with minimum 5 words

if nargin == 3                                  % initialize default
    nlines = 5;
    syll_target = ones(nlines,1)*min_length; %% change
    syll_att = 10;
    load('syllable_counts.mat', 'syll_counts');
    syll_count_ref_data = syll_counts;
elseif nargin == 2
    min_length = 5;
    nlines = 5;
    syll_target = ones(nlines,1)*min_length; %% change
    syll_att = 10;
    load('syllable_counts.mat', 'syll_counts');
    syll_count_ref_data = syll_counts;
elseif nargin == 1
    first = newline; %% change
    min_length = 5;
    nlines = 5;
    syll_target = ones(nlines,1)*min_length; %% change
    syll_att = 10;
    load('syllable_counts.mat', 'syll_counts');
    syll_count_ref_data = syll_counts;
end

outtext = cell(nlines, 1);                    % initialize return value
N = 100;                                        % number of words
i = 1;                                          % initialize iterator
while sum(cellfun(@isempty, outtext)) ~= 0      % repeat to get nSamples
    sentence = cell(1,N);
    best_syll_count_so_far = 0;
    %% loop this to find closest sentence (uses earliest that matches closest)
    for k = 1:syll_att
        temp_sentence = cell(1, N);                      % accumulator
        temp_sentence{1} = first;                        % begin the sentence
        indeces = ones(1,N); % indeces of words in temp_sentence, for finding syll
        
        if isa(mdl,'bigramClass')%% change
            for j = 2:N
                [next_word,indeces(j)] =...                      % generate next word
                    nextWord(temp_sentence{j-1}, mdl);
                temp_sentence{j} = next_word;            % add to the output
    
                if strcmp(next_word, newline)%% change
                    break;                          % exit the loop
                end
            end
        else                                        % if a trigram model
            [temp_sentence{2},indeces(2)] =...                        % we need to form a bigram
                nextWord(temp_sentence{1}, mdl);         % using a bigram model first
            for j = 3:N
                prev = temp_sentence(j-2:j-1);           % previous bigram
                prev = strjoin(prev, ' ');          % join them as string
                [next_word,indeces(j)] =...                      % generate next word 
                    nextWord(prev, mdl, 'tri');     % using a trigram model
                temp_sentence{j} = next_word;            % add to the output
                if strcmp(next_word, newline)%% change
                    break;                          % exit the loop
                end
            end
        end

        temp_sentence(cellfun(@isempty, temp_sentence)) = []; % removing empty cells

        curr_syll_count = sum(syll_count_ref_data(indeces));
        if (abs(curr_syll_count-syll_target(i))) < (abs(best_syll_count_so_far-syll_target(i)))
            % current sentence is better in this case
            best_syll_count_so_far = curr_syll_count
            sentence = temp_sentence;
            strjoin(sentence,' ')
        end
        % end of loop logic: checks to see if it matches closer than existing sentence
    end
    % end of loop requires some logic
    
    %sentence(ismember(sentence,...              % remove <s> and </s>
    %    {'<s>', '</s>'})) = [];              %% removal
    if length(sentence) >= min_length           % if longer than min
        outtext{i} = strjoin(sentence, ' ');    % join words into a string
        i = i + 1;                              % increment iterator
    end
end

end

