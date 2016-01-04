#Criado por Adler Parnas <adler.parnas@doisdeum.com.br>   #
#                                                         #
# 2011-02-23                                              #
#                                                         #
# Adaptado por Lauro Guedes <leowgweb.com>                #
# E adaptado para mac por Rodrigo Rocha <freelex.com.br>                                                        #
# 2016-01-04                                              #
###########################################################
#                                                         #
# Script para criar um virtual host no apache e adicionar #
# o nome do host no arquivo hosts                         #
#                                                         #
###########################################################
#!/bin/bash

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
