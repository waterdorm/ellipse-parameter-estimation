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
I = ones(n,1);
W1=W(:,1:5);
Wi = inv(W1'*W1);
x = Wi*(W1')*I;
hold on
col = ezplot('0.025*x^2+0.0249*y^2-0.03*x*y+0.00067*x+0.0012*y-1 =0',[-10,10]);
set(col ,'Color','g')