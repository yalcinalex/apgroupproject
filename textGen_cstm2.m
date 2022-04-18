% This editted function matches syllable counts to a list.
% Checks against the syllable count with up to syll_att generated
function outtext = textGen_cstm2(mdl, first, min_length, nlines, syll_target, syll_att, syll_count_ref_data)
    if nargin == 3 % initialize default for short calls
        nlines = 5;
        syll_target = ones(nlines,1)*min_length;
        syll_att = 10;
        load('syllable_counts.mat', 'syll_counts');
        syll_count_ref_data = syll_counts;
    elseif nargin == 2
        min_length = 5;
        nlines = 5;
        syll_target = ones(nlines,1)*min_length;
        syll_att = 10;
        load('syllable_counts.mat', 'syll_counts');
        syll_count_ref_data = syll_counts;
    elseif nargin == 1
        first = newline;
        min_length = 5;
        nlines = 5;
        syll_target = ones(nlines,1)*min_length;
        syll_att = 10;
        load('syllable_counts.mat', 'syll_counts');
        syll_count_ref_data = syll_counts;
    end
    
    outtext = cell(nlines, 1); % initialise return value
    N = 50; % max number of words in a line
    i = 1; % initialise iterator
    while sum(cellfun(@isempty, outtext)) ~= 0 % fill outtext
        sentence = cell(1,N);
        best_syll_count_so_far = 0;
        % runs a number of attempts to find the closest sentence
        for k = 1:syll_att
            temp_sentence = cell(1, N);
            temp_sentence{1} = first; % begin the sentence
            indeces = ones(1,N); % indices of words in temp_sentence, for finding syllable count at end
            
            if ~isa(mdl,'trigramClass') % if is a bigram model
                for j = 2:N
                    [next_word,indeces(j)] = nextWord_cstm(temp_sentence{j-1}, mdl); % next word
                    temp_sentence{j} = next_word;
        
                    if strcmp(next_word, newline)
                        break;
                    end
                end
            else % if a trigram model
                [temp_sentence{2},indeces(2)] = nextWord_cstm(temp_sentence{1}, mdl); % first using bigram model
                for j = 3:N
                    prev = temp_sentence(j-2:j-1); % previous bigram
                    prev = strjoin(prev, ' '); % join them as string
                    [next_word,indeces(j)] = nextWord_cstm(prev, mdl, 'tri'); % next word
                    temp_sentence{j} = next_word;
                    if strcmp(next_word, newline)
                        break;
                    end
                end
            end
    
            % removing empty cells
            temp_sentence(cellfun(@isempty, temp_sentence)) = [];
    
            % current syllable count
            curr_syll_count = sum(syll_count_ref_data(indeces));
            if (abs(curr_syll_count-syll_target(i))) < (abs(best_syll_count_so_far-syll_target(i)))
                % current sentence is better in this case
                best_syll_count_so_far = curr_syll_count;
                sentence = temp_sentence;
            end
            % checking if any more generation is necessary
            if (best_syll_count_so_far == syll_target(i))
                break;
            end
        end
        
        if length(sentence) >= min_length % if longer than min
            outtext{i} = strjoin(sentence, ' '); % join words into a string
            i = i + 1; % increment iterator
        end
    end
end