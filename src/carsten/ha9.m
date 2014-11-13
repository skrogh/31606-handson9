%%1.2 Shorter and shorter
%5kHz is 1/3 in normalised frequency, meaning nyquist frequency is 15kHz
%and sampling frequency is 30kHz
%h[t] length = 601 samples, so FIR filter has order=600
fs = 30e3; %sampling frequency
N = 601; %number of samples
T = N/fs; %impulse response length in time
bs = 1/T; %frequency bin size 

%generate frequency vector
f = [0:bs:fs/2,-fs/2:bs:0-bs];
Y = zeros(1,length(f)); %value of frequency bins
index = find(abs(f)<5e3);
Y(index)=1; %Y is now a perfect lowpass filter with cutoff=5e3Hz

%impulse response
h=ifftshift(ifft(Y,'symmetric')); %ifft input was positive frequencies only, so shift to restore order
t = [0:1/fs:T-1/fs]; %time delayed by (N0-1)/2 taps
figure(1)
plot(t,h)

%impulse response contains B(z) in B(z)/A(z) 
figure(2)
freqz(h,1)

%we will use a hamming window
hw = cell(1,6);
hw{1} = h;
%find effective length impulse response
heff = h(find(h>max(h)/100)); %1% effective
hamwindow = hamming(length(heff))'; %hamming window
heffw = heff.*hamwindow;
hw{2} = heffw;

%cut 10 samples from either end
h = heff(11:1:length(heff)-10);
hw{3} = h.*hamming(length(h))';

%again
h = heff(21:1:length(heff)-20);
hw{4} = h.*hamming(length(h))';

%5 more
h = heff(26:1:length(heff)-25);
hw{5} = h.*hamming(length(h))';

%3 more
h = heff(29:1:length(heff)-28);
hw{6} = h.*hamming(length(h))';

figure(3)
clf(3)
colors = {[1.0,0,0],[0.8,0,0.2],[0.6,0,0.4],[0.4,0,0.6],[0.2,0,0.8],[0,0,1]};
for i = 1:6
    hold on
    [H, T] = freqz(hw{i},1);
    subplot(2,1,1);
    hold on
    plot(T/pi,20*log10(abs(H)),'Color',colors{i});
    subplot(2,1,2);
    plot(T/pi,unwrap(angle(H))*180/pi,'Color',colors{i});
end
subplot(2,1,1);
legend('601','59','39','19','9','3','location','southwest','Orientation','horizontal')
hold off

%cosmetics
subplot(2,1,1)
ylabel('Magnitude [dB]');
xlabel('Normalised frequency [pi rad/sample]');
subplot(2,1,2);
ylabel('Phase [degrees]');
xlabel('Normalised frequency [pi rad/sample]');
