% change velocities modelling forces between particles
function particles = interact( particles, interactionParams )
  for i=1:length(particles)
    for j=1:length(particles)
      if j>=i
        continue
      endif
      p_i = particles(i);
      p_j = particles(j);
      if interactionParams.fExclusionZone(p_i.pos) && interactionParams.fExclusionZone(p_j.pos)
        continue
      endif
      d = p_i.pos - p_j.pos; % displacement vector
      distsq = sum(d.^2);
      if distsq > interactionParams.distSqLimit
        continue
      endif
      f = interactionParams.fForce(distsq,d);
      particles(i).vel += f ;
      particles(j).vel += -f ;
    endfor
  endfor
endfunction

