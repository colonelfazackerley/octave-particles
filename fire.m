% run a crude simulation of fire, with the aim of looking pretty
function fire(datGlob, nSteps, cMap, imgSize, maxWidth, ...
              particleParams, interactionParams, pngPrefix)

pFiles = dir(datGlob);
pFilenames = vertcat(pFiles.name);
nTime = length(pFiles)

timingOutput = 0;
  
  % run
  for t = 1:nTime
    % init
    load( pFilenames(t,:), 'particles' );
    nParticles = length(particles);
    printf("%s nParticles:%i\n",pFilenames(t,:), nParticles);
    for i = 1:nParticles
      particles(i).pos += particles(i).posWalk* sin(2*pi()*t/nTime);
      particles(i).vel += particles(i).velWalk* sin(2*pi()*t/nTime);
    endfor

    img = zeros([ imgSize 3]);
    alpha = zeros(imgSize);

    outerTic=tic();
    for l = 1:nSteps % iterate along length of streamers
        timingString ="";
        innerTic=tic();
        printf(".");
        toKeep=logical(zeros(size(particles )));
        timingString = [timingString sprintf("(made toKeep:%.3f)",toc(innerTic))];
        for i=1:length(particles)
            [ particles(i) keep ] = stepParticle( particles(i), imgSize(2)/2, particleParams );
            toKeep(i) = keep;
        endfor
        timingString = [timingString sprintf("(stepped all:%.3f)",toc(innerTic))];
        particles = particles(toKeep);
        timingString = [timingString sprintf("(kept some:%.3f)",toc(innerTic))];
        particles = interact (particles, interactionParams);
        timingString = [timingString sprintf("(interact:%.3f)",toc(innerTic))];
        [img alpha particles] = plotParticles( img, alpha, particles, cMap, maxWidth, l, t );
        timingString = [timingString sprintf("(setting pix:%.3f)",toc(innerTic))];
        if timingOutput
            printf("%s",timingString);
        endif
    endfor
    printf("%04.1fs %s\n", toc(outerTic), imgFilename = sprintf("%s%02i.png",pngPrefix,t) );
    writeIm(img, alpha, imgFilename ,1);
  endfor
  
endfunction





