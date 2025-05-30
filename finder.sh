#!/bin/bash
base_url="http://10.13.200.219/.hidden"

# Fonction pour extraire les noms de dossiers depuis le HTML
get_folders() {
    local url="$1"
    curl -s "$url/" 2>/dev/null | grep -oP '<a href="\K[^"/]+(?=/")' | grep -v '^\.\.$'
}

# Fonction pour vérifier un README
check_readme() {
    local url="$1"
    local content=$(curl -s "$url/README" 2>/dev/null)
    
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
    
    echo "🔍 Exploration niveau $level: $path"
    
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