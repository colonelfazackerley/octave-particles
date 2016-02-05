function fire()

  % tidy
  close all
  
  % config
  nTime = 10 ; % number of time steps
  nParticles = 2% ; % n streamers
  nSteps = 52 %100; % streamer length steps
  cMap = tempScale();
  border = 32;
  maxWidth = 10 ; % max half width of streamers
  particleOrigin = [128+border,220+border];
  imgSize = 256+2*border;
  whiteBg = 0 ; % 1:not transparent
  
  % check config
  % showColourMap ( cMap( :,1:3) );
  
  % init
  particles = initFireStreamers(nParticles, particleOrigin);
  
  origParticles = particles;

#   figure ;
#   axis ;
#   set(gca,'ydir','reverse');
#   hold on ;
#   border2 = imgSize -border;
#   plot([border border2 border2 border border],
#         [border border border2 border2 border]);
#   axis([0 imgSize 0 imgSize]);

  
  % run
  for t = 1:nTime
  printf("\nt:%i",t)
    % init
    particles = origParticles;
    for i = 1:nParticles
      particles(i).pos += particles(i).posWalk* sin(2*pi()*t/nTime);
      particles(i).vel += particles(i).velWalk* sin(2*pi()*t/nTime);
    endfor
    if whiteBg
        img = ones(imgSize,imgSize,3);
        alpha = ones(imgSize,imgSize);
    else
        img = zeros(imgSize,imgSize,3);
        alpha = zeros(imgSize,imgSize);
    endif
    
    for l = 1:nSteps % iterate along length of streamers
        printf(".");
        
        toKeep=logical(zeros(size(particles )));
        for i=1:length(particles)
        [ particles(i) keep ] = stepParticle( particles(i), imgSize/2 );
        toKeep(i) = keep;
        endfor
        particles = particles(toKeep);
        particles = interact (particles);
        [img alpha particles] = plotParticles( img, alpha, particles, cMap, maxWidth, l, t );
        
    endfor
    writeIm(img, alpha, sprintf("fire_c_%02i.png",t),1);
  endfor
  
endfunction

function writeIm( img, alpha, filename)

  img =   uint8( img * 256 );
  alpha(alpha>1) = 1;
  alpha = uint8( alpha * 256);
  
  imwrite(img,filename,'Alpha',alpha);

endfunction

function [p keep] = stepParticle( p, midWdith )
  p.oldPos = p.pos; % store old pos for drawing lines
  p.pos += p.vel ; % move
  
  cooling = (240 - p.pos(2))/80 + rand(1)*1 ;
  p.temp -= cooling;
  if p.temp > 100
    p.temp = 100 ;
  endif
  
  p.vel += [0 -0.06] ; % accelerate up
  
  % force in from the sides approximating incoming air
  latF = (p.pos(1) - midWdith)/600 ;
  latF = 100*latF/p.pos(2);
  p.vel(1) -= latF ; 
  
  if p.temp < 1
    keep = false;
  else
    keep = true;
  endif
endfunction

function particles = interact( particles )
  for i=1:length(particles)
    for j=1:length(particles)
      if j>=i
        continue
      endif
      p_i = particles(i);
      p_j = particles(j);
      if p_i.pos(2)>200 && p_j.pos(2)>200
        return; % stop interactions too low down. stops
        % streamers being pushed off the bottom
      endif
      d = p_i.pos - p_j.pos; % displacement vector
      distsq = sum(d.^2);
      if distsq > 3000
        continue
      endif
      f = 0.4 * d / distsq ; % force, inverse law
      
      particles(i).vel += f ;
      particles(j).vel += -f ;
    endfor
  endfor
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

function cMap = tempScale()

  %    grey black red red    orange whitish yellow red
  r = [0.5  0     1   1      1      1       1      1   ];
  g = [0.5  0     0   0      0.5    .9      1      0   ];
  b = [0.5  0     0   0      0      .8      0      0   ];
  a = [0    1     1   1      1      1       1      1  ]*.1;
  i = [1    15    20  30     50     80      95     100 ];
  
  cMap = zeros( 100, 4); % RGBA
  cMap( : , 1 ) = interp1( i, r, 1:100 );
  cMap( : , 2 ) = interp1( i, g, 1:100 );
  cMap( : , 3 ) = interp1( i, b, 1:100 );
  cMap( : , 4 ) = interp1( i, a, 1:100 );
endfunction

function showColourMap( cMap )
  figure
  hold on
  for i=1:rows(cMap)
    plot( [0 1], [-i -i], 'color',cMap( i, : ) );
  endfor
endfunction

