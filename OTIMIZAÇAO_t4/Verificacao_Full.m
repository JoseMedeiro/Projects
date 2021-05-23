%%  Função Full Verifcador

function NICE = Verificacao_Full(filesname, limite)
  
  %%  LÊ OS DADOS QUE JÁ FORAM CRIADOS NO NGSPICE
  data_DC   = spice_readfile3(filesname.dc, 0);
  data_TRAN = spice_readfile3(filesname.trans, 0);
  %%  AVALIA AS CONDIÇÕES
  check_1   = Verificacao_DC(data_DC);
  check_2   = Verificacao_TRAN(data_TRAN, limite);
  %%  RETORNA O RESULTADO
  if(check_1*check_2)
    NICE = 1;
  else
    NICE = 0;
  endif

endfunction



