close all
clear all

%%EXAMPLE SYMBOLIC COMPUTATIONS

CICLOS_LIMITE  = 100;

params = {"#Cin_val#", "#R1_val#", "#R2_val#",...
          "#Rc_val#" , "#Re_val#", "#Cb_val#",...
          "#Cout_val#", "#Rout_val#"};
filesname.ngspicename     = "AUDIO_AMP.net";
filesname.templatename_1  = "AUDIO_AMP.sch";
filesname.templatename_2  = "AUDIO_AMP.cir";
filesname.rawname         = "AUDIO_AMP_AC.raw";
filesname.dc              = "AUDIO_AMP_DC.raw";
filesname.trans           = "AUDIO_AMP_TRANS.raw";

DIVISOR                   = 10;

NUMERO_POPULACAO          = 100;
NUMERO_FINALISTA          = 100/DIVISOR;
NUMERO_VARIAVEIS          = 8;


%%Oito Variáveis!! Aborrecido
%%Rb1 e Rb2 estão relacionados!! Descobrir melhor relação e diminui-se uma variável
%%Temos de garantir que o bijetor está na região desejada
%%Ver se a input impedance é boa? talvez analizar o resultado se as coisas começarem a correr mal 

Cin   = 1 * 1e-3;
R1    = 80* 1e3;
R2    = 20* 1e3;
Rc    = 1*  1e3;
Re    = 100;
Cb    = 1*  1e-3;
Cout  = 1*  1e-6;
Rout  = 100;
%%  Vetores para teste
Amostra_Geral   = zeros(NUMERO_VARIAVEIS, NUMERO_POPULACAO);
Amostra_Melhor  = zeros(NUMERO_VARIAVEIS, NUMERO_FINALISTA);
Ranking_Geral   = zeros(1,                NUMERO_POPULACAO);
Ranking_Melhor  = zeros(2,                NUMERO_FINALISTA);

%%
%%  Primeiro Passo
%%

%%  Atribuição inicial
Amostra_Geral(:,1) = [ Cin ; R1  ; R2; ...
                       Rc  ; Re  ; Cb; ...
                       Cout; Rout];
%%  Atribuilção Geral
for c=2:size(Amostra_Geral,2)
  
  Amostra_Geral(:,c) = Random_Generator( Amostra_Geral(:,1) );
  
endfor
Ranking_Geral(:)  = 0;

%%
%%  Testes
%%
for c=1:CICLOS_LIMITE
  
  %%  Teste
  for d=1:NUMERO_POPULACAO
    
    test_vector = Amostra_Geral(:,d);
    dados = NGSpice_to_Octave(filesname, params, test_vector);   
    
    maximum   = abs(max(dados(:,2)));
    lowlimit  = dados(1,3);
    highlimit = dados(1,4);
    
    if (Verificacao_Full(filesname, 1))
      Amp      = maximum;
    else
      Amp      = 0;
    endif

    Banda_min       = lowlimit;
    Banda           = highlimit - lowlimit;
    
    Resistencias_total  = test_vector(2)+test_vector(3)+test_vector(4)...
                        + test_vector(5)+test_vector(8);
    Condensadores_total = test_vector(1)+test_vector(6)+test_vector(7);
    Transistores_total  = 2;
    Custo               = Resistencias_total*1e-3 + Condensadores_total*1e6 ...
                        + Transistores_total*1e-1;
    
    Ranking_Geral(d) = Merito(Custo, Banda, Amp, Banda_min);
    
  endfor
  printf("Fim das contas - Inicio do Ranking \n");
  %%  Ranking
  for d=1:NUMERO_FINALISTA
    holder = 1;
    for f=1:NUMERO_POPULACAO
      
      if(Ranking_Geral(f)>Ranking_Geral(holder))
        holder = f;
      endif
      
    endfor
    %%Atribuição dos lugares
    Ranking_Melhor(1,d)   = Ranking_Geral(holder);
    Ranking_Melhor(2,d)   = d;
    Ranking_Geral(holder) = 0;
    Amostra_Melhor(:,d)   = Amostra_Geral(:,holder);
    %printf("Numero %d spotted \n", d);
  endfor
  printf("Fim do Ranking - Inicio da Renovação \n");
  %%  Renovação
  for d=1:NUMERO_FINALISTA
    %%  Renova os Melhores
    Amostra_Geral(:,1 + (d-1)*DIVISOR) = Amostra_Melhor(:,d);
    %printf("Numero %d renovated \n", 1 + (d-1)*DIVISOR);
    %%  Varia os Melhores
    for f=1:(DIVISOR-1)
      Amostra_Geral(:, 1 + (d-1)*DIVISOR + f) = Random_Generator(Amostra_Melhor(:,d));
      %printf("Numero %d introduced \n", 1 + (d-1)*DIVISOR + f);
    endfor
    %printf("Numero %d fully renovated \n", d);
  endfor
  printf("Fim do Ciclo %d de %d; best = %.4e\n", c, CICLOS_LIMITE, Ranking_Melhor(1));
endfor

                   
        test_vector = [ Cin , R1  , R2, ...
                    Rc  , Re  , Cb, ...
                    Cout, Rout];
    
    dados = NGSpice_to_Octave(filesname, params, test_vector);   
    
    maximum   = abs(max(dados(:,2)));
    lowlimit  = dados(1,3);
    highlimit = dados(1,4);
    
    if (Verificacao_Full(filesname, 1)==1)
      Amp      = maximum;
    else
      Amp      = 0;
    endif
    
    Banda_min       = lowlimit;
    Banda           = highlimit - lowlimit;
    Custo           = (R1+R2+Rc+Re+Rout)*1e-3 + (Cb+Cin+Cout)*1e6 + 0.2;
    Nice_Stuff = Merito(Custo, Banda, Amp, Banda_min);
    
