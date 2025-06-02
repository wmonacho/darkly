#!/bin/bash
base_url="http://10.13.200.219/.hidden"

# Fonction pour extraire les noms de dossiers depuis le HTML
get_folders() {
    local url="$1"
    # Le curl va nous permettre de recuperer tous les noms de dossier 
    # -oP : Affiche uniquement la partie expression du grep en expression reguliere Pearl
    # \K : enleve tout ce qu'il y a avant
    # [^"/]+ prend tous les caracteres sauf " et / une ou plusieurs fois (+)
    # (?=/") verifie que la suite comporte un /" sans le grep
    # gerp -v '^\.\.$' enleve la ligne .. 
    curl -s "$url/" | grep -oP '<a href="\K[^"/]+(?=/\")' | grep -v '^\.\.$'
}

# Fonction pour vérifier un README
check_readme() {
    local url="$1"
    # recupere le contenu du readme en cours d'analyse
    local content=$(curl -s "$url/README" 2>/dev/null)
    
    # readme non vide (-n) et contient un chiffre
    if [ -n "$content" ] && [[ "$content" =~ [0-9] ]]; then
        echo "🎯 FLAG TROUVÉ dans $url:"
        echo "$content"
        exit 0
    fi
}

# Fonction récursive d'exploration
explore_dir() {
    local current_url="$1"
    local path="$2"
    local level="$3"
    
    if [ "$level" -gt 4 ]; then
        return
    fi
    
    # Vérifier le README à ce niveau
    check_readme "$current_url"
    
    # Récupérer les sous-dossiers
    local folders=$(get_folders "$current_url")
    
    # Explorer chaque sous-dossier
    for folder in $folders; do
        if [ -n "$folder" ]; then
            new_path="$path/$folder"
            new_url="$current_url/$folder"
            explore_dir "$new_url" "$new_path" $((level + 1))
        fi
    done
}

echo "🔍 Recherche du flag..."
explore_dir "$base_url" ".hidden" 0
echo "❌ Recherche terminée, aucun flag trouvé"