n = 40;

% �������������
ctime = datestr(now, 30);
tseed = str2double(ctime((length(ctime) - 5) : end)) ;
rng(tseed);
T = rand(n,1);

fid = fopen('randdata','w');
for i = 1:1:n
    fprintf(fid, '%f ',T(i));
end
fclose(fid);