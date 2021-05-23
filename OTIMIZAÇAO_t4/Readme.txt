Apresenta-se aqui o sistema pelo qual se está a melhorar o circuito.
Algumas destas funções não foram realizadas por mim, José Medeiro, pelo que peço, por agora, que as usem com cautela.
Os autores estão mencionados nas funções (assinaladas com #) e pretendo no futuro mencionálos aqui.

Testes.m - É a função mãe, vai fazer os testes;

Verificacao_Full.m 		- Faz a verificação dos critérios para que o circuito seja aceite;
Verificacao_DC.m		- Faz a verificacao dos critérios DC do circuito;
Verificacao_Trans.m		- Faz a verificacao dos critérios temporal do circuito;

Merito.m			- Calcula o mérito do circuito;

Random_Generator.m		- Cria um vetor novo alterando ligeiramente o dado;

NGSpice_to_Octave.m		- Coordena as funções que permitem testar o circuito em NGSpice e trazer os resultados para o Octave;
#DE_templatefile_read.m	- Lê o ficheiro .sch que contêm o circuito em teste (com valores simbólicos);
#DE_templatefile_write.m	- Escreve um ficheiro .cir com base no que leu no ficheiro .sch e os valores dados;
#spice_readfile3.m		- Lê os resultados da simulação NGSpice guardados num ficheiro .raw.

Pretendo criar mais funções para simplificar o Testes.m.
