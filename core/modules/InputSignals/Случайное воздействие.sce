__out__ = [];

for i = 0: size(__time__)
    __out__ = [__out__; rand()];
end

disp(__out__);
disp(size(__time__));
