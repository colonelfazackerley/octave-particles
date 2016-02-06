% run a crude simulation of fire, with the aim of looking pretty
function fire(datGlob, nSteps, cMap, imgSize, maxWidth, interactionParams, whiteBg)

pFiles = dir(datGlob);
pFilenames = vertcat(pFiles.name);
nTime = length(pFiles);

  
  % run
  for t = 1:nTime
    % init
    printf("%s\n",pFilenames(t,:));
    load( pFilenames(t,:), 'particles' );
    nParticles = length(particles);
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
        printf(".");
        
        toKeep=logical(zeros(size(particles )));
        for i=1:length(particles)
        [ particles(i) keep ] = stepParticle( particles(i), imgSize(2)/2 );
        toKeep(i) = keep;
        endfor
        particles = particles(toKeep);
        particles = interact (particles);
        [img alpha particles] = plotParticles( img, alpha, particles, cMap, maxWidth, l, t );
        
    endfor
    printf("%s\n", imgFilename = sprintf("fire_c_%02i.png",t) );
    writeIm(img, alpha, imgFilename ,1);
  endfor
  
endfunction

function writeIm( img, alpha, filename)

  warning off Octave:GraphicsMagic-Quantum-Depth

  img =   uint8( img * 256 );
  alpha(alpha>1) = 1;
  alpha = uint8( alpha * 256);
  
  imwrite(img,filename,'Alpha',alpha);

endfunction

function [img alpha particles] = plotParticles( img, alpha, particles, cMap, maxWidth, length_i, time_i)
  for i=1:length(particles)
    p = particles(i);
    colour = cMap(ceil(particles(i).temp), : );
#     plot( [p.oldPos(1) p.pos(1)], [p.oldPos(2) p.pos(2)], 
#             'color', colour(1:3),
#             'linewidth', 5 );
    
    wid = maxWidth * widthMod( length_i, time_i, p.params ); 
    
    [img alpha] = setLine( img, alpha, ...
                           p.oldPos, p.pos,  ...
                           colour, p.oldWidth, wid );
    particles(i).oldWidth = wid;
   
  endfor
endfunction

function [img alpha] = setPixelSingle(img, alpha, x,y, colour)
  px = ceil(x);
  py = ceil(y); 
  if px > 0 && px < columns(alpha) && py > 0 && py < rows(alpha)
    img( py , px , : ) = colour(1:3);
    alpha( py, px ) += colour(4);
  endif
endfunction

function [img alpha] = ...
     setLine( img, alpha, p1, p2,  colour, oldWid, wid)
  if 0 == oldWid
    return;
  endif
  d = p2 -p1; % displacement vector
  l = sqrt(sum(d.^2)); % length of displacement vector
  du = d / l ; % unit vector
  dun = [du(2)  -du(1)]; % normal to unit vector, for thickening line

  s = 0.5; % a little bit less than 1 to avoid holes in the line
  for i = 0:s:l
    p = p1 + du * i ;
    iWid = interp1([0 l], [oldWid wid], i); % interpolated width
    for j = -iWid:s:iWid  % thicken line by drawing row of points
      pa = p + dun * j;
      [img alpha] = setPixelSingle ( img, alpha, pa(1), pa(2), colour);
    end
  endfor
endfunction


