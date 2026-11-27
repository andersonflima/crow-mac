# Perfil portátil; não depende de caminhos, contas ou serviços desta máquina.
if command -q nvim
    set -gx EDITOR nvim
end

if status is-interactive
    set -g fish_greeting ""
    set -g fish_prompt_pwd_dir_length 1
    set -g theme_color_scheme terminal-dark
    set -g theme_display_user yes
    set -g theme_hide_hostname no

    alias g git
    if command -q nvim
        alias vim nvim
    end
    if command -q lsd
        alias ls 'lsd -l -A'
        alias lt 'lsd -l -G --tree'
    end
    if command -q dotnet
        alias dnconsole 'dotnet new console -n'
        alias dnclasslib 'dotnet new classlib -o'
        alias dnwebapi 'dotnet new webapi -n'
        alias dncontroller 'dotnet new apicontroller -o'
        alias dnclass 'dotnet new class -o'
        alias dnsln 'dotnet new sln -o'
    end

    bind \ck up-or-search
    bind \cj down-or-search
    bind \ch backward-char
    bind \cl forward-char

    set -g fish_color_keyword FFFFFF --bold
    set -g fish_color_comment 6A6A6A --italics
    set -g fish_color_param A8A8A8
    set -g fish_color_operator FFFFFF
    set -g fish_color_redirection C6C6C6
    set -g fish_color_end FFFFFF
    set -g fish_color_error FFFFFF --bold
    set -g fish_color_autosuggestion 4A4A4A
    set -g fish_color_selection --background=2A2A2A
    set -g fish_color_search_match --background=2A2A2A
    set -g fish_pager_color_prefix FFFFFF --bold
    set -g fish_pager_color_completion A8A8A8
    set -g fish_pager_color_description 6A6A6A

    if command -q starship
        starship init fish | source
    end
end
