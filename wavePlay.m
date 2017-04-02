%% 播放指定频率的双声道声波
function wavePlay(waveFreAv,waveFreOffset,time)
waveFreSample=44100; %采样频率
waveFreLeft=waveFreAv-waveFreOffset;%输出声波频率
waveFreRight=waveFreAv+waveFreOffset;%输出声波频率

waveTimePoint=0: 1/waveFreSample: time;
waveAmpPoint=sin(2*pi*waveFreLeft*waveTimePoint);
% waveAmpPoint(2,:)=sin(2*pi*waveFreRight*waveTimePoint);
sound(waveAmpPoint, waveFreSample);
% player = audioplayer(waveAmpPoint,waveFreSample);
% play(player);
end