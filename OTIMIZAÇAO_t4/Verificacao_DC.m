%%  Função DC Verifcador
%
%   Confirma se os transistores estão em FAR
%
%%
function NICE = Verificacao_DC(data_DC)
  
  %%  RETORNA O RESULTADO
  %printf("%d and %d - DC- size %d\n", data_DC(1), data_DC(2), data_DC(3));
  if( (data_DC(2)>0) && (data_DC(3)>0))
    NICE = 1;
  else
    NICE = 0;
  endif
 
endfunction