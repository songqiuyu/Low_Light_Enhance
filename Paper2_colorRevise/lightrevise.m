function J = lightrevise(I, sigma, l, w1, w2, s1, s2, p, q)
    I = double(I);
    [iw, ih, ic] = size(I);
    I_gauss = imgaussfilt(I, sigma);  
    I_HSV = rgb2hsv(I);
    I_HSV_gauss = rgb2hsv(I_gauss);
 
    I_V0 = I_HSV(:, :, 3);
    I_V = I_HSV_gauss(:, :, 3);
    [r, g, b] = imsplit(I);

 

    J = zeros(iw, ih);

    for i=1:iw
        for j=1:ih
            v0 = I_V0(i, j);
            vb = I_V(i, j);
            v  = v0 + (vb - v0) * l;

            dr = 1 + ( ( ((1-s1)*v0 + s1*r(i,j)) * djudgef(v, w1) * p ) / (r(i,j)) );
            hr = 1 - ( ( (255 - v0)*hjudgef(v, w2)*q + (v0 - r(i, j))*hjudgef(v, w2)*s2 ) / (r(i,j) - (v0 - r(i,j)*dr)*hjudgef(v,w2)*s2));
            
            dg = 1 + ( ( ((1-s1)*v0 + s1*g(i,j)) * djudgef(v, w1) * p ) / (g(i,j)) );
            hg = 1 - ( ( (255 - v0)*hjudgef(v, w2)*q + (v0 - g(i, j))*hjudgef(v, w2)*s2 ) / (g(i,j) - (v0 - r(i,j)*dg)*hjudgef(v,w2)*s2));

            db = 1 + ( ( ((1-s1)*v0 + s1*b(i,j)) * djudgef(v, w1) * p ) / (b(i,j)) );
            hb = 1 - ( ( (255 - v0)*hjudgef(v, w2)*q + (v0 - b(i, j))*hjudgef(v, w2)*s2 ) / (b(i,j) - (v0 - r(i,j)*db)*hjudgef(v,w2)*s2));

            if djudgef(v, w1) > 0
                J(i, j, 1) = dr * r(i, j);
                J(i, j, 2) = dg * g(i, j);
                J(i, j, 3) = db * b(i, j);
            elseif hjudgef(v, w2) > 0
                
                J(i, j, 1) = hr * r(i, j);
                J(i, j, 2) = hg * g(i, j);
                J(i, j, 3) = hb * b(i, j);
            end

        end
    end
    J = J ./ 255;
end