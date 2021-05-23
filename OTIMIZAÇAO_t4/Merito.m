function NICE = Merito(Custo, Amplitude, Ganho, LowBand)
  
  %%  RETORNA O RESULTADO
  NICE = (Amplitude*Ganho)/(Custo*LowBand);
 
endfunction