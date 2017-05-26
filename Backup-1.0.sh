#!/bin/bash
# Backup para redes com roteadores e rádios mikrotik e ubiquiti
# O script usa o SSH + SSHPASS + chave RSA
# Autor: Alessandro Almeida
# E-mail: alessandro@hostbyte.com.br
# Telefones: (53) 99989-0848
# Website: https://www.hostbyte.com.br
# Criado em: 27/02/2016

# Arquivo de texto com a lista de ips dos roteadores
IPS_MIKROTIK="ips_mikrotik.txt"

# Arquivo de texto criado com a lista de ips dos roteadores ativos.
BACKUPS_MIKROTIK="Mikrotik/backups_mikrotik.txt"

# Diretório dos backups mikrotik
DIRETORIO_MIKROTIK="Mikrotik"

# Checa a lista de ips dos roteadores mikrotik.
# Teste via ping para verificar se o roteador esta respondendo.
# Se o roteador responder, mostra mensagem de "Online"
# Escreve o ip no arquivo "backups_mikrotik.txt"
echo "Checando Roteadores Mikrotik Online"
echo "Gravando ip dos roteadores ativos"
for Mikrotik in $( cat $IPS_MIKROTIK )
do
ping -q -c2 $Mikrotik > /dev/null

if [ $? -eq 0 ]
then
echo $Mikrotik "Online"
echo $Mikrotik >> $BACKUPS_MIKROTIK
else
echo $Mikrotik "Offline"
fi
done

# Backup dos routers mikrotik
echo "Efetuando backups dos roteadores ativos"
sleep 2
echo "Roteadores Mikrotik"
sleep 2
echo "Aguarde..."
sleep 2

# Dados de acesso aos roteadores mikrotik.
echo "Lendo dados de acesso aos roteadores mikrotik"
sleep 2
usuario_mikrotik="seu_usuario"
senha_mikrotik="sua_senha"

# Comando para gerar o backup do roteador
sleep 2
backup_mikrotik="export"

echo "Lendo a lista de ips dos roteadores"
sleep 2
for mikrotik in $(cat $BACKUPS_MIKROTIK); do

echo "Acessando o roteador $mikrotik e efetuando o backup"
sleep 2
sshpass -p $senha_mikrotik ssh $mikrotik -l $usuario_mikrotik $backup_mikrotik > backup-$mikrotik.rsc
done

echo "Criando diretório de backup com data e hora da execução"
sleep 2
Data=$(date +%Y-%m-%d-%HH-%MM)
mkdir $DIRETORIO_MIKROTIK/"$Data"

echo "Sincronizando os arquivos de backup com seu diretório"
sleep 2
rsync -av *.rsc $DIRETORIO_MIKROTIK/"$Data"

echo "Removendo arquivos de backups com mais de uma semana armazenados"
sleep 2
find $DIRETORIO_MIKROTIK/ -ctime +7 -exec rm -rf {} \;

echo "Limpando arquivos de backup do diretório de execução"
sleep 2
rm -rf *.rsc
rm -rf $BACKUPS_MIKROTIK

# Arquivo de texto com a lista de ips dos rádios
IPS_UBIQUITI="ips_ubiquiti.txt"

# Arquivo de texto criado com a lista de ips dos rádios ativos.
BACKUPS_UBIQUITI="Ubiquiti/backups_ubiquiti.txt"

# Diretório dos backups mikrotik
DIRETORIO_UBIQUITI="Ubiquiti"

# Checa a lista de ips dos rádios ubiquit.
# Teste via ping para verificar se o rádio esta respondendo.
# Se o rádio responder, mostra mensagem de "Online"
# Escreve o ip no arquivo "ips_ubiquiti.txt"
echo "Checando Rádios Ubiquiti Online"
echo "Gravando ip dos rádios ativos"
for Ubiquiti in $( cat $IPS_UBIQUITI )
do
ping -q -c2 $Ubiquiti > /dev/null

if [ $? -eq 0 ]
then
echo $Ubiquiti "Online"
echo $Ubiquiti >> $BACKUPS_UBIQUITI 
else
echo $Ubiquiti "Offline"
fi
done

# Backup dos rádios ubiquiti
echo "Efetuando backups dos rádios ativos"
sleep 2
echo "Rádios Ubiquiti"
sleep 2
echo "Aguarde..."
sleep 2

# Dados de acesso aos rádios ubiquiti.
echo "Lendo dados de acesso aos rádios"
sleep 2
usuario_ubiquiti="seu_usuario"
senha_ubiquiti="sua_senha"

echo "Executando o backup ( system.cfg ) do rádio $ubiquiti"
sleep 2
backup_ubiquiti="cat /tmp/system.cfg"

echo "Lendo lista de ips dos rádios"
sleep 2
for ubiquiti in $(cat $BACKUPS_UBIQUITI); do

echo "Acessando o rádio $ubiquiti e efetuando o backup"
sleep 2
sshpass -p $senha_ubiquiti ssh $ubiquiti -l $usuario_ubiquiti $backup_ubiquiti > backup-$ubiquiti.cfg
done

echo "Criando diretório de backup com data e hora da execução"
sleep 2
Data=$(date +%Y-%m-%d-%HH-%MM)
mkdir $DIRETORIO_UBIQUITI/"$Data"

echo "Sincronizando os arquivos de backup com seu diretório"
sleep 2
rsync -av *.cfg $DIRETORIO_UBIQUITI/"$Data"

echo "Removendo arquivos de backups com mais de uma semana armazenados"
sleep 2
find $DIRETORIO_UBIQUITI/ -ctime +7 -exec rm -rf {} \;

echo "Limpando arquivos de backup do diretório de execução"
sleep 2
rm -rf *.cfg
rm -rf $BACKUPS_UBIQUITI

echo "Backups realizados com sucesso!"
sleep 2
clear
sleep 10
echo "Saindo"
sleep 5
exit
