clear;
clc;
n = 40;
%  读入随机数，省的每次生成的不同。固定随机数
fid = fopen('eclipse_data','rt');
D =  fscanf(fid, '%f %f',[n,2]);
fclose(fid);
hold on
 plot(D(:,1),D(:,2),'r*');
DN = zeros(n,2);
%  计算平均距离和S，进行Normalization过程
x_mean = 0;
y_mean = 0;
dist_mean = 0;
for i = 1:1:n
    x_mean = x_mean + D(i,1);
    y_mean = y_mean + D(i,2);
    dist_mean = dist_mean + D(i,1)^2+D(i,2)^2;
end
x_mean = x_mean /n;
y_mean = y_mean/n;
dist_mean =sqrt( dist_mean/(2*n));
for i = 1:1:n
    D(i,1)=(D(i,1) - x_mean)/dist_mean;
    D(i,2) =(D(i,2) - y_mean)/dist_mean;
end
hold on
plot(D(:,1),D(:,2),'r*');
 W = zeros(n,6);
for i = 1:1:n
    xi = D(i,1);
    yi = D(i,2);
    w= [xi^2,yi^2,xi*yi,xi,yi,1];
   W(i,:) =w;
end
[u,s ,v] = svd(W);
v6 = v(:,6);
a = v6(1);b=v6(2);c=v6(3);d=v6(4);e=v6(5);f=v6(6);
hold on
 str = sprintf('%.8f*x^2 %.8f*y^2+ %.8f*x*y +%.8f*x+ %.8f*y+ %.8f = 0',a,b,c,d,e,f);
 col = ezplot(str,[-2,2]);
%  % col = ezplot('-0.4566*x^2-0.4560*y^2+0.5483*x*y+0.0462*x+0.1428*y+0.5104 =0',[-2,2]);
 set(col ,'Color','k')

% SVD初始化完成。接下来需要进行sampson error 和 Newton 迭代的过程。
p = v6;
H = zeros(6,6);
iterate = 1000;
Obj = 0;
for it = 1:1:iterate
    Obj1 = Obj;
    for i = 1:1:n
        wi = W(i,:);
        Ai = p'*wi'*wi*p;
    j = [D(i,1)*2, D(i,2), 0, 1, 0, 0;
          0, D(i,1), 2*v6(3), 0, 1, 0];
     Ji = j*p;
     Bi = j'*j;
     De = sqrt(p'*Bi*p);
     bi = wi'/De - wi*p*Bi*p/(De^3);
     H = H + 2*bi*bi';
     b = b + wi*p*bi/De;
     Obj = Obj + (wi*p)^2/De;
    end

    for i = 1:1:6
        for k = 1:1:6
            if(H(i,k) < 0)
                H(i,k) = 0;
            end
        end
    end
    HI = inv(H);
    p = p - HI*b
    if (abs(Obj-Obj1) < 0.0001) % 两次迭代目标值改变量
        break;
    end

end

a = p(1);b=p(2);c=p(3);d=p(4);e=p(5);f=p(6);

hold on
str = sprintf('%.8f*x^2+%.8f*y^2+ %.8f*x*y +%.8f*x+ %.8f*y+ %.8f = 0',a,b,c,d,e,f);
  col = ezplot(str,[-2,2]);
%  % col = ezplot('-0.4566*x^2-0.4560*y^2+0.5483*x*y+0.0462*x+0.1428*y+0.5104 =0',[-2,2]);
 set(col ,'Color','b')
 
s = dist_mean;
c1=x_mean;
c2=y_mean;
a = p(1);b=p(2);c=p(3);d=p(4);e=p(5);f=p(6);
% ppt上系数次序与之前的略有不同就是，xy和有y^2谁排第二。ppt上 DE-normalization 是x^2+xy+y^2+x+y+f
% 这次编程使用的顺序是 xi^2,yi^2,xi*yi,xi,yi,1
a0 = a/s^2;
b0 = b/s^2;
c0 =c/s^2;
d0 = d/s-(2*a*c1)/s^2 - (c*c2)/s^2;
e0 = e/s -(2*b*c2)/s^2 - (c*c1)/s^2;
f0 = f + (a*c1^2)/s^2 + (c*c1*c2)/s^2+(b*c2^2)/s^2-(d*c1)/s-(e*c2)/s;
str0 = sprintf('%.8f*x^2+%.8f*y^2+ %.8f*x*y +%.8f*x+ %.8f*y+ %.8f = 0',a0,b0,c0,d0,e0,f0);
 col = ezplot(str0,[-20,20]);
 set(col ,'Color','r')

