%%  Função Random Generator
%
%   Cria um novo vetor aleatório
%   (vetor linha)
%
%%
function vetor = Random_Generator(vetor_base)
  
  
  do
    aleatorio = rand(size(vetor_base,1), 2);
    
    aleatorio(1,:) = aleatorio(1,:)*0.05;
    for c=1:size(vetor_base,1)
      if (aleatorio(c,2) < 0.5)
        aleatorio(c,1) = -aleatorio(c,1);
      endif
    endfor
    vetor =  vetor_base.*(1+aleatorio(:,1));
    
  %%  Verifica se todos são positivos
  until (min(vetor) > 0);
 
 
endfunction