# Script-d-num-ration-Privilege-Escalation-pour-Linux

Description
Ce script Bash automatise l'énumération de possibles vecteurs d'élévation de privilèges sur des systèmes Linux en téléchargeant et en exécutant plusieurs scripts populaires d'énumération. Il analyse ensuite les résultats et permet de les consulter via un menu interactif. Le script est conçu pour être exécuté par un utilisateur ayant des privilèges sudo afin de vérifier la possibilité d'escalader les privilèges sur une machine cible.

Fonctionnalités :
Téléchargement et exécution de scripts d'énumération populaires (linux-exploit-suggester, LinPeas, LinEnum).
Visualisation des résultats sous forme de logs.
Analyse interactive des résultats avec un résumé global.
Interface interactive en ligne de commande avec un menu facile à utiliser.
Linux (Ubuntu, Debian, CentOS, ou autres distributions basées sur Unix).
Accès sudo pour pouvoir exécuter certaines commandes en tant qu'administrateur.
Internet pour télécharger les scripts d'énumération à partir de leurs dépôts GitHub respectifs.
Installation
Clonez ce repository ou téléchargez le script :

bash
Copy
Edit
git clone https://github.com/Jka667/Script-d-num-ration-Privilege-Escalation-pour-Linux
Donnez les permissions d'exécution au script :

bash
Copy
Edit
chmod +x enum_script.sh
Exécutez le script avec sudo :

bash
Copy
Edit
sudo ./enum_script.sh
Fonctionnement
1. Vérification des privilèges sudo
Le script commence par vérifier que vous disposez des privilèges nécessaires pour exécuter les commandes avec sudo. Il vous demandera votre mot de passe sudo pour pouvoir continuer.

2. Téléchargement et exécution des scripts d'énumération
Le script télécharge les trois scripts suivants à partir de leurs dépôts GitHub respectifs et les exécute pour collecter des informations sur des potentielles vulnérabilités d'escalade de privilèges :

Linux Exploit Suggester : Suggère des exploits potentiels en fonction de la version du noyau.
LinPeas : Un script d'énumération complet qui analyse les failles potentielles liées aux privilèges.
LinEnum : Un autre script d'énumération qui analyse les mauvaises configurations et les vulnérabilités du système.
Les résultats de chaque script sont sauvegardés dans le dossier enum_results sous forme de fichiers .log.

3. Menu d'analyse des résultats
Une fois les scripts exécutés, vous pouvez utiliser un menu interactif pour :

Afficher les résultats d'un script spécifique.
Consulter un résumé global des résultats dans le fichier final_summary.txt.
Retourner au menu principal.
