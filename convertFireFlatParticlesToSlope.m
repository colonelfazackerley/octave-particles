function convertFireFlatParticlesToSlope( variant )
    datGlob = sprintf('fire_flat_particles_%s_*.dat', variant);
    pFiles = dir(datGlob);
    pFilenames = vertcat(pFiles.name)
    nTime = length(pFiles)
    setPage
    for t=1:nTime
        % right rise
        load( pFilenames(t,:), 'particles' );
        nParticles = length(particles);
        for i=1:nParticles
            pos = particles(i).pos;
            pos = pos - [0 (pos(1)-border)] + [ 0 128]; % slope and larger page 
            particles(i).pos = pos;
        endfor
        particleFile = sprintf('fire_rise_right_particles_%s_%02i.dat',variant, t)
        save(particleFile,'particles');
        % left rise
        load( pFilenames(t,:), 'particles' );
        nParticles = length(particles);
        for i=1:nParticles
            pos = particles(i).pos;
            
            pos = pos + [0 (pos(1)-border-256)] + [ 0 128]; % slope and larger page 
            particles(i).pos = pos;
        endfor
        particleFile = sprintf('fire_rise_left_particles_%s_%02i.dat',variant, t)
        save(particleFile,'particles');
        
    endfor
endfunction