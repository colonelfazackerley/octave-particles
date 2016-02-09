function convertFireFlatParticlesToBall( variant )
    datGlob = sprintf('fire_flat_particles_%s_*.dat', variant);
    pFiles = dir(datGlob);
    pFilenames = vertcat(pFiles.name)
    nTime = length(pFiles)
    setPage
    moveToward = [ imgSize(2)/2 220 ];
    %testPlot( imgSize, border)

    for t=1:nTime
        load( pFilenames(t,:), 'particles' );
        nParticles = length(particles);
        for i=1:nParticles
            pos = particles(i).pos;
            plot(pos(1),pos(2),'g.')
            hold on
        endfor
        for k=1:4
            for i=1:nParticles
                pos = particles(i).pos;
                dirn = moveToward - pos;
                newPos = pos + dirn * 0.0015 * sqrt(sum(dirn.^2));
                for j=1:nParticles
                    if i==j
                        continue
                    endif
                    distNew = sqrt(sum(newPos - particles(j).pos));
                    dist    = sqrt(sum(pos - particles(j).pos));
                    if distNew<200 && distNew < dist
                        particles(i).pos = newPos;
                        break;
                    endif
                endfor
            endfor
        endfor
        for i=1:nParticles
            pos = particles(i).pos;
            plot(pos(1),pos(2),'r.')
            hold on
        endfor
        
        particleFile = sprintf('fire_falling_particles_%s_%02i.dat',variant, t)
        save(particleFile,'particles');
    endfor

endfunction
