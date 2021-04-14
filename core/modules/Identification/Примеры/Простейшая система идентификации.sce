figure;
newaxes;
plot2d(sin(__time__));

sca(__graphics__);

subplot(211);
plot2d(__source__.time, __source__.values);

subplot(212);
plot2d(__obj__.time, __obj__.values);

figure;
newaxes;
plot2d();

messagebox("Идентификация закончена!");
