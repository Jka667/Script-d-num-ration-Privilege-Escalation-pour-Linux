#!/bin/bash

declare -A ENUM_SCRIPTS=(
    [LES2]="https://raw.githubusercontent.com/The-Z-Labs/linux-exploit-suggester/master/linux-exploit-suggester.sh"
    [LinPeas]="https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite/raw/master/linPEAS/linpeas.sh"
    [LinEnum]="https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh"
)

RESULTS_DIR="$(pwd)/enum_results"
SUMMARY_FILE="$RESULTS_DIR/final_summary.txt"
mkdir -p "$RESULTS_DIR"

print_banner() {
    echo -e "\e[1;33m"
    echo "╔════════════════════════════════════════╗"
    echo "║ 🛡️  Linux Enumeration Script 🛡️       ║"
    echo "║       By Jonathan K. (Jka667)           ║"
    echo "║   GitHub: https://github.com/Jka667    ║"
    echo "╚════════════════════════════════════════╝"
    echo -e "\e[0m"
}

echo -e "\e[1;34m🔐 Checking sudo privileges...\e[0m"
sudo -v

download_and_run() {
    local name=$1
    local url=$2
    local output="$RESULTS_DIR/${name}.log"

    echo -e "\e[1;32m⬇️  Downloading $name...\e[0m"
    curl -s -L "$url" -o "$RESULTS_DIR/$name"
    chmod +x "$RESULTS_DIR/$name"

    echo -e "\e[1;32m⚙️  Running $name...\e[0m"
    "$RESULTS_DIR/$name" > "$output" 2>&1
    echo -e "\e[1;32m✅ Results saved to $output\e[0m"
}

generate_summary() {
    echo -e "\e[1;35m📝 Generating filtered global summary in $SUMMARY_FILE...\e[0m"
    echo "==== Filtered Global Enumeration Summary ====" > "$SUMMARY_FILE"
    echo "Generated on $(date)" >> "$SUMMARY_FILE"
    echo >> "$SUMMARY_FILE"

    local keywords="sudo|kernel|exploit|vulnerab|version|root|user|privilege|permission|capabilities"

    for script in "${!ENUM_SCRIPTS[@]}"; do
        echo "----- $script summary -----" >> "$SUMMARY_FILE"

        # Show first 10 lines for context
        head -n 10 "$RESULTS_DIR/${script}.log" >> "$SUMMARY_FILE"
        echo "..." >> "$SUMMARY_FILE"

        # Extract lines matching keywords, unique, max 50 lines
        grep -iE "$keywords" "$RESULTS_DIR/${script}.log" | uniq | head -n 50 >> "$SUMMARY_FILE"
        echo >> "$SUMMARY_FILE"
    done
}

show_summary() {
    echo -e "\n\e[1;35m📋 ==== Global Summary ==== 📋\e[0m"
    if [[ -f "$SUMMARY_FILE" ]]; then
        cat "$SUMMARY_FILE"
    else
        echo "⚠️  No summary file found."
    fi
}

display_specific_results() {
    echo -e "\n📂 Available script results:"
    for script in "${!ENUM_SCRIPTS[@]}"; do
        echo "  🔹 $script"
    done
    echo "  🔹 back"

    while true; do
        read -rp "Type script name to display or 'back' to exit: " choice
        if [[ "$choice" == "back" ]]; then
            break
        elif [[ -n "${ENUM_SCRIPTS[$choice]}" ]]; then
            echo -e "\n📄 ==== Results for $choice ==== 📄"
            cat "$RESULTS_DIR/${choice}.log"
        else
            echo "❌ Invalid choice."
        fi
    done
}

print_banner

for name in "${!ENUM_SCRIPTS[@]}"; do
    download_and_run "$name" "${ENUM_SCRIPTS[$name]}"
done

generate_summary

echo -e "\n✅ All scripts executed."
show_summary

read -rp $'\nWould you like to view results for specific scripts? (y/N): ' ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    display_specific_results
fi

echo -e "\n👋 Script finished. Goodbye!"
