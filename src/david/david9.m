%% 2 From bass/treble to an equalizer

%% 2.1 Five knobs to turn

n = 5000;
G1 = db2mag(0);
G2 = db2mag(-5);
G3 = db2mag(-10);
G4 = db2mag(-15);
G5 = db2mag(-20);

h = equalizer5band(G1, G2, G3, G4, G5, n, 0);

[H, f] = freqz(h, 1, 2^16);
f=f/pi;

figure
subplot(2,1,1)
plot(f, mag2db(abs(H)));
xlim([0 1])
ylim([-25 5])
title('Five-Band Equalizer \\ Magnitude response')
xlabel('Normalized frequency [-]')
ylabel('Magnitude [dB]')
subplot(2,1,2)
plot(f, (180/pi)*unwrap(angle(H)));
xlim([0 1])
ylim([-4.5*10^5 0])
title('Five-Band Equalizer \\ Phase response')
xlabel('Normalized frequency [-]')
ylabel('Phase [degrees]')

%%

G1 = db2mag(0);
G2 = db2mag(-5);
G3 = db2mag(-10);
G4 = db2mag(-15);
G5 = db2mag(-20);

h_h150 = equalizer5band(G1, G2, G3, G4, G5, 150, 1);
h_h300 = equalizer5band(G1, G2, G3, G4, G5, 300, 1);
h_h600 = equalizer5band(G1, G2, G3, G4, G5, 600, 1);
h_h1200 = equalizer5band(G1, G2, G3, G4, G5, 1200, 1);
h_h2400 = equalizer5band(G1, G2, G3, G4, G5, 2400, 1);
h_h4800 = equalizer5band(G1, G2, G3, G4, G5, 4800, 1);

[H_h150, f_h150] = freqz(h_h150, 1, 2^16);
f_h150=f_h150/pi;
[H_h300, f_h300] = freqz(h_h300, 1, 2^16);
f_h300=f_h300/pi;
[H_h600, f_h600] = freqz(h_h600, 1, 2^16);
f_h600=f_h600/pi;
[H_h1200, f_h1200] = freqz(h_h1200, 1, 2^16);
f_h1200=f_h1200/pi;
[H_h2400, f_h2400] = freqz(h_h2400, 1, 2^16);
f_h2400=f_h2400/pi;
[H_h4800, f_h4800] = freqz(h_h4800, 1, 2^16);
f_h4800=f_h4800/pi;

figure
subplot(2,1,1)
plot(f_h150, mag2db(abs(H_h150)), 'Color', [0.00 0 1.00]);
hold on
plot(f_h300, mag2db(abs(H_h300)), 'Color', [0.20 0 0.80]);
hold on
plot(f_h600, mag2db(abs(H_h600)), 'Color', [0.40 0 0.60]);
hold on
plot(f_h1200, mag2db(abs(H_h1200)), 'Color', [0.60 0 0.40]);
hold on
plot(f_h2400, mag2db(abs(H_h2400)), 'Color', [0.80 0 0.20]);
hold on
plot(f_h4800, mag2db(abs(H_h4800)), 'Color', [1.00 0 0.00]);
hold on
xlim([0.175 0.225])
ylim([-6.5 1])
title('Five-Band Equalizer \\ Magnitude response')
xlabel('Normalized frequency [-]')
ylabel('Magnitude [dB]')
p = legend('n = 150','n = 300','n = 600','n = 1200','n = 2400','n = 4800', 3);
set(p,'FontSize', 8);
subplot(2,1,2)
plot(f_h150, (180/pi)*unwrap(angle(H_h150)), 'Color', [0.00 0 1.00]);
hold on
plot(f_h300, (180/pi)*unwrap(angle(H_h300)), 'Color', [0.20 0 0.80]);
hold on
plot(f_h600, (180/pi)*unwrap(angle(H_h600)), 'Color', [0.40 0 0.60]);
hold on
plot(f_h1200, (180/pi)*unwrap(angle(H_h1200)), 'Color', [0.60 0 0.40]);
hold on
plot(f_h2400, (180/pi)*unwrap(angle(H_h2400)), 'Color', [0.80 0 0.20]);
hold on
plot(f_h4800, (180/pi)*unwrap(angle(H_h4800)), 'Color', [1.00 0 0.00]);
hold on
xlim([0 1])
ylim([-4.5*10^5 0])
title('Five-Band Equalizer \\ Phase response')
xlabel('Normalized frequency [-]')
ylabel('Phase [degrees]')
p = legend('n = 150','n = 300','n = 600','n = 1200','n = 2400','n = 4800', 3);
set(p,'FontSize', 8);

