COMANDOS APT
  
```apt install```	        	           
> Instala um pacote

```apt-get -f install```
> Corrigir problemas de dependências, concluir instalação de pacotes pendentes e outros erros
> 
```apt remove```	        	           
> Remove um pacote
> 
```apt purge```	       	           
>Remove o pacote com configuração
>
```apt update```	                 
>Atualiza o índice do repositório
>
```apt upgrade```	                  
>Atualiza todos os pacotes atualizáveis
>
```apt autoremove```	          
>Remove pacotes indesejados
>
```apt full-upgrade```		   
>Atualiza pacotes com tratamento automático de dependências
>
```apt search```	               
>Procura pelo programa
>
```apt show```	                 
>Mostra detalhes do pacote
>
```apt-get check```              
>Verifica se as resoluções das dependências estão corretas
>
```apt list```	                                   
>Lista pacotes com critérios (instalados, atualizáveis, etc.)
>
```apt edit-sources```	                           
>Edita lista de fontes

COMANDOS ÚTEIS

```sudo dpkg --configure -a```                       
>Solucionar problemas causados por interrupção na instalação, e pendências na configuração do pacote
>
```sudo dpkg -i --force-all```                       
>Para forçar a instalação
>
```sudo dpkg -r [nome do pacote]```                  
>Desistir da instalação
>
```man```                                            
>Manual
>
```sudo```                                           
>Superusuário
>
```cd```                                             
>Navegar por diretórios
>
```ls```                                             
>Listar o que está contido no diretório
>
```cp```                                             
>Copiar
>
```mv```                                             
>Mover
>
```mkdir```                                          
>Criar uma pasta
>
```free```                                           
>Consultar RAM
>
```pstree```                                         
>Exibe uma árvore de processos do sistema
>
```top```                                            
>Exibe as tarefas Linux que mais utilizam a CPU
>
```neofetch```                                       
>Informações do sistema
>
```history```                                        
>Histórico de comandos
>
```TAB```                                            
>Sugestões para terminar uma palavra
>
```ifconfig```                                       
>dispositivos internet
>
```wget arq```                                       
>Faz o download do arquivo “arq” (substituir a variável arq pelo endereço online do arquivo)
>
```dpkg -i pacote.deb```                             
>Instala um pacote DEB (distros Debian) (substituir a variável pacote.deb pelo nome do pacote de programa)
>
```dpkg -l```                                        
>Exibe todos os pacotes deb instalados no sistema
>
```uname -a -m -r```                               
>Informações do PC/Kernel
>
```mount /*```                                   
>Montar partição
>
```fsck /dev/hda*```                                 
>Repara/verificar a integridade do arquivo do sistema Linux no disco hda*
>
```xkill```                                          
>Mata uma janela
>
```clear```                                          
>Limpa a tela do terminal
>
```hddtemp```                                        
>Temperatura do HD
>
```badblocks```                                      
>Procura por blocos ruins em um dispositivo, geralmente uma partição de disco
>
```fdisk -l```                                       
>Listar partições
>
```blkid  ou  ls -al /dev/disk/by-uuid/```           
>Ver UUID
>
```sudo vnstat -i wlp0s20f0u3 -*```                  
> - d: Daily statistics for the last 30 days.
> - m: Monthly statistics for the past 12 months.
> - w: Statistics for the last 7 days, and the current and previous week.
> - h: Hourly statistics for the last 24 hours.
> - t: Top 10 days with the highest traffic.
