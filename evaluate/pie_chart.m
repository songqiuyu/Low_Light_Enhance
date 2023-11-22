figure;

subplot(2,2,1);
t = [20,  20, 20, 40, 100];
label = {'10.00%' , '10.00%', '10.00%', '20.00%', '50.00%'};
tc = [0, 0, 0, 0, 1];
pie3(t, tc, label);
title("总体构成")
legend("多雾", "噪声", "多雨", "光照不均", "光照不足");

%手机采集
subplot(2,2,2);
t = [56, 44];
label = {'56.00%', '44.00%'};
tc = [1 0];
pie3(t, tc, label);
title("手机型号")
legend("iphone13", "HUAWEI畅享20pro");

%光照不均组成
subplot(2,2,3);
t = [16, 24];
label = {'56.00%', '44.00%'};
tc = [1 0];
pie3(t, tc, label);
title("手机型号")
legend("低光", "曝光");

%光照不足组成
subplot(2,2,4);
t = [56, 44];
label = {'56.00%', '44.00%'};
tc = [1 0];
pie3(t, tc, label);
title("手机型号")
legend("iphone13", "HUAWEI");