% figure;
% ezplot('x^2/9+y^2/4=1')
% axis equal
% a = 1;
% b = 1;
% c = 0;
% d = 0;
% e = 0;
% f = 0;
% % a*x^2 + b*y^2 + c*x*y + d*x + y*e + f = 0;
% w = [a,b,c,d,e,f];
%p = [x^2,y^2,x*y,x,y,1];
%e = p * w';
n = 40; %  取样点个数

A = zeros(n,2);
% T = zeros(n,1);
angle = 2 *pi;
theta = 45;
R = [cosd(theta) -sind(theta);
        sind(theta) cosd(theta)]; % 旋转矩阵
a = 10; %  长轴长
b = 5; % 短轴长

Ox = 0;
Oy = 0;
%  读入随机数，省的每次生成的不同。固定随机数
fid = fopen('randdata','rt');
T=  fscanf(fid, '%f',[n,1]);
fclose(fid);
%  读入随机数，省的每次生成的不同。固定随机数
fid = fopen('normrndxdata','rt');
X=  fscanf(fid, '%f',[n,1]);
fclose(fid);
%  读入随机数，省的每次生成的不同。固定随机数
fid = fopen('normrndydata','rt');
Y=  fscanf(fid, '%f',[n,1]);
fclose(fid);

i = 1;
for i = 1:1:n
%     0:2*pi/40:2*pi
    t = T(i) *angle;
%     x = 10*sin(t);
%     y = 5*cos(t);

    x = a*sin(t) + X(i) + Ox;% 
    y = b*cos(t) + Y(i) + Oy; % 

    A(i,:)=(R*[x;y])';
end
 plot(A(:,1),A(:,2),'r*');

hold on
ecc = axes2ecc(a,b); %  根据长半轴和短半轴计算椭圆偏心率
[elat,elon] = ellipse1(Ox,Oy,[10 ecc],theta);
  plot(elat,elon)


fid = fopen('eclipse_data','w');
fprintf(fid, '%f %f ',A(:,1),A(:,2));

fclose(fid);
