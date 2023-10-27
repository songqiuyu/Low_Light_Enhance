function J = conv_log(I, simga)
    I_blur = imgaussfilt(I, simga);
    % I_blur = imbilatfilt(I, 5, 10);
    % I_blur = filter2(fspecial('average', 19), I);
    % I_blur = bifilter(I, 7, 3, 10);

    log_R = log(I + 0.01) - log(I_blur + 0.01);
    R = exp(log_R);
    min_R = min(R(:));
    max_R = max(R(:));
    R = (R - min_R) / (max_R - min_R);
    J = adapthisteq(R);
end