
% config
nTime = 10 ; % number of time steps
nSteps = 52 %100; % streamer length steps
cMap = tempScale();
maxWidth = 10 ; % max half width of streamers
setPage

pngPrefix = "fire_rise_right_a_";

interactionParams.fExclusionZone = @(pos) pos(2) >= 200 + 32 - pos(1);
interactionParams.distSqLimit = 3000;
interactionParams.fForce = @(distSquared, displacement) 0.4 * displacement / distSquared; 

%testPlot(imgSize, border, interactionParams)

fire('fire_rise_right_particles_*.dat', nSteps, cMap, imgSize, maxWidth,interactionParams, pngPrefix, whiteBg);