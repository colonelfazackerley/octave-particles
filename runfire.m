
% config
nTime = 10 ; % number of time steps
nSteps = 52 %100; % streamer length steps
cMap = tempScale();
maxWidth = 10 ; % max half width of streamers
setPage

fire('fire_flat_particles_*.dat', nSteps, cMap, imgSize, maxWidth, whiteBg);