%% ����ָ��Ƶ�ʵ�˫��������
function wavePlay(waveFreAv,waveFreOffset,time)
waveFreSample=44100; %����Ƶ��
waveFreLeft=waveFreAv-waveFreOffset;%�������Ƶ��
waveFreRight=waveFreAv+waveFreOffset;%�������Ƶ��

waveTimePoint=0: 1/waveFreSample: time;
waveAmpPoint=sin(2*pi*waveFreLeft*waveTimePoint);
% waveAmpPoint(2,:)=sin(2*pi*waveFreRight*waveTimePoint);
sound(waveAmpPoint, waveFreSample);
% player = audioplayer(waveAmpPoint,waveFreSample);
% play(player);
end