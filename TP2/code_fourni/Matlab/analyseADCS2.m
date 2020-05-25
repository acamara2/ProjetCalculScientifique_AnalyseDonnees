% tX[gp] = [v0, v1, v2, v3, dsyev];

ng = 500;
np = 100;

m = 40;

per = 1.0;

t1g = [127.91, 197.18, 89.55, 14.2, 0.42];
t1p = [1.89, 3.6, 0.94, 0.23, 0.006];

t2g = [12.80,18.28,8.85,1.57,0.39];
t2p = [3.4,6.2,1.72,0.022, 0.005];

t3g = [109.54, 180.98, 89.25, 14.19, 0.41];
t3p = [1.68, 3.65, 1.08, 0.21, 0.005];

t4g = [107.31,164.43,92.69,15.87,0.53];
t4p = [1.89,3.76,0.92,0.35,0.007];

version = ["0", "1", "2", "3", "dsyev"];

figure(1);
suptitle({'Comparaison des temps de calcul (normalisés) des 40 premières valeurs propres pour des matrices de types différents' '' ''});
subplot(221);
plot(0:4, t1p/norm(t1p), '-+', 0:4, t1g/norm(t1g), '-+');
title('imat = 1');
legend1();
subplot(222);
plot(0:4, t2p/norm(t2p), '-+', 0:4, t2g/norm(t2g), '-+');
title('imat = 2');
legend1();
subplot(223);
plot(0:4, t3p/norm(t3p), '-+', 0:4, t3g/norm(t3g), '-+');
title('imat = 3');
legend1();
subplot(224);
plot(0:4, t4p/norm(t4p), '-+', 0:4, t4g/norm(t4g), '-+');
title('imat = 4');
legend1();

figure(2);
suptitle({'Comparaison des temps de calcul (normalisés) des 40 premières valeurs propres pour des matrices de tailles différentes' '' ''});
subplot(211);
plot(0:4, t1p, '-+', 0:4, t2p, '-+', 0:4, t3p, '-+', 0:4, t4p, '-+');
title('m = 100');
legend2();
subplot(212);
plot(0:4, t1g, '-+', 0:4, t2g, '-+', 0:4, t3g, '-+', 0:4, t4g, '-+');
title('m = 500');
legend2();

