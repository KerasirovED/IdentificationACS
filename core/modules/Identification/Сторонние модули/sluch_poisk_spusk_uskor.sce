
function [ym,dy,sss]=func1(km1,tm1)
  dm1=km1/(1+tm1*s);
  ym=csim(timefun,t,dm1);
  dy=yo-ym;
  ii=1;
  sss=0;
  for tt=t;
      sss=sss+dy(ii)^2;
      ii=ii+1;
  end
  sss=sss*dt;
endfunction

// Задание передаточных функций объекта и модели
s=poly(0,'s');

//Параметры объекта и модели
km=1;
tm=1;

// Задание шага дискретизации по времени dt
// и времени окончания моделирования tk
dt= __modulationStep__;
tk = __modulationTime__;

// Задание массива времени t
t= __time__;

// Определение входного воздействия
deff('u=timefun(t)','u=1');

// Вычисление реакций объекта
yo= __obj__.values';

//Вычисление реакции модели и разности реакции объекта и модели
[ym,dy,ss0]=func1(km,tm);

// Построение реакций объекта и модели
// в одних координатах
da=__graphics__;
da.x_label.text="t";
da.y_label.text="yo";
subplot(221);
xtitle('Реакция объекта');
xset("line style",2);xset("thickness",1);plot2d(t,yo(1,:),style=5);
xgrid(1, 1, 7);
da.y_label.text="ym";
subplot(222);
xtitle('Реакция модели');
xset("line style",2);plot2d(t,ym(1,:),style=5);
xgrid(1, 1, 7);
da.y_label.text="dy";
subplot(223);
xtitle('Разность реакций объекта и модели');
xset("line style",2);plot2d(t,dy(1,:),style=5);
xgrid(1, 1, 7);
//
// Число параметров
np=2;
dp1=0.1;
eps1=0.0001;
// Число случайных проб
N=7;
x(1)=km;
x(2)=tm;
y(1)=km;
y(2)=tm;
ssm=ss0;
ss1=ssm;
j=0;
rand("uniform");
while dp1>eps1
jjm=0;
//Генерация N случайных векторов размером np  
//z=rand(np,N)-0.5;
 for i=1:np
      for jj=1:N            
           z(i,jj)=rand()-0.5;
       end
 end
//Нормирование N случайных векторов к единичной длинне 
   for jj=1:N
      sn=0.0;
      for i=1:np
        sn=sn+z(i,jj)^2;
      end    
      for i=1:np
        zn(i,jj)=z(i,jj)/sqrt(sn); 
      end
   end
//Начало алгоритма случайного поиска    
//Шаг в каждом из N случайных направлении по каждой из np координат     
     for jj=1:N
       for i=1:np   
         y(i)=x(i)+dp1*zn(i,jj)*x(i);
       end
//Вычисление значения целевой функции
       [ym,dy,ss1]=func1(y(1),y(2));
       j=j+1;
//Запись точки траектории поиска в массив zt
       zt(1,j)=y(1);
       zt(2,j)=y(2);
//Выбор лучшего из N напрввлений
         if ss1<ssm
           ssm=ss1;
           jjm=jj;
           for i=1:np
               yjj(i)=y(i);
           end 
         end 
     end   
//Спуск по удачной пробе с номером jjm      
     if jjm>0
       ss1=ssm;
       for i=1:np
           y(i)=yjj(i);
       end 
       while ss1<=ssm           
          ssm=ss1;
          for i=1:np
               x(i)=y(i);
          end 
          for i=1:np  
             y(i)=x(i)+dp1*zn(i,jjm)*x(i);           
          end
          [ym,dy,ss1]=func1(y(1),y(2));
          j=j+1;
          zt(1,j)=y(1);
          zt(2,j)=y(2);
       end          
     end 
 dp1=dp1/1.5;         
end
da.x_label.text="K";
da.y_label.text="T";

subplot(224);
xtitle('Траектория поиска');
xset("line style",2);plot2d(zt(1,:),zt(2,:),-4);
xgrid(5, 1, 7);
da.y_label.text="dy";

clc;

write(%io(2),'Величина начальной квадратичной ошибки');
write(%io(2),ss0,'(''J='',f7.4)');
write(%io(2),'Величина конечной квадратичной ошибки');
write(%io(2),ssm,'(''J='',f7.4)');
write(%io(2),'Количество вычислений функции');
write(%io(2),j,'(''N='',I7)');
write(%io(2),y(1),'(''k='',f7.4)');
write(%io(2),y(2),'(''T='',f7.4)');
ttt="Количество вычислений функции="+string(j)+";"+" K="+string(y(1))+";"+" T="+string(y(2));
messagebox(ttt, "Результаты расчетов");
da.x_label.text="";
da.y_label.text="";


//clear zt z zn ym yo dy t;




clear s km tm dt tk yo ym dy ss0 da ttt zt zn sn z jj jjm j ss1 ssm y x N eps1 dp1 np t T1 T2 i k T 
