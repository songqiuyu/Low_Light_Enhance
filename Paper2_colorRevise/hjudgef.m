function h = hjudgef(v, w2)
    h = 50 / (255 - v + 10) - 0.3 * (100 + 2 * (100 - w2)) / 100;
end