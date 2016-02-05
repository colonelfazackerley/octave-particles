
% config
nTime = 10 ; % number of time steps
nStreamers = 2% ; % n streamers
nSteps = 52 %100; % streamer length steps
cMap = tempScale();
border = 32;
maxWidth = 10 ; % max half width of streamers
particleOrigin = [128+border,220+border];
imgSize = 256+2*border;
whiteBg = 0 ; % 1:not transparent

% init
# particles = initFireStreamers(nStreamers, particleOrigin);
# particleFiles=[];
# for i=1:nTime
#     particleFile = sprintf('fire_flat_particles_%02i.dat',i)
#     save(particleFile,'particles'); % save same data to start each time step.
# endfor

fire('fire_flat_particles_*.dat', nSteps, cMap, imgSize, maxWidth, whiteBg);