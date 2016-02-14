% run a crude simulation of fire, with the aim of looking pretty
function fire(datGlob, nSteps, cMap, imgSize, maxWidth, ...
              particleParams, interactionParams, pngPrefix, whiteBg)

pFiles = dir(datGlob);
pFilenames = vertcat(pFiles.name);
nTime = length(pFiles)

  
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
    if whiteBg
        img = ones([ imgSize 3]); % height, width, rgb
        alpha = ones(imgSize);
    else
        img = zeros([ imgSize 3]);
        alpha = zeros(imgSize);
    endif
    for l = 1:nSteps % iterate along length of streamers
        tic
        printf(".");
        toKeep=logical(zeros(size(particles )));
        printf("(made toKeep:%.3f)",toc());
        for i=1:length(particles)
            [ particles(i) keep ] = stepParticle( particles(i), imgSize(2)/2, particleParams );
            toKeep(i) = keep;
        endfor
        printf("(stepped all:%.3f)",toc());
        particles = particles(toKeep);
        printf("(kept some:%.3f)",toc());
        particles = interact (particles, interactionParams);
        printf("(interact:%.3f)",toc());
        [img alpha particles] = plotParticles( img, alpha, particles, cMap, maxWidth, l, t );
        printf("(setting pix:%.3f)",toc());
    endfor
    printf("%s\n", imgFilename = sprintf("%s%02i.png",pngPrefix,t) );
    writeIm(img, alpha, imgFilename ,1);
  endfor
  
endfunction

function writeIm( img, alpha, filename)

  warning off Octave:GraphicsMagic-Quantum-Depth

  img =   uint8( img * 256 );
  alpha(alpha>1) = 1;
  alpha = uint8( alpha * 256);
  
  imwrite(img,filename,'Alpha',alpha);
  imwrite(img,['o_' filename]);
endfunction



