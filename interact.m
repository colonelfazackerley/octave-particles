% change velocities modelling forces between particles
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