% takes in DTMC matrix and no of lines to generate, outputs target syllable
% lengths of each line
% start is starting syllable count
function line_lengths = syll_per_line_markov(model, n_lines, start)
    if nargin == 2
        load('syll_counts_dist.mat');
        dist2 = cumsum(syll_counts_dist);
        unif_rand = rand(1,1);
        start = sum(dist2 < unif_rand) + 1;
    end

    line_lengths = zeros(n_lines, 1);
    line_lengths(1) = start;
    for i = 2:n_lines
        line_lengths(i) = sum(cumsum(model(line_lengths(i-1),:)) < rand(1,1)) + 1;
    end
end