% generates text using multiple ngram sources
function outtext = textGen_cstm3(mdl1, mdl2, p, first, min_length, n_lines)
    outtext = cell(n_lines, 1);
    for i = 1:n_lines
        if (rand(1,1) < p)
            outtext(i) = textGen_cstm(mdl1, first, min_length, 1);
            %disp(1);
        else
            outtext(i) = textGen_cstm(mdl2, first, min_length, 1);
            %disp(0);
        end
    end
end