% streamers = initFireStreamers(n, particleOrigin)
% n: number of streamers
% particleOrigin: positions centred around here
function streamers = initFireStreamers(n, particleOrigin)
    particles = [];
    for i = 1:n
        particles = [particles makeParticle(particleOrigin)];
    endfor
    streamers = particles;
endfunction

function p = makeParticle( o )
  p.oldWidth =0;
  p.oldPos = [0 0];
  p.pos = (rand(1,2) - 0.5 ) .*[200 32] + [o(1) o(2)]  ; %position
  p.vel = (rand(1,2)-0.5) * 2 + [0 -1]  ; %velocity
  p.posWalk = (rand(1,2) - 0.5)*10; % starting conditions change a bit between frames
  p.velWalk = (rand(1,2) - 0.5)*2;
  p.temp = rand(1) * 5 + 95 ; %temperature (scale 1-100)
  p.params.phase=rand(1,2)*6; % params for streamer modulation function
  p.params.period = rand(1,2)*20+[30 60];
endfunction