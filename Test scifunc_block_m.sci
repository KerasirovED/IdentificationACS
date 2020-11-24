clc
clear

global a
a = 0;

function y1=MyFunc()
    disp("MyFunc")
    global a;
    a = a + 1;
    y1 = a;
endfunction

function Func1()
    disp("Funct1");
endfunction

function Func2()
    disp("Func2")
endfunction
