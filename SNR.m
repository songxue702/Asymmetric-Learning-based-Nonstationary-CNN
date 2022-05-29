function snr=SNR(I,In)
% ��������Ⱥ���
% I :original signal
% In:noisy signal
%����I�Ǵ��źţ�In�Ǻ����ź�
Ps=sum(sum((I-mean(mean(I))).^2));%signal power
Pn=sum(sum((I-In).^2));           %noise power
snr=10*log10(Ps/Pn);
