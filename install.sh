#!/bin/bash

# colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${BLUE}📦 Installing gkey suite...${NC}"

OS_TYPE=$(uname -s)

case "${OS_TYPE}" in
    Linux*|Darwin*)
        echo "🍎/🐧 Detected Unix-like"
        BIN_DEST="/usr/local/bin"
        LIB_DEST="/usr/local/lib/gkey"
        sudo mkdir -p "$BIN_DEST"
        sudo mkdir -p "$LIB_DEST"
        SUDO="sudo"
        ;;
    CYGWIN*|MINGW*|MSYS*)
        echo "🪟 Detected Windows (Git Bash/MSYS)"
        # On Windows, we use the user's HOME directory to avoid permission issues.
        BIN_DEST="$HOME/bin"
        LIB_DEST="$HOME/.gkey/lib"
        mkdir -p "$BIN_DEST"
        mkdir -p "$LIB_DEST"
        SUDO=""
        ;;
    *)
        echo "Unsupported system: ${OS_TYPE}"
        exit 1
        ;;
esac
# Install library core
echo -e "⚙️ Installing gkey-core to ${GREEN}$LIB_DEST${NC}..."
$SUDO cp lib/gkey-core.sh "$LIB_DEST/"

# Set up shell aliases (ZSH o BASH)
# Detecting user shell configuration file
if [ -f "$HOME/.zshrc" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
elif [ -f "$HOME/.bashrc" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
fi

# Install executables and update their reference to the Core library.
for script in bin/*; do
    full_name=$(basename "$script")
    echo -e "🚀 Installing command: ${GREEN}$full_name${NC}..."
    filename=${full_name%.*}

    ROUTE="$BIN_DEST/$full_name"
    # Copiamos el script al destino
    $SUDO cp "$script" "$ROUTE"
    $SUDO chmod +x "$ROUTE"

    # Verificar si el alias ya existe para no duplicarlo
    if grep -q "alias $filename=" "$SHELL_CONFIG"; then
        echo -e "${GREEN} Alias was already configured in: $ROUTE.${NC}"
    else
        ALIAS="alias $filename='$ROUTE'"
        echo "$ALIAS" >> "$SHELL_CONFIG"
        echo -e "${GREEN} Alias added to $filename - $SHELL_CONFIG.${NC}"
    fi
done

if [[ "${OS_TYPE}" == *"MINGW"* ]]; then
    echo -e "${BLUE}💡 Windows Tip:${NC} Ensure that $BIN_DEST is in your PATH."
fi

echo -e "${GREEN}✅ ¡Installation complete!${NC}"
echo -e "To start using gkey, please ${BLUE}restart your terminal${NC} or run:"
echo -e "${CYAN}source $SHELL_CONFIG${NC}"