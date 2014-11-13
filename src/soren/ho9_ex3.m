clear all
close all

plotN = 10;
col = jet( plotN )';
col = col*0.95;


%% Grandma's soo MAADLAB, yeah!

%% What parents expects:
%parameters
Fs = 44100;
T = 4;

%generate stuff
t = 0:1/Fs:T;
s = chirp( t, 50, T, 5000 );

%this is what she expets to hear:
%sound( s*0.1, 44100 ); %Turn down for what? Eh ok.
%or as a plot:
f = linspace( 50, 5000, plotN );
m = ones(1,length(f));

figure; hold on;
for i = 1:length(f)
    stem( f(i), m(i), 'color', col(:,i) );
end
axis( [0, 20000, -1.25, 1.25] )

%% What you expect, because that PC was damn expensive
%  so that soundcard better perform reeeal nice
%parameters
Fs = 5000;
T = 4;

%generate stuff
t = 0:1/Fs:T;
s = chirp( t, 50, T, 5000 );

%this is what we hear:
%sound( s*0.1, 5000 ); %Ew

%or as a plot (first second)
f = linspace( 50, 5000, plotN );
m = ones(1,length(f));
f = [f, linspace( Fs-50, Fs-5000, plotN )];
m = [m,-m];

figure; hold on;
for i = 1:length(f)
    if f(i) <= 2500
    stem( f(i), m(i), 'color', col(:,mod(i-1,plotN)+1) );
    end
end
axis( [0, 20000, -1.25, 1.25] )
xlabel( 'Frequency [Hz]' )
ylabel( 'Magnitude []' )
title( 'Frequency of cosine wave' )
set(gca,'Fontsize',10)
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 5])
saveas(gcf,'./pics/3-1-sweep-fold-brick.eps','psc2')

%% What w'all  hear: ('caus that shit was not made for an Fs of 5000Hz)
%parameters
Fs = 5000;
T = 4;

%generate stuff
t = 0:1/Fs:T;
s = chirp( t, 50, T, 5000 );

%this is what we hear:
%sound( s*0.1, 5000 ); %Ew

%or as a plot (first second)
f = linspace( 50, 5000*0.25, plotN );
m = ones(1,length(f));
f = [f, linspace( Fs-50, Fs-5000*0.25, plotN )];
m = [m,-m];

f = [f,f+Fs];
m = [m,-m];
f = [f,f+Fs];
m = [m,-m];
f = [f,f+Fs];
m = [m,-m];

figure; hold on;
for i = 1:length(f)
    stem( f(i), m(i), 'color', col(:,mod(i-1,plotN)+1) );
end
axis( [0, 20000, -1.25, 1.25] )
xlabel( 'Frequency [Hz]' )
ylabel( 'Magnitude []' )
title( 'Frequency of cosine wave' )
set(gca,'Fontsize',10)
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 5])
saveas(gcf,'./pics/3-1-sweep-fold-nofilt.eps','psc2')

m = m.*sinc(f/5000); % zero order hold DAC

figure; hold on;
for i = 1:length(f)
    stem( f(i), m(i), 'color', col(:,mod(i-1,plotN)+1) );
end
axis( [0, 20000, -1.25, 1.25] )
xlabel( 'Frequency [Hz]' )
ylabel( 'Magnitude []' )
title( 'Frequency of cosine wave' )
set(gca,'Fontsize',10)
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 5])
saveas(gcf,'./pics/3-1-sweep-fold-zero.eps','psc2')

