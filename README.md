# Backups Provedor

Backups Rede Mikrotik e Ubiquiti

Script destinado a backups de roteadores e rádios mikrotik e ubiquiti

Backup efetuado via SSH usando chave RSA

Os arquivos de texto "ips_mikrotik.txt" e "ips_ubiquiti.txt" são destinados

a lista onde o usuário deve inserir seus respectivos ips que representam seus equipamentos na rede

Os arquivos de texto "backups_mikrotik.txt" e "backups_ubiquiti.txt", é uma lista de ips ativos que responderam a requisição icmp, onde sera consultado para efetuar o backup do roteador ou rádio

Resumindo o funcionamento do script, é executado um teste via ping para saber se o equipamento esta online, cada dispositivo que responder ao ping, seu ip vai para uma lista no qual o script verfica e executa o backup.

Backup do mikrotik é feito nada mais do que um "export" de todas as configurações, no caso dos equipamentos ubiquit
é executado um "cat /tmp/system.cfg" que é similar ao export do mikrotik. Isso ira gerar um arquivo com o nome de backup-ip_do_equipamento.rsc para mikrotik e backup-ip_do_equipamento.cfg para ubiquiti. Os arquivos gerados são
enviados para seus respectivos diretorios, que consistem em 2 pastas. Um diretorio para cada tipo de equipamento,
essas pastas são: Mikrotik e Ubiquiti que dentro delas contem os diretorios com os backups, todos os diretorios são
identificados por sua data e hora de execução do backup.

Equipamentos que não responderam a requisição de icmp, ficara fora da lista de backups

# Observação:
No script existem algumas variaveis a serem alteradas, exemplos:

( usuario_mikrotik="seu_usuario" ) ( senha_mikrotik="sua_senha" )

( usuario_ubiquiti="seu_usuario" ) ( senha_ubiquiti="sua_senha" )

Altere os dados de acordo com sua necessidade, inserindo seu usuario e senha corretamente

Sinta-se a vontade para modificar ou melhorar este script

Instale o "sshpass", confira alguns exemplos para instalação em algumas distros

# Debian/Ubuntu/Mint
$ sudo apt-get install sshpass

# CentOS/RedHat
$ sudo yum install sshpass

# Fedora
$ sudo dnf install sshpass

# Arch
$ sudo pacman -S sshpass

# OpenSuse
$ sudo zypper install sshpass

# Para gerar sua chave RSA, siga o exemplo abaixo:

$ ssh-keygen

Depois de gerar sua chave, importe a mesma para seus roteadores e rádios

Dica: antes de executar o script pela primeira vez, apos enviar a chave efetue o login via ssh manualmente ao menos umas vez.

A transferencia da chave pode ser feita via winbox para roteadores mikrotik e via browser para rádios ubiquiti

Para tranferir via linha de comando, basta usar o camando descrito abaixo:

$ scp id_rsa.pub seu_usuario@ip_destino:/destino_no_dispositivo
