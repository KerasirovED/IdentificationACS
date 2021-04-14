__out__ = [];

k = 3;

for i = 1 : length(__time__)
    __out__ = [__out__; __source__.values(i) * k]
end
