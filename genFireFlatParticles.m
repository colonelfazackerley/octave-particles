% variantLetter is usu a, b, c, ...
function genFireFlatParticles( variantLetter )
    setPage
    nTime = 10
    particleOrigin = [128+border,250+border] %x, y
    nStreamers = 20
    particles = initFireStreamers(nStreamers, particleOrigin);
    particleFiles=[];
    for i=1:nTime
        particleFile = sprintf('fire_flat_particles_%s_%02i.dat', variantLetter,i)
        save(particleFile,'particles'); % save same data to start each time step.
    endfor
endfunction