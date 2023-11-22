function s = adapts(s0, v0, v, t, n)
    [ih, iw] = size(v0);
    s = zeros(ih, iw);
    w = (n-1)/2;
    for i=1:ih
        for j=1:iw
            %{
            改进
            if s0(i, j) == 0
                s(i, j) = 0;
                continue;
            end
            %}
            iMin = max(i-w, 1);
            iMax = min(i+w, ih);
            jMin = max(j-w, 1);
            jMax = min(j+w, iw);
            
            v_W = v0(iMin:iMax, jMin:jMax);
            v_bar = mean(v_W(:));
            s_W = s0(iMin:iMax, jMin:jMax);
            s_bar = mean(s_W(:));

            v_res = v_W - v_bar;
            s_res = s_W - s_bar;
            
            v_s = v_res .* s_res;
            v_s = abs(v_s);

            v_sigma = (v_W - v_bar).^2;
            v_sigma = sum(v_sigma(:));

            s_sigma = (s_W - s_bar).^2;
            s_sigma = sum(s_sigma(:));

            v_s_sigma = sqrt(v_sigma * s_sigma);
            lamda = sum(v_s(:)) / v_s_sigma;
            %--
            t = s0(i, j) + t * (v(i, j) - v0(i, j)) * lamda;
            if(isnan(s(i, j)))
                s(i, j) = s0(i, j);
            else
                s(i, j) = t;
            end
        end
    end

end