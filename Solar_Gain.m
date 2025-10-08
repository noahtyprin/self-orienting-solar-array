%% Below code calculates the percentage gain of energy over the course of a day.
clear; clc;

lat = 42;          % latitude (deg)
G = 1367;          % solar constant (W/m^2)

% solar declination and daylight limits
d = 23.45;
w = linspace(-acosd(-tand(lat)*tand(d)), acosd(-tand(lat)*tand(d)), 400); 

% solar zenith
z = acosd(sind(lat).*sind(d) + cosd(lat).*cosd(d).*cosd(w));

% flat panel receives cos(theta_z); tracker always normal to sun
I_flat  = G * cosd(z);
I_track = G * ones(size(z));

I_flat(I_flat<0) = 0;  % remove negative values (night)

% integrate energy accumulation
E_flat  = trapz(w, I_flat)/15;   % Wh/m^2  (15deg = 1 hr)
E_track = trapz(w, I_track)/15;

gain = E_track/E_flat;

plot(w/15, I_flat, 'b', w/15, I_track, 'r--','LineWidth',1.2);
xlabel('Hours from noon'); ylabel('Irradiance (W/m^2)');
legend('Flat','Tracking'); grid on;
title(sprintf('Latitude %.0fdeg |  Gain = %.2fx (%.0f%% increase)', lat, gain, (gain-1)*100));
