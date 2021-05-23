%%  Função DC Verifcador
%
%   Confirma se o output não se degradou
%
%%
function NICE = Verificacao_TRAN(data_TRAN, limite)
  
  %%  LÊ OS DADOS QUE JÁ FORAM CRIADOS NO NGSPICE
  Tempo     = data_TRAN(:,1);
  Output    = data_TRAN(:,2);
  Input     = data_TRAN(:,3);
  f         = data_TRAN(1,4);
  T         = 1/f;
  %%  PROCURA O AUMENTO EM AMPLITUDE
  Amp_I = max(abs(Input));
  Amp_O = max(abs(Output));
  Gain = Amp_O/Amp_I;
  %%  PROCURA A DESFASAGEM
  teste_1 = Input(1);
  teste_2 = Input(2);
  c = 3;
  while (c<size(Input,2)) && (teste_1*teste_2 > 0)
    teste_1 = teste_2;
    teste_2 = Input(c);    
    c = c +1;
  endwhile
  
  teste_1 = Output(1);
  teste_2 = Output(2);
  d = 3;
  while (c<size(Output,2)) && (teste_1*teste_2 > 0)
    teste_1 = teste_2;
    teste_2 = Output(c);    
    d = d +1;
  endwhile
  
  delta_ph  = (Tempo(d-1)-Tempo(c-1))*T/(2*pi);
  %%  CRIA O IDEAL
  Ideal     = real(Input*Gain*e^(i*delta_ph));
  %%  AVALIA AS CONDIÇÕES
  Sum = 0;
  for c=1:size(Ideal,2)
    Sum = Sum + abs(Ideal(c) - Output(c));
  endfor
  
  delta = Sum/size(Ideal,2);

  %printf("Diferença = %e por linha\n", delta);
  %%  RETORNA O RESULTADO
  if(delta < limite)
    NICE = 1;
  else
    NICE = 0;
  endif
 
endfunction