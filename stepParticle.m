% applies forces to particles  that do not depend
% on other particles.
function [p keep] = stepParticle( p, midWdith, particleParams )
  p.oldPos = p.pos; % store old pos for drawing lines
  p.pos += p.vel ; % move
  
  cooling = particleParams.fCooling(p.pos-p.origPos) ;
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