%%

L = length(h);

h_2  = [h, zeros(1, L)]; n_2 = 2*n;
h_10 = [h, zeros(1, 9*L)]; n_10 = 10*n;

f_2 = -1:2/n_2:1-2/n_2;
H_2 = fftshift(fft(h_2));

f_10 = -1:2/n_10:1-2/n_10;
H_10 = fftshift(fft(h_10));

figure
subplot(2,1,1)
plot(f_2, mag2db(abs(H_2)));
xlim([0.195 0.205])
ylim([-10 5])
title('Five-Band Equalizer \\ Magnitude response')
xlabel('Normalized frequency [-]')
ylabel('Magnitude [dB]')
subplot(2,1,2)
plot(f_2, (180/pi)*unwrap(angle(H_2)));
xlim([0 1])
ylim([-9*10^5 -4.5*10^5])
title('Five-Band Equalizer \\ Phase response')
xlabel('Normalized frequency [-]')
ylabel('Amplitude [-]')

figure
subplot(2,1,1)
plot(f_10, mag2db(abs(H_10)));
xlim([0.195 0.205])
ylim([-10 5])
title('Five-Band Equalizer \\ Magnitude response')
xlabel('Normalized frequency [-]')
ylabel('Magnitude [dB]')
subplot(2,1,2)
plot(f_10, (180/pi)*unwrap(angle(H_10)));
xlim([0 1])
ylim([-9*10^5 -4.5*10^5])
title('Five-Band Equalizer \\ Phase response')
xlabel('Normalized frequency [-]')
ylabel('Amplitude [-]')

%%

figure
subplot(2,1,1)
plot(f_2, mag2db(abs(H_2)));
xlim([0.195 0.205])
ylim([-10 5])
title('Five-Band Equalizer x2 length zero padding \\ Magnitude response')
xlabel('Normalized frequency [-]')
ylabel('Magnitude [dB]')
subplot(2,1,2)
plot(f_10, mag2db(abs(H_10)));
xlim([0.195 0.205])
ylim([-10 5])
title('Five-Band Equalizer x10 length zero padding \\ Magnitude response')
xlabel('Normalized frequency [-]')
ylabel('Magnitude [dB]')

%%

%parameter setup
T = 5;
fs = 10000;
t = 0:1/fs:T-1/fs;
f = -fs/2:1/T:fs/2-1/T;

%generate noise
r = randn(fs*T, 1); 
x = r/0.99*max(r);

%filter and transform
y = filter(h, 1, x);
X = fftshift(fft(x))/length(x);
Y = fftshift(fft(y))/length(y);

%plot noise vs. filtered noise
figure
plot(f, mag2db(abs(X)), 'b')
hold on
plot(f, mag2db(abs(Y)), 'r')
hold on
xlim([0 fs/2])
ylim([-80 -25])
title('Noise vs. filtered noise')
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]')
p = legend('Noise','Filtered noise', 4);
set(p,'FontSize', 8);

%sound(x, fs)
%sound(y, fs)

%%

%data setup
[s, fs] = audioread(['C:\Users\Aztar\Documents\MATLAB' filesep 'piano.wav']);
T = length(s)/fs;
t = 0:1/fs:T-1/fs;
f = -fs/2:fs/(length(s)-1):fs/2;

%filter and transform
z = filter(h, 1, s);
S = fftshift(fft(s))/length(s);
Z = fftshift(fft(z))/length(z);

figure
plot(f, mag2db(abs(S)), 'b');
hold on
plot(f, mag2db(abs(Z)), 'r');
hold on
xlim([0 fs/2])
title('piano.wav vs. filtered piano.wav')
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]')
p = legend('piano.wav','Filtered piano.wav', 4);
set(p,'FontSize', 8);


