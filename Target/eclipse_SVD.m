clear;
n = 40;
%  读入随机数，省的每次生成的不同。固定随机数
fid = fopen('eclipse_data','rt');
D =  fscanf(fid, '%f %f',[n,2]);
fclose(fid);
figure
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
hold on
col = ezplot('0.025*x^2+0.0249*y^2-0.0299*x*y-0.0006*x-0.0012*y-0.9989 =0',[-10,10]);
set(col ,'Color','b')