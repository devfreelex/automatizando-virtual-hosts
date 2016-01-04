Cansado de ficar configurando repetitivamente virtualhosts no seu MAC OS X YEOSEMIT. Pois bem, esse mini tutorial trata de te ajudar a resolver isso.

Uma das vantagens de utilizar virtualhosts é a organização do ambiente de desenvolvimento e após seguir os passos que vem adiante, configurar um vhost se tornará extremamente rápido e você poderá produzir muito mais se livrando dessa tarefa que as vezes pode ser bem chatinha.

Esse tutorial foi adaptado pelo LEO WG aqui http://tableless.com.br/como-automatizar-criacao-de-virtual-hosts/ e eu fiz pequenas modificações para que fosse possível executar o que era para linux no MAC.

Vamos ao tutorial…


Esse pequeno código automatiza a criação do vhost exigindo apenas 2 informações que são usuario da máquina (login) e local do app que está desenvolvendo.

<--Inicio do código-->

echo "Informe o novo domínio (Ex.: siteexemplo) :"
read vhost
 
echo "Informe o local (Ex.: /var/www/sitexemplo) :"
read path
 
echo "Criando configuração de VHost para o servidor"

#aqui é criado o arquivo de virtual host para o domínio e 
#é feita a escrita das configurações no arquivo
echo "<VirtualHost *:80>
    	ServerAdmin logindo_@_usuario.com.br
    	ServerName $vhost
    	ServerAlias www.$vhost 
    	DocumentRoot /Users/rrocha03/Sites/$path
   	 <Directory /Users/rrocha03/Sites/$path/>
       		Options Indexes FollowSymLinks MultiViews
        	AllowOverride All
        	Order allow,deny
        	Allow from all
    	 </Directory>
</VirtualHost>" >> /private/etc/apache2/extra/httpd-vhosts.conf

#ativa-se o o virtual host para que o serviço possa reconhecê-lo
echo "Ativando VHOST $vhost"
#a2ensite $vhost.conf

#escreve no arquivo de hosts do linux
echo "Atualizando arquivo hosts"
echo "127.0.0.1     $vhost www.$vhost" >> /etc/hosts

#renicia-se o servidor apache para aplicar as configurações
echo "Reiniciando apache"
sudo /usr/sbin/apachectl restart
echo "Apache reiniciado"
 
echo "VHOST criado";



<--FIM DO CÓDIGO -->

Os commandos echo e read são commandos de escrita e leitura respectivamente e servem para interagir com você e solicitar e gravar os dados necessários para a criação do host.

Observe que vhost e path são variáveis que vão captar os dados de domínio e local para a criação do host.

Para automatizar na sua máquina basta alterar algumas partes do código.

Na linha abaixo por exemplo deve ser substituido o logindo_@_usuario.com.br com o seu e-mail para obter as devidas permissões.

ServerAdmin login_do_@_usuario.com.br

Outras linhas que podem ser alteradas e que você deve informar o local de sua preferencia seguem abaixo.

DocumentRoot /Users/rrocha03/Sites/$path
<Directory /Users/rrocha03/Sites/$path/>




Esse caminho é o local onde o app vai ficar enquanto estiver em desenvolvimento e é a partir desse local que o virtualhost vai carregar a aplicação.

Observe que dentro do diretório de usuário local da máquina eu criei uma pasta Site e passei $path como complementp do caminho para que pudesse criar novos diretorios e também para evitar usar pastas de acesso restrito e ter que ficar digitando a senha de usuário a cada operação.

Caso queira entender melhor o que estou falando e se livrar desse problema também siga esse tutorial aqui: http://bazaglia.com/como-configurar-apache-php-e-mysql-no-os-x-yosemite/.
Esse tutorial mostra como configurar o apache de forma bem fácil e pode te ajudar a solucionar esse outro problema.
Deixo claro que a parte que interessa em nosso caso é a parte entitulada APACHE E PHP.

Voltando ao tutorial, como pode ver nas linhas abaixo,

</VirtualHost>" >> /private/etc/apache2/extra/httpd-vhosts.conf 
echo "127.0.0.1     $vhost www.$vhost" >> /etc/hosts

os arquivos httpd-vhosts.conf e hosts que serão alterados em suas pastas mantendo o que já existe neles. Por isso, antes de executar o código aqui presente aconcelho a fazer o backup desses arquivos, pois, é bem provável que você já tenha vhosts configurados e perde-los pode ser uma dor de cabeça.

Agora salve o arquivo com o nome geravhost.sh dentro do diretório /usr/local/bin.

Bem, se você seguiu corretamente o tutorial, então já pode executar o código e criar o vhost que precisa diretamente do bash. Para isso, basta digitar geravhost.sh e dar enter.





