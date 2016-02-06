datGlob = 'fire_flat_particles_*.dat';
pFiles = dir(datGlob);
pFilenames = vertcat(pFiles.name)
nTime = length(pFiles)
setPage
for t=1:nTime
    load( pFilenames(t,:), 'particles' );
    nParticles = length(particles);
    for i=1:nParticles
        pos = particles(i).pos;
        pos = pos - [0 (pos(1)-border)]; 
        particles(i).pos = pos;
    endfor
    particleFile = sprintf('fire_rise_right_particles_%02i.dat',t)
    save(particleFile,'particles');
endfor