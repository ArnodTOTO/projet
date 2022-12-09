# projet
Ce script permet d'executer des commandes telsque nmap, gobuster, sqlmap, etc...
Cependant, l'utilisation de ses commandes a quelle peu changer due à l'utilisation des variables c'est à dire qu'au lieu utiliser directement la cible, on mets la cible dans une variable.

# Installation
Afin de pouvoir utiliser le script, il est nécéssaire d'installer les paquets suivantes:

apt install figlet

apt install lolcat

# Usage

$ ./projet.sh

[]> help

option:

    help)       permet d'afficher l'aide

    set)        permet de définir des variables

    show)       permet d'afficher la valeur des variables

    list)       permet d'afficher les outils supportés et savoir s'ils sont installés ou pas

    install)    permet d'installer les outils supportés non installé

    exec)       permet d'executer des commandes

    exit)       permet de quitter le programme


# Exemple
./projet.sh

[]> set target 127.0.0.1

[]> show target

target = 127.0.0.1

[]> exec nmap -sV -sC target

Starting Nmap 7.92 ( https://nmap.org ) at 2022-12-09 01:11 CET

Nmap scan report for localhost (127.0.0.1)

Host is up (0.00016s latency).

All 1000 scanned ports on localhost (127.0.0.1) are in ignored states.

Not shown: 1000 closed tcp ports (conn-refused)


Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .

Nmap done: 1 IP address (1 host up) scanned in 1.38 seconds

zsh: segmentation fault  nmap -sV -sC 127.0.0.1



# Note
Avant d'utiliser ce script, assurez vous que la commande que vous voulez utiliser soit installer sur votre machine. Pour cela, vous pouvez utiliser la commande list. Ensuit installer le si nécéssaire avec la commande install.

