function [f, y] = zfft(x, fi, fa, fs)  
% x为采集的数据  
% fi为分析的起始频率  
% fa为分析的截止频率  
% fs为采集数据的采样频率  
% f为输出的频率序列  
% y为输出的幅值序列(实数）  
  
f0 = (fi + fa) / 2;              %中心频率  
N = length(x);                 %数据长度  
  
r = 0:N-1;  
b = 2*pi*f0.*r ./ fs;                 
x1 = x .* exp(-1j .* b);          %移频  
  
bw = fa - fi;                                          
                       
B = fir1(32, bw / fs);             %滤波 截止频率为0.5bw  
x2 = filter(B, 1, x1);                 
  
c = x2(1:floor(fs/bw):N);           %重新采样  
N1 = length(c);  
f = linspace(fi, fa, N1);  
y = abs(fft(c)) ./ N1 * 2;                           
y = circshift(y, [0, floor(N1/2)]);            %将负半轴的幅值移过来  
end  