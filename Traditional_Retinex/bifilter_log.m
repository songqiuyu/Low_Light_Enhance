function J = bifilter_log(I, simga)
    i = log(I + 1);
    l = log(bifilter(i, 15, 100, 0.1)+1);
    r = i - l;    
    R = exp(r);
    min_R = min(R(:));
    max_R = max(R(:));
    R = (R - min_R) / (max_R - min_R);
    J = adapthisteq(R);
end