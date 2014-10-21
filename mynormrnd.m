n = 40;

 X = normrnd(0,0.1,[n,1]);
 
fid = fopen('normrndxdata','w');
for i = 1:1:n
    fprintf(fid, '%f ',X(i));
end
fclose(fid);

Y = normrnd(0,0.1,[n,1]);
 
fid = fopen('normrndydata','w');
for i = 1:1:n
    fprintf(fid, '%f ',Y(i));
end
fclose(fid);
