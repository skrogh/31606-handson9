clear all
close all

% set colormap
col = summer( 5 )';
col = col*0.95;
%% 1 How finite should it be

%% 1.1 butter
%actually we use an elliptic filter since ripple in both stop and passband
%is accepted

uncut = ellipt(); % genereate filter object from matlab toolbox
uncut_ir = impz( uncut );


%do some plots:
zplane( uncut );
set(gca,'Fontsize',10)
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 15])
saveas(gcf,'./pics/1-1-uncut-zplane.eps','psc2')

% frequency response
[h,w] =  freqz( uncut );
plot( w/pi, mag2db(abs(h)) )
hold on
% plot bounds
plot( [0,0.1,0.1], [-100,-100,10], 'r' )
plot( [0.2,0.2,0.3,0.3], [-130,-2,-2,-130], 'r' )
plot( [0.2,0.2,0.3,0.3], [10,0,0,10], 'r' )
plot( [0.4,0.4,1], [10,-100,-100], 'r' )
legend('Original IIR response',...
    'Specification boudaries');
xlabel( 'Frequency [pi rad/sample]' )
ylabel( 'Magnitude [dB]' )
title( 'Frequency response of IIR filter' )
axis( [0,1,-130,10] )
set(gca,'Fontsize',10)
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 10])
saveas(gcf,'./pics/1-1-uncut-fresponse.eps','psc2')


%impulse response
m = impz( uncut );
figure; plot( m(1:end/3 ) )

xlabel( 'Sample []' )
ylabel( 'Value []' )
title( 'Impulse response' )
set(gca,'Fontsize',10)
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 5])
saveas(gcf,'./pics/1-1-uncut-impresponse.eps','psc2')
axis tight



%% Lets start cutting:

%get maximum value:
maxval = max( abs( uncut_ir ) );

%significance %
sig = 0.1;

%make list of max of remaining response:
maxrest = uncut_ir;
for i = 1:length(maxrest)
    maxrest(i) = max( abs( uncut_ir(i:end) ) );
    if maxrest(i) < maxval*sig
        break; %stop here, i is now the index, where all samples [i:inf[ < max
    end
end

%cut
cut_ir = uncut_ir(1:i);

%extra cuts:
cut_ir_75 = uncut_ir( 1:(i*0.75) );
cut_ir_60 = uncut_ir( 1:(i*0.60) );
cut_ir_40 = uncut_ir( 1:(i*0.40) );
cut_ir_10 = uncut_ir( 1:(i*0.10) );

%equalize length for easy plotting
n = 2048;
cut_ir = [ cut_ir; zeros( n - length( cut_ir ), 1 ) ];
cut_ir_75 = [ cut_ir_75; zeros( n - length( cut_ir_75 ), 1 ) ];
cut_ir_60 = [ cut_ir_60; zeros( n - length( cut_ir_60 ), 1 ) ];
cut_ir_40 = [ cut_ir_40; zeros( n - length( cut_ir_40 ), 1 ) ];
cut_ir_10 = [ cut_ir_10; zeros( n - length( cut_ir_10 ), 1 ) ];

% make plots
cut_ir_h = mag2db( abs( fft( cut_ir ) ) );
cut_ir_h = cut_ir_h(1:end/2);
cut_ir_75_h = mag2db( abs( fft( cut_ir_75 ) ) );
cut_ir_75_h = cut_ir_75_h(1:end/2);
cut_ir_60_h = mag2db( abs( fft( cut_ir_60 ) ) );
cut_ir_60_h = cut_ir_60_h(1:end/2);
cut_ir_40_h = mag2db( abs( fft( cut_ir_40 ) ) );
cut_ir_40_h = cut_ir_40_h(1:end/2);
cut_ir_10_h = mag2db( abs( fft( cut_ir_10 ) ) );
cut_ir_10_h = cut_ir_10_h(1:end/2);


figure;
plot( linspace(0,1,length(cut_ir_h)), cut_ir_h, 'Color', col(:,1) );
hold on
plot( linspace(0,1,length(cut_ir_h)), cut_ir_75_h, 'Color', col(:,2) );
plot( linspace(0,1,length(cut_ir_h)), cut_ir_60_h, 'Color', col(:,3) );
plot( linspace(0,1,length(cut_ir_h)), cut_ir_40_h, 'Color', col(:,4) );
plot( linspace(0,1,length(cut_ir_h)), cut_ir_10_h, 'Color', col(:,5) );
xlabel( 'Frequency [pi rad/sample]' )
ylabel( 'Magnitude [dB]' )
title( 'Frequency response of cut IIR filter' )
plot( [0,0.1,0.1], [-100,-100,10], 'r' )
plot( [0.2,0.2,0.3,0.3], [-130,-2,-2,-130], 'r' )
plot( [0.2,0.2,0.3,0.3], [10,0,0,10], 'r' )
plot( [0.4,0.4,1], [10,-100,-100], 'r' )
legend('Length 100% of 10% magnitude mark',...
    'Length 75% of 10% magnitude mark',...
    'Length 60% of 10% magnitude mark',...
    'Length 40% of 10% magnitude mark',...
    'Length 10% of 10% magnitude mark',...
    'Specification boudaries' );
axis( [0,1,-130,10] )
set(gca,'Fontsize',10)
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 10])
saveas(gcf,'./pics/1-1-cut-fresponse.eps','psc2')
%its baad

