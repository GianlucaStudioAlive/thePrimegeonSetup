#!/bin/bash
# Dotfiles install script
# Uso: git clone <repo> ~/dotfiles && cd ~/dotfiles && ./install.sh

set -e

DOTFILES="$HOME/dotfiles"

echo "=== Dotfiles Installer ==="
echo ""

# --- Pacchetti base ---
echo "[1/6] Installazione pacchetti..."
sudo apt update -qq
sudo apt install -y \
  zsh \
  kitty \
  tmux \
  neovim \
  ripgrep \
  fzf \
  fd-find \
  neofetch \
  btop \
  curl \
  git \
  unzip \
  build-essential

# --- Oh My Zsh ---
echo "[2/6] Oh My Zsh + Powerlevel10k..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
fi

# --- Symlinks ---
echo "[3/6] Creazione symlinks..."

# Funzione per creare symlink sicuri (backup se esiste già)
link() {
  local src="$1"
  local dst="$2"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "  Backup: $dst -> ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi
  rm -f "$dst"
  ln -sf "$src" "$dst"
  echo "  Link: $dst -> $src"
}

# Shell
link "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
link "$DOTFILES/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
link "$DOTFILES/bash/.bashrc" "$HOME/.bashrc"
link "$DOTFILES/bash/.profile" "$HOME/.profile"

# Tmux
link "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Kitty
mkdir -p "$HOME/.config/kitty"
link "$DOTFILES/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
rm -rf "$HOME/.config/kitty/themes"
link "$DOTFILES/kitty/themes" "$HOME/.config/kitty/themes"

# Neovim
link "$DOTFILES/nvim" "$HOME/.config/nvim"

# Git
link "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"

# Neofetch
mkdir -p "$HOME/.config/neofetch"
link "$DOTFILES/neofetch/config.conf" "$HOME/.config/neofetch/config.conf"

# Script custom
mkdir -p "$HOME/.local/bin"
link "$DOTFILES/scripts/kitty-theme" "$HOME/.local/bin/kitty-theme"
link "$DOTFILES/scripts/tmux-sessionizer" "$HOME/.local/bin/tmux-sessionizer"
chmod +x "$HOME/.local/bin/kitty-theme" "$HOME/.local/bin/tmux-sessionizer"

# fd symlink (fd-find -> fd)
if command -v fdfind &>/dev/null && [ ! -e "$HOME/.local/bin/fd" ]; then
  ln -sf "$(which fdfind)" "$HOME/.local/bin/fd"
fi

# --- TPM (Tmux Plugin Manager) ---
echo "[4/6] Tmux Plugin Manager..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# --- NVM + Node ---
echo "[5/6] NVM + Node.js..."
if [ ! -d "$HOME/.nvm" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  nvm install --lts
fi

# --- Zsh come shell default ---
echo "[6/6] Impostazione zsh come shell default..."
if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s "$(which zsh)"
  echo "  Shell cambiata in zsh (effettiva al prossimo login)"
fi

echo ""
echo "=== Installazione completata! ==="
echo ""
echo "Prossimi passi:"
echo "  1. Riavvia il terminale (o fai logout/login)"
echo "  2. Apri nvim per installare i plugin automaticamente (Lazy.nvim)"
echo "  3. In tmux, premi Ctrl+a + I per installare i plugin TPM"
echo "  4. Configura git: git config --global user.name/email se necessario"
