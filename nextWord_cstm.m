% determines the next word using a given model, and returns the word and
% its index
function [nextw, index] = nextWord_cstm(prev, mdl, mode)
    % handling short call
    if nargin == 2
        if isa(mdl, 'trigramClass')
            mode = 'tri';
        else
            mode = 'bi';
        end
    end
    
    if strcmp(mode, 'bi') % if bigramClass
        row = strcmp(mdl.unigrams, prev); % index of previous word
    else % trigramClass
        row = strcmp(mdl.bigrams, prev); % index of previous two words
    end
    % model selection: sometimes the bigMdl of a trigramClass is used
    if isa(mdl, 'trigramClass') && strcmp(mode, 'bi')
        model = mdl.bigMdl;
    else
        model = mdl.mdl;
    end
    % finds candidate words
    isCandidate = model(row,:) > 0; % boolean array
    prob = model(row, isCandidate); % prob array for possible next words
    candidates = mdl.unigrams(isCandidate); % candidate words
    % now indices
    temp = num2cell(1:length(model));
    cand_index = temp(isCandidate);

    samples = round(prob * 10000);    % create 10000 samples
                                      % based on probabilities
                                      % round it to an integer           
    csum = [0 cumsum(samples)];       % cumulative sum of samples
    try
        pick = randsample(csum(end), 1);  % randomly pick a sample
        idx = find(csum >= pick, 1);      % find where it falls in csum
        nextw = candidates{idx - 1};      % get the corresponding word
        index = cand_index{idx-1};        % get the corresponding index
    catch
        nextw = newline;
        index = 1;
    end
end