%% with windows

%make windows
window = hann( i*2 );
window = window( end/2+1:end );
window_75 = hamming( i*2*0.75 );
window_75 = window_75( end/2+1:end );
window_60 = hamming( i*2*0.60 );
window_60 = window_60( end/2+1:end );
window_40 = hamming( i*2*0.40 );
window_40 = window_40( end/2+1:end );
window_10 = hamming( i*2*0.10 );
window_10 = window_10( end/2+1:end );

%recut
cut_ir = uncut_ir(1:i);
cut_ir_75 = uncut_ir( 1:(i*0.75) );
cut_ir_60 = uncut_ir( 1:(i*0.60) );
cut_ir_40 = uncut_ir( 1:(i*0.40) );
cut_ir_10 = uncut_ir( 1:(i*0.10) );

%zero pad
cut_ir = [ cut_ir .* window; zeros( n - length( cut_ir ), 1 ) ];
cut_ir_75 = [ cut_ir_75 .* window_75; zeros( n - length( cut_ir_75 ), 1 ) ];
cut_ir_60 = [ cut_ir_60 .* window_60; zeros( n - length( cut_ir_60 ), 1 ) ];
cut_ir_40 = [ cut_ir_40 .* window_40; zeros( n - length( cut_ir_40 ), 1 ) ];
cut_ir_10 = [ cut_ir_10 .* window_10; zeros( n - length( cut_ir_10 ), 1 ) ];

% make plots
cut_ir_h = mag2db( abs( fft( cut_ir ) ) );
cut_ir_h = cut_ir_h(1:end/2);
cut_ir_75_h = mag2db( abs( fft( cut_ir_75 ) ) );
cut_ir_75_h = cut_ir_75_h(1:end/2);
cut_ir_60_h = mag2db( abs( fft( cut_ir_60 ) ) );
cut_ir_60_h = cut_ir_60_h(1:end/2);
cut_ir_40_h = mag2db( abs( fft( cut_ir_40 ) ) );
cut_ir_40_h = cut_ir_40_h(1:end/2);
cut_ir_10_h = mag2db( abs( fft( cut_ir_10 ) ) );
cut_ir_10_h = cut_ir_10_h(1:end/2);

figure;
plot( linspace(0,1,length(cut_ir_h)), cut_ir_h, 'Color', col(:,1) );
hold on
plot( linspace(0,1,length(cut_ir_h)), cut_ir_75_h, 'Color', col(:,2) );
plot( linspace(0,1,length(cut_ir_h)), cut_ir_60_h, 'Color', col(:,3) );
plot( linspace(0,1,length(cut_ir_h)), cut_ir_40_h, 'Color', col(:,4) );
plot( linspace(0,1,length(cut_ir_h)), cut_ir_10_h, 'Color', col(:,5) );
xlabel( 'Frequency [pi rad/sample]' )
ylabel( 'Magnitude [dB]' )
title( 'Frequency response of cut, windowed IIR filter' )
plot( [0,0.1,0.1], [-100,-100,10], 'r' )
plot( [0.2,0.2,0.3,0.3], [-130,-2,-2,-130], 'r' )
plot( [0.2,0.2,0.3,0.3], [10,0,0,10], 'r' )
plot( [0.4,0.4,1], [10,-100,-100], 'r' )
legend('Length 100% of 10% magnitude mark',...
    'Length 75% of 10% magnitude mark',...
    'Length 60% of 10% magnitude mark',...
    'Length 40% of 10% magnitude mark',...
    'Length 10% of 10% magnitude mark',...
    'Specification boudaries');
axis( [0,1,-130,10] )
set(gca,'Fontsize',10)
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 10])
saveas(gcf,'./pics/1-1-cut-window-fresponse.eps','psc2')