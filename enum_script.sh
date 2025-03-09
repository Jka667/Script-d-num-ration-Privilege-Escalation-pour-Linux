#!/bin/bash

# Définition des URLs des scripts d'énumération
declare -A ENUM_SCRIPTS=(
    [LES2]="https://raw.githubusercontent.com/The-Z-Labs/linux-exploit-suggester/master/linux-exploit-suggester.sh"
    [LinPeas]="https://raw.githubusercontent.com/carlospolop/privilege-escalation-awesome-scripts-suite/master/linPEAS/linpeas.sh"
    [LinEnum]="https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh"
)

RESULTS_DIR="$(pwd)/enum_results"
SUMMARY_FILE="$RESULTS_DIR/final_summary.txt"
mkdir -p "$RESULTS_DIR"

# Demande du mot de passe pour sudo -l
echo -e "\e[1;34m[+] Vérification des privilèges sudo...\e[0m"
sudo -v

# Fonction pour télécharger et exécuter un script
download_and_run() {
    local name=$1
    local url=$2
    local output="$RESULTS_DIR/${name}.log"
    
    echo -e "\e[1;32m[+] Téléchargement de $name...\e[0m"
    curl -s -L "$url" -o "$RESULTS_DIR/$name"
    chmod +x "$RESULTS_DIR/$name"
    
    echo -e "\e[1;32m[+] Exécution de $name...\e[0m"
    "$RESULTS_DIR/$name" > "$output" 2>&1
    echo -e "\e[1;32m[+] Résultats enregistrés dans $output\e[0m"
}

# Fonction pour afficher le résultat d'un script spécifique
display_results() {
    echo "\nSélectionnez un script pour voir ses résultats :"
    select script in "${!ENUM_SCRIPTS[@]}" "Résumé global" "Retour"; do
        case $script in
            "Résumé global")
                cat "$SUMMARY_FILE"
                break
                ;;
            "Retour")
                break
                ;;
            *)
                if [[ -n "$script" ]]; then
                    cat "$RESULTS_DIR/${script}.log"
                else
                    echo "Choix invalide."
                fi
                ;;

        esac
    done
}

# Fonction d'analyse des résultats pertinents
analyze_results() {
    while true; do
        clear
        echo "###############################"
        echo "#    Menu Analyse Résultats   #"
        echo "###############################"
        echo "1) Afficher un résultat spécifique"
        echo "2) Afficher l'analyse globale"
        echo "3) Retour au menu principal"
        read -p "Choix: " sub_choice
        
        case $sub_choice in
            1)
                display_results
                ;;

            2)
                cat "$SUMMARY_FILE"
                ;;

            3)
                return
                ;;

            *)
                echo "Choix invalide."
                ;;

        esac
        read -p "Appuyez sur Entrée pour continuer..."
    done
}

# Menu interactif avec la pyramide égyptienne agrandie
while true; do
    clear
    echo -e "\e[1;31m############################################\e[0m"
    echo -e "\e[1;33m#       Script d'Énumération Linux         #\e[0m"
    echo -e "\e[1;33m#        By Jonathan K. (Jka667)           #\e[0m"
    echo -e "\e[1;33m#        GitHub: https://github.com/Jka667 #\e[0m"
    echo -e "\e[1;31m############################################\e[0m"


echo -e "\e[1;31m                   /\ \e[0m"
echo -e "\e[1;31m                  /  \ \e[0m"
echo -e "\e[1;31m                 /    \ \e[0m"
echo -e "\e[1;31m                /      \ \e[0m"
echo -e "\e[1;31m               /        \ \e[0m"
echo -e "\e[1;31m              /          \ \e[0m"
echo -e "\e[1;31m            /              \ \e[0m"
echo -e "\e[1;31m           /________________\ \e[0m"
echo -e "\e[1;31m          ************************\e[0m"
echo -e "\e[1;31m         *  P  R  I  V  I  L  E  G  E  \e[0m"
echo -e "\e[1;31m         *  E  S  C  A  L  A  T  I  O  N  S  \e[0m"
echo -e "\e[1;31m         * ***********************************\e[0m"

    echo -e "\n1) Exécuter les scripts d'énumération"
    echo "2) Analyser les résultats"
    echo "3) Quitter"
    read -p "Choix: " choice
    case $choice in
        1)
            for name in "${!ENUM_SCRIPTS[@]}"; do
                download_and_run "$name" "${ENUM_SCRIPTS[$name]}"
            done
            ;;
        2)
            analyze_results
            ;;
        3)
            echo -e "\e[1;32m[+] Fin du script.\e[0m"
            exit 0
            ;;
        *)
            echo -e "\e[1;31m[!] Choix invalide.\e[0m"
            ;;
    esac
    read -p "Appuyez sur Entrée pour continuer..."
done
