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

function y1=MyFunc2(u1)
    disp("MyFunc2")
    y1 = u1 * 2;
endfunction

function [y1, y2]=MyFunc3(u1, u2)
    disp("MyFunc3")
    y1 = u1 * u2;
    y2 = u1 / u2;    
endfunction

function y1=MyFunc4(t)
    disp("MyFunc4");
    
    y1 = t;
endfunction

function Func1()
    disp("Func1");
endfunction

function Func2()
    disp("Func2")
endfunction
