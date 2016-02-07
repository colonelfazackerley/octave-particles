setPage
particleOrigin = [128+border,250+border] %x, y
nStreamers = 20
particles = initFireStreamers(nStreamers, particleOrigin);
particleFiles=[];
for i=1:nTime
    particleFile = sprintf('fire_flat_particles_%02i.dat',i)
    save(particleFile,'particles'); % save same data to start each time step.
endfor