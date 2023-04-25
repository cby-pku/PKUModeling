%%
clc,clear,close all;
%样本提取
T=readtable("data_corrected_1.csv");
%钻深
bit_depth=table2array(T(:,2));
%钻压
WOB=table2array(T(:,3));
%井眼深度
hole_depth=table2array(T(:,4));
%流速
f=table2array(T(:,5));
%立管压力
psi=table2array(T(:,6));
%扭矩
torque=table2array(T(:,7));
%转速
w=table2array(T(:,8));
intex=find(f==0&abs(bit_depth-hole_depth)>50);
intex=unique(intex)
x=bit_depth(intex,1);
y=psi(intex,1);
b=regress(y,[ones(length(x),1) x]);
plot(x,y,'o');
hold on;
plot(x,[ones(length(x),1) x]*b,'-');
xlabel("bit_depth");
ylabel("psi");
saveas(gcf,"bit_depth-psi-data1.png");
%%
T=readtable("data_corrected_4.csv")
%钻深
bit_depth=table2array(T(:,2));
%钻压
WOB=table2array(T(:,3));
%井眼深度
hole_depth=table2array(T(:,4));
%流速
f=table2array(T(:,5));
%立管压力
psi=table2array(T(:,6));
%扭矩
torque=table2array(T(:,7));
%转速
w=table2array(T(:,8));

add=f.*f.*bit_depth;
add2=f.*f;
value={'钻头深度','钻压','井眼深度','流速','立管压力','转速','扭矩','流方井深','井深'}
T0=table(bit_depth,WOB,hole_depth,f,psi,torque,w,add,add2,VariableNames=value);
a=hole_depth-bit_depth;
index1=find(a>50);
index2=find(a<=50);
T1=T0(index1,:);
writetable(T1,"data4_not_in.csv");
T2=T0(index2,:);
writetable(T2,"data4_in_.csv");