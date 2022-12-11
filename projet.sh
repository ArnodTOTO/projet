#!/bin/bash

#Définition des couleurs
noir='\e[0;30m'
gris='\e[1;30m'
rougefonce='\e[0;31m'
rougeclair='\e[1;31m'
vertfonce='\e[0;32m'
vertclair='\e[1;32m'
orangefonce='\e[0;33m'
orangeclair='\e[1;33m'
bleufonce='\e[0;34m'
bleuclair='\e[1;34m'
violetfonce='\e[0;35m'
violetclair='\e[1;35m'
cyanfonce='\e[0;36m'
cyanclair='\e[1;36m'
grisclair='\e[0;37m'
blanc='\e[1;37m'
clignotant='\e[5;05m'

neutre='\e[0;m'

Title=$(figlet "ST4RTING")
date=$(date +%F)
heure=$(date +%X)

echo -e "${clignotant}$Title" | lolcat -F 0.6
echo''
echo "[*] starting @ $heure /$date/" | lolcat -F 0.6
echo''

My_Shell='[]> '

#Fonction Usage
Usage() {
   cat <<EOT
Description:
	Ce projet consiste à créer un script interactif qui permet executer des commandes
	pour l'analyse de système et l'exploitation des vulnérabilités des systèmes.
 
usage: ./projet.sh		#Lancer le script
	set [variable] value	#Configurer les variables
	show [variable]		#Afficher la valeur des variable
	list			#Lister les outils supportés et déjà installés
	install			#Installer les commandes
	
	exec [commande]		#Execution des commandes
	Example: exec nmap -sV -sC target
	
Options:
	help, --help		Afficher de l'aide
	exit, --quit 		Quitter le programme

Variable:
	target			#Désigner une machine cible
	port			#Désigner le port
	wordlist		#Désigner une wordlist
	username		#Désigner un username
	password		#Désigner un password
	username_list		#Désigner une liste d'username
	extension		#Désigner une extension de fichier
	url			#Préciser un url
	mode			#Préciser le mode de hash. Par example MD5 mode = 0 
	attack_mode		#Préciser le type d'attaque
	hash			#Définir un hash dans un fichier
	threads			#Définir les threads
	level			#Définir le niveau de level
	risk			#Définir le niveau de risque
Commande:
	gobuster 		#Outil d'énumération de fichier et DNS
	dirbuster		#IDEM
	dirb			#IDEM
	sqlmap			#Outil de detection et d'exploitation des failles d'injection slq et de prise en charge des serveurs de base de données
	nmap			#Outil pour scanner les port et identifier les services hébergés et obtenir des informations sur un système d'exploitation d'un ordinateur distant
	hydra			#Brute force de login
	john			#Brute force de hash
	hashcat			#IDEM

[!] si la commande n'est pas installé.  il est nécéssaire de l'installé afin de pouvoir l'utiliser grâce à la commande install.
Exemple: install gobuster

EOT
}

#Fonction List
List() {
echo "L'outil supporté:"
for outil in "gobuster" "nmap" "dirbuster" "dirb" "hydra" "john" "sqlmap" "hashcat" ;
        do
		which "$outil" >/dev/null	#which permet de vérifier si la commande  exist
		i=$(echo $?)
                if [ "$i" = "0" ]; then
                        echo -e "	${bleuclair}[+]	$outil${neutre}"
                else
                        echo -e "	${rougeclair}[-]	$outil${neutre}"
                fi
        done
cat <<EOT

Note:
        [+]     déjà installé
        [-]     non installé
EOT


}

while :
	do
		echo -n -e "${bleuclair}$My_Shell${neutre}"
		read arg1 arg2 arg3			#récupération des saisis de l'utilisateur 

		#Fonction Install
		Install() {
		erreur_install=
		n=0
                for r in "gobuster" "dirb" "john" "dirbuster" "nmap" "hashcat" "sqlmap" "hydra";
                        do
                                if [ "$arg2" = "$r" ]; then
					eval "sudo apt install $arg2"
					break
				else
					let "n += 1"
					if [ "$n" = "8" ]; then
						echo -e "Command not supported : ${orangeclair}$arg2${neutre}"
					fi
				fi
                        done
                }

		#Fonction Set
		Set() {
                y=0
                for variable in "target" "port" "wordlist" "username" "password" "username_list" "extension" "url" "mode" "attack_mode" "hash" "threads" "level" "risk";
                        do
                                if [ "$arg2" = "$variable" ]; then
                                        let "y += 1"
                                        if [ "$y" = "1" ]; then
						if [[ "$arg3" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then		#vérification de l'ip
                                                	t="$arg3"
						else
							echo "Your ip is incorrect"
						fi
                                        elif [ "$y" = "2" ]; then
						p="$arg3"
                                        elif [ "$y" = "3" ]; then
						if [ ! -f "$arg3" ]; then			#vérification de fichier
                                                        echo "Your file does not exist"
						else
                                                	w="$arg3"
						fi
                                        elif [ "$y" = "4" ]; then
                                                u="$arg3"
                                        elif [ "$y" = "5" ]; then
                                                s="$arg3"
                                        elif [ "$y" = "6" ]; then
						if [ ! -f "$arg3" ]; then
                                                        echo "Your file does not exist"
						else
                                                	l="$arg3"
						fi
                                        elif [ "$y" = "7" ]; then
                                                e="$arg3"
					elif [ "$y" = "8" ]; then
						U="$arg3"
					elif [ "$y" = "9" ]; then
						m="$arg3"
					elif [ "$y" = "10" ]; then
						a="$arg3"
					elif [ "$y" = "11" ]; then
						if [ ! -f "$arg3" ]; then
                                                        echo "Your file does not exist"
						else
							h="$arg3"
						fi
					elif [ "$y" = "12" ]; then
						if (( "$arg3" < 1 || "$arg3" > 100 )); then
							echo "Erreur: Argument not valide, Please enter 1-100"
						else
							T="$arg3"
						fi
                                        elif [ "$y" = "13" ]; then
                                                if (( "$arg3" < 1 || "$arg3" > 5 )); then
                                                        echo "Erreur: Argument not valide, Please enter 1-5"
                                                else
                                                        L="$arg3"
                                                fi
					else
                                                if (( "$arg3" < 1 || "$arg3" > 3 )); then
                                                        echo "Erreur: Argument not valide, Please enter 1-3"
                                                else
                                                        R="$arg3"
                                                fi

					fi
                                        break
                                else
                                        let "y +=1"
                                        if [ "$y" = "14" ]; then
                                                echo -e "Argument is invalide : ${orangeclair}$arg2${neutre}"
                                        fi
                                fi
                        done
                }

		#définir les variables
                target="${t}"
                port="${p}"
                wordlist="${w}"
                username="${u}"
                password="${s}"
                username_list="${l}"
                extension="${e}"
		url="${U}"
		mode="${m}"
		attack_mode="${a}"
		hash="${h}"
		threads="${T}"
		level="${L}"
		risk="${R}"

		#Fonction Show
		Show() {
                b=0
                if [ "$arg2" = "" ]; then
                        cat  <<EOT
 target = ${target}
 port = ${port}
 wordlist = ${wordlist}
 username = ${username}
 password = ${password}
 username_list = ${username_list}
 extension = ${extension}
 url = ${url}
 mode = ${mode}
 attack_mode = ${attack_mode}
 hash = ${hash}
 threads = ${threads}
 level = ${level}
 risk = ${risk}
EOT
                else
                        for var in "target" "port" "wordlist" "username" "password" "username_list" "extension" "url" "mode" "attack_mode" "hash" "threads" "level" "risk";
                                do
                                        if [ "$arg2" = "$var" ]; then
                                                let "b += 1"
                                                if [ "$b" = "1" ]; then
                                                        echo "target = $target"
                                                elif [ "$b" = "2" ]; then
                                                        echo "port = $port"
                                                elif [ "$b" = "3"  ]; then
                                                        echo "wordlist = $wordlist"
                                                elif [ "$b" = "4" ]; then
                                                        echo "username = $username"
                                                elif [ "$b" = "5" ]; then
                                                        echo "password = $password"
                                                elif [ "$b" = "6" ]; then
                                                        echo "username_list = $username_list"
                                                elif [ "$b" = "7" ]; then
                                                        echo "extension  = $extension"
						elif [ "$b" = "8" ]; then
							echo "url = $url"
						elif [ "$b" = "9" ]; then
							echo "mode = $mode"
						elif [ "$b" = "10" ]; then
							echo "attack_mode = $attack_mode"
						elif [ "$b" = "11" ]; then
							echo "hash = $hash"
						elif [ "$b" = "12" ]; then
							echo "threads = $threads"
						elif [ "$b" = "13" ]; then
							echo "level = $level"
						else
							echo "risk = $risk"
                                                fi
                                                break
                                        else
                                                let "b += 1"
                                                if [ "$b" = "14" ]; then
                                                        echo -e "${orangeclair}$arg2:${neutre} Variable unkown"
                                                fi
                                        fi
                                done
                fi
}

		#Fonction Exec
		Exec() {
                case "$arg2" in
                        nmap)
		#Définition des options de nmap
                OPT_H=
		OPT_O=
                OPT_sV=
                OPT_sC=
		OPT_P=
		OPT_port=
                OPT_target=

                for i in $arg3; do
                        case "$i" in
                                -h|--help)      OPT_H="-h";;
				-O)		OPT_O="-O";;
                                -sV)    	OPT_sV="-sV";;
                                -sC)    	OPT_sC="-sC";;
				-p)		OPT_P="-p";;
				port)		OPT_port="$port";;
                                target) OPT_target="$target";;
				*)		echo -e "${orangeclair}$i:${neutre} Option not implemented ";;
                        esac
                done
                eval "nmap $OPT_H $OPT_O $OPT_sV $OPT_sC $OPT_P $OPT_port $OPT_target"			#execution de nmap
                ;;

        		gobuster)
		#Définition des options de gobuster
                OPT_H=
                OPT_dir=
                OPT_U=
                OPT_W=
                OPT_X=
                OPT_url=
                OPT_extension=
                OPT_wordlist=
                for j in $arg3; do
                        case "$j" in
                                -h|--help)      OPT_H="-h";;
                                dir)            OPT_dir="dir";;
                                -u)             OPT_U="-u";;
                                url)            OPT_url="$url";;
                                -w)             OPT_W="-w";;
                                wordlist)       OPT_wordlist="$wordlist";;
                                -x)             OPT_X="-x";;
                                extension)      OPT_extension="$extension";;
				*)		echo -e "${orangeclair}$i:${neutre} Option not implemented ";;
                        esac
                done
                eval "gobuster $OPT_H $OPT_dir $OPT_U $OPT_url $OPT_W $OPT_wordlist $OPT_X $OPT_extension"   #execution de gobuster
                ;;

                        sqlmap)
		#Définition des options de sqlmap
                OPT_H=
                OPT_U=
                OPT_url=
		OPT_batch=
		OPT_T=
		OPT_threads=
		OPT_L=
		OPT_level=
		OPT_R=
		OPT_risk=
                for g in $arg3;do
                        case "$g" in
                                -h|--help)      OPT_H="-h";;
                                -u)             OPT_U="-u";;
                                url)            OPT_url="$url";;
				--batch)	OPT_batch="--batch";;
				--threads)	OPT_T="--threads";;
				threads)	OPT_T="$threads";;
				--level)	OPT_L="--level";;
				level)		OPT_level="$level";;
				--risk)		OPT_R="--risk";;
				risk)		OPT_risk="$risk";;
				*)		echo -e "${orangeclair}$i:${neutre} Option not implemented ";;
                        esac
                done
                eval "sqlmap $OPT_H $OPT_U $OPT_url $OPT_batch $OPT_T $OPT_threads $OPT_L $OPT_level $OPT_R $OPT_risk"	#execution de sqlmap
                ;;

                        hashcat)
		#Définition des options de hashcat
                OPT_H=
                OPT_M=
                OPT_V=
                OPT_A=
                OPT_attack=
                OPT_mode=
                OPT_hash=
                OPT_wordlist=
                for f in $arg3; do
                        case "$f" in
                                -h|--help)      OPT_H="-h";;
                                -m)             OPT_M="-m";;
                                -v)             OPT_V="-v";;
                                -a)             OPT_A="-a";;
                                mode)           OPT_mode="$mode";;
                                hash)           OPT_hash="$hash";;
                                wordlist)       OPT_wordlist="$wordlist";;
                                attack_mode)    OPT_attack="$attack_mode";;
				*)		echo -e "${orangeclair}$i:${neutre} Option not implemented ";;
                        esac
                done
                eval "hashcat $OPT_H $OPT_M $OPT_mode $OPT_A $OPT_attack $OPT_hash $OPT_wordlist $OPT_V"	#execution de hashcat
                ;;

                        hydra)
		#Définition des options de hydra
                OPT_H=
                OPT_l=
                OPT_P=
                OPT_username=
                OPT_wordlist=
                OPT_U=
                OPT_url=
		OPT_V=
                for h in $arg3; do
                        case "$h" in
                                -h|--help)      OPT_H="-h";;
                                -l)             OPT_l="-l";;
                                -P)             OPT_P="-P";;
                                -u)             OPT_U="-u";;
				-v)		OPT_V="-v";;
                                username)       OPT_username="$username";;
                                wordlist)       OPT_wordlist="$wordlist";;
                                url)            OPT_url="$url";;
				*)		echo -e "${orangeclair}$i:${neutre} Option not implemented ";;
                        esac
                done
                eval " hydra $OPT_H $OPT_l $OPT_username $OPT_P $OPT_wordlist $OPT_U $OPT_url $OPT_V"		#execution de hydra
                ;;

			dirb)
		#Définition des options de dirb
		OPT_url=
		OPT_wordlist=
		OPT_X=
		OPT_W=
		OPT_extension=
		for c in $arg3; do
			case "$c" in
				url)		OPT_url="$url";;
				wordlist)	OPT_wordlist="$wordlist";;
				-X)		OPT_X="-X";;
				-w)		OPT_W="-w";;
				extension)	OPT_extension="$extension";;
				*)		echo -e "${orangeclair}$i:${neutre} Option not implemented ";;
			esac
		done
		eval "dirb $OPT_url $OPT_w $OPT_wordlist $OPT_X $OPT_extension "		#execution de dirb
		;;

                        *)      echo -e "Command not supported: ${orangeclair}$arg2" ;;
		esac
}

		case "$arg1" in
			exit|--quit)
				echo''
				echo "[*] ending @ $heure /$date/" | lolcat -F 0.6
				eval "exit";;
			help|--help)
				echo''
				Usage | lolcat;;
			install)	Install;;
			list)		List;;
			clear)		eval "clear";;
			show)		Show;;
			set)		Set;;
			exec)		Exec;;
			*)		echo -e "${orangeclair}$arg1:${neutre} unknown option";;
		esac
	done
exit 0

