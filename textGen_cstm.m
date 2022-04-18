% generates text using the appropriate bigram or trigram model.
function outtext = textGen_cstm(mdl, first, min_length, nSamples)
    % handling short calls with arbitrary defaults
    if nargin == 3
        nSamples = 5;
    elseif nargin == 2
        min_length = 5;
        nSamples = 5;
    elseif nargin == 1
        first = newline;
        min_length = 5;
        nSamples = 5;
    end
    
    outtext = cell(nSamples, 1); % initialising output
    N = 50; % number of words
    i = 1; % initialising iterator
    while sum(cellfun(@isempty, outtext)) ~= 0 % filling all lines of outtext
        sentence = cell(1, N); % current sentence initialisation
        sentence{1} = first; % first word as given
        % if it is bigram
        if ~isa(mdl,'trigramClass')
            for j = 2:N
                % generate the next word
                [next_word,~] = nextWord_cstm(sentence{j-1}, mdl);
                sentence{j} = next_word; % add to current sentence
                if strcmp(next_word, newline) % checking for end of line
                    break;
                end
            end
        % if trigram
        else
            % bigram for first word
            sentence{2} = nextWord_cstm(sentence{1}, mdl, 'bi');
            for j = 3:N
                % trigram for remaining words
                prev = sentence(j-2:j-1); % previous bigram
                prev = strjoin(prev, ' '); % join them as string
                [next_word,~] = nextWord_cstm(prev, mdl); % next word
                sentence{j} = next_word; % add to current sentence
                if strcmp(next_word, newline) % checks for end of line
                    break;
                end
            end
        end
        
        sentence(cellfun(@isempty, sentence)) = []; % remove empty cells

        if length(sentence) >= min_length % if longer than min
            outtext{i} = strjoin(sentence, ' '); % join words into a string
            i = i + 1; % increment iterator
        end
    end
end