
% config
nTime = 10 ; % number of time steps
nSteps = 52 %100; % streamer length steps
cMap = tempScale();
maxWidth = 10 ; % max half width of streamers
setPage

pngPrefix = "fire_a_";

interactionParams.fExclusionZone = @(pos) pos(2) > 200;
interactionParams.distSqLimit = 3000;
interactionParams.fForce = @(distSquared, displacement) 0.4 * displacement / distSquared; 

fire('fire_flat_particles_*.dat', nSteps, cMap, imgSize, maxWidth,interactionParams, pngPrefix, whiteBg);