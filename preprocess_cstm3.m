function good = preprocess_cstm3(raw)
    i=1; j=1;
    n = length(raw);
    temp = blanks(n);
    while (i <= n)
        if is_bad_punc(raw(i))
            if (raw(i) == 39)
                if (is_letter(raw(i-1)) && is_letter(raw(i+1)))
                    temp(j) = raw(i);
                    j=j+1; i=i+1;
                else
                    i=i+1;
                end
            else
                i=i+1;
            end
        else
            temp(j) = raw(i);
            j=j+1; i=i+1;
        end
    end
    good = temp(1:j-1);
end