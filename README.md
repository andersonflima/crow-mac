# crow-mac

Roteiro para reconstruir a base de desenvolvimento em um Mac Apple Silicon recém-formatado. O Brewfile instala ferramentas de terminal, linguagens, aplicativos, extensões do VS Code e pacotes globais. O arquivo fish_plugins guarda a seleção de plugins do shell. O download da base usa fontes públicas.

## 1. Preparar o macOS

No Terminal, execute `xcode-select --install` e aguarde a instalação das ferramentas de linha de comando. Instale o Homebrew seguindo [as instruções oficiais](https://brew.sh/). Abra um terminal novo e confira que `brew --version` funciona. Em Apple Silicon, se o comando ainda estiver fora do PATH, siga o passo de shellenv exibido pelo instalador.

## 2. Instalar as dependências

Execute os comandos no zsh da instalação nova. O primeiro clone pressupõe que a pasta de destino esteja livre.

```sh
mkdir -p "$HOME/.ghq/github.com/andersonflima"
git clone https://github.com/andersonflima/crow-mac.git "$HOME/.ghq/github.com/andersonflima/crow-mac"
cd "$HOME/.ghq/github.com/andersonflima/crow-mac"
brew bundle install --file=Brewfile
brew bundle check --file=Brewfile
```

As entradas brew e cask cobrem ferramentas e aplicativos. As entradas vscode, npm, go e cargo cobrem extensões e utilitários instalados pelos respectivos gerenciadores. Entre os componentes estão Fish, Starship, tmux, Neovim, Node, Go, Rust, Ghostty, Docker Desktop e Karabiner. Serviços externos podem solicitar login quando você decidir usá-los. Reexecutar o bundle permite retomar uma instalação interrompida. O manifesto acompanha as versões disponíveis nos repositórios dos pacotes.

## 3. Configurar o Fish

Na pasta do clone, instale o Fisher e aplique o manifesto no perfil novo:

```sh
mkdir -p "$HOME/.config/fish"
fish -c 'curl -fsSL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source; and fisher install jorgebucaran/fisher'
cp fish_plugins "$HOME/.config/fish/fish_plugins"
fish -c 'fisher update; and fisher list'
```

A lista inclui Fisher, z para navegar entre diretórios, Shellder, Tide v5 e Catppuccin. O comando de cópia substitui a lista de plugins do perfil. O Starship também está disponível no Brewfile. Para adotá-lo como prompt, inclua `starship init fish | source` ao fim do seu config.fish.

Para usar Fish como shell de login em Apple Silicon, rode os comandos abaixo no zsh e abra uma nova sessão:

```sh
fish_path="$(brew --prefix)/bin/fish"
grep -Fxq "$fish_path" /etc/shells || echo "$fish_path" | sudo tee -a /etc/shells
chsh -s "$fish_path"
```

## 4. Neovim e tmux

Para usar a configuração pública do editor em uma máquina nova:

```sh
git clone https://github.com/andersonflima/crow-nvim.git "$HOME/.ghq/github.com/andersonflima/crow-nvim"
mkdir -p "$HOME/.config"
ln -s "$HOME/.ghq/github.com/andersonflima/crow-nvim" "$HOME/.config/nvim"
nvim
```

Crie o link apenas quando o caminho de destino estiver livre. No Neovim, abra `:Lazy` para acompanhar o download e `:checkhealth` para conferir as dependências. O tmux já pode ser iniciado com `tmux`. Para um perfil com plugins, o [TPM](https://github.com/tmux-plugins/tpm) gerencia tmux-sensible e Catppuccin.

## Conferência final

Abra o Ghostty e execute `fish --version`, `tmux -V`, `nvim --version` e `node --version`. Confira a lista de plugins com `fish -c 'fisher list'`. Permissões de Acessibilidade do Karabiner e o primeiro início do Docker Desktop são etapas interativas do macOS.
