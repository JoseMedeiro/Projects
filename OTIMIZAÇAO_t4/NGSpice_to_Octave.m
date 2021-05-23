%%%%VAI FAZER O PLANEAMENTO PARA QUE A ANÁLISE DO NGSPICE SEJA FEITA

#   filename: struct with the names of the files
#   params:   cell array of strings containing the parameters
#   test_vector:   vector of test values

function data = NGSpice_to_Octave(filesname, params, test_vector)
  
  %%  LÊ E ATUALIZA O CIRCUITO
  [parse_table, template_file] = ...
    DE_templatefile_read(filesname.templatename_1, params);
  DE_templatefile_write(filesname.templatename_2, template_file,...
    parse_table, test_vector);
  
  %%  CORRE O NGSPICE E OBTEM DADOS
  system(sprintf("ngspice -b %s >/dev/null 2>/dev/null",filesname.ngspicename));
  data = spice_readfile3(filesname.rawname, 0);
  
endfunction
