
% config
nTime = 10 ; % number of time steps
nSteps = 52 %100; % streamer length steps
cMap = tempScale();
maxWidth = 10 ; % max half width of streamers
setPage

vertOffset = 128;

imgSize += [vertOffset 0]; %imgSize is height, width

pngPrefix = "fire_rise_right_a_";

interactionParams.fExclusionZone = @(pos) pos(2) >= 200 + 32 + 128 - pos(1);
interactionParams.distSqLimit = 3000;
interactionParams.fForce = @(distSquared, displacement) 0.4 * displacement / distSquared; 

particleParams.fCooling = @(pos) (265 + 32 + 128 -pos(1) - pos(2))/80 + rand(1)*1

%testPlot(imgSize, border, interactionParams)

fire('fire_rise_right_particles_*.dat', nSteps, cMap, imgSize, maxWidth, ...
     particleParams, interactionParams, pngPrefix, whiteBg);

cmd = sprintf("convert -loop 0 -delay 10 o_%s*.png  %s.gif",pngPrefix,pngPrefix);
printf("%s\n",cmd);
system(cmd);