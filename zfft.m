function [f, y] = zfft(x, fi, fa, fs)  
% xΪ�ɼ�������  
% fiΪ��������ʼƵ��  
% faΪ�����Ľ�ֹƵ��  
% fsΪ�ɼ����ݵĲ���Ƶ��  
% fΪ�����Ƶ������  
% yΪ����ķ�ֵ����(ʵ����  
  
f0 = (fi + fa) / 2;              %����Ƶ��  
N = length(x);                 %���ݳ���  
  
r = 0:N-1;  
b = 2*pi*f0.*r ./ fs;                 
x1 = x .* exp(-1j .* b);          %��Ƶ  
  
bw = fa - fi;                                          
                       
B = fir1(32, bw / fs);             %�˲� ��ֹƵ��Ϊ0.5bw  
x2 = filter(B, 1, x1);                 
  
c = x2(1:floor(fs/bw):N);           %���²���  
N1 = length(c);  
f = linspace(fi, fa, N1);  
y = abs(fft(c)) ./ N1 * 2;                           
y = circshift(y, [0, floor(N1/2)]);            %��������ķ�ֵ�ƹ���  
end  