function writeIm( img, alpha, filename)

  warning off Octave:GraphicsMagic-Quantum-Depth

  img =   uint8( img * 256 );
  alpha(alpha>1) = 1;
  alpha = uint8( alpha * 256);
  
  imwrite(img,filename,'Alpha',alpha);
  imwrite(img,['o_' filename]);
endfunction