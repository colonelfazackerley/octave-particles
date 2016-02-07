
% config
nTime = 10 ; % number of time steps
nSteps = 52 %100; % streamer length steps
cMap = tempScale();
maxWidth = 10 ; % max half width of streamers
setPage

pngPrefix = "fire_a";

interactionParams.fExclusionZone = @(pos) pos(2) > 200;
interactionParams.distSqLimit = 3000;
interactionParams.fForce = @(distSquared, displacement) 0.4 * displacement / distSquared; 

particleParams.fCooling = @(pos) (265 - pos(2))/80 + rand(1)*1

fire('fire_flat_particles_*.dat', nSteps, cMap, imgSize, maxWidth, ...
     particleParams, interactionParams, pngPrefix, whiteBg);
     

cmd = sprintf("convert -loop 0 -delay 10 %s*.png  %s.gif",pngPrefix,pngPrefix);
printf("%s\n",cmd);
system(cmd);