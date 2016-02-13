function convertFireParticlesSlopeTransition( variant )
    fallDatGlob = sprintf('fire_falling_particles_%s_*.dat', variant);
    rightDatGlob = sprintf('fire_rise_right_particles_%s_*.dat',variant );
    leftDatGlob = sprintf('fire_rise_left_particles_%s_*.dat',variant );
    fallFiles = dir(fallDatGlob);
    rightFiles = dir(rightDatGlob);
    leftFiles = dir(leftDatGlob);
    setPage
    nTime = length(fallFiles);
    
    transSpeed = 25 ; % speed to move from one position to another. pixels per time step
    
    for t=1:nTime
        % right rise
        load( fallFiles(t).name, 'particles' );
        fallPs = particles;
        load( rightFiles(t).name, 'particles' );
        slopePs = particles;
        nParticles = length(particles);
        for i=1:nParticles
            fpos = fallPs(i).pos ;%+ [ 0 128]; % transform onto larger page [x y]
            spos = slopePs(i).pos;
            dirn = spos-fpos ;
            dist = sqrt(sum(dirn.^2));
            unitv = dirn/dist;
            transDist = transSpeed * (t-1);
            if transDist > dist
                particles(i).pos = spos; % stop when arrived at final position
            else
                particles(i).pos = fpos + unitv * transDist;
            endif
            particles(i).origPos = particles(i).pos;
        endfor
        particleFile = sprintf('fire_fall_to_rise_right_particles_%s_%02i.dat',variant, t)
        save(particleFile,'particles');
        
        % left rise 
        load( fallFiles(t).name, 'particles' );
        fallPs = particles;
        load( leftFiles(t).name, 'particles' );
        slopePs = particles;
        nParticles = length(particles);
        for i=1:nParticles
            fpos = fallPs(i).pos ;%+ [ 0 128]; % transform onto larger page [x y]
            spos = slopePs(i).pos;
            dirn = spos-fpos ;
            dist = sqrt(sum(dirn.^2));
            unitv = dirn/dist;
            transDist = transSpeed * (t-1);
            if transDist > dist
                particles(i).pos = spos; % stop when arrived at final position
            else
                particles(i).pos = fpos + unitv * transDist;
            endif
            particles(i).origPos = particles(i).pos;
        endfor
        particleFile = sprintf('fire_fall_to_rise_left_particles_%s_%02i.dat',variant, t)
        save(particleFile,'particles');
        
    endfor
endfunction