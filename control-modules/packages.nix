{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  home = {
    packages = with pkgs; [
      # System, fonts, etc.
      nerd-fonts.fira-code
      nerd-fonts.hack

      # Misc. TUIs and CLIs
      tree
      eza
      bat
      kubectl
      talosctl
      fluxcd
      lazygit
      lazydocker
      awscli2
      yazi
      jfrog-cli
      minicom
      yq-go
      jsonnet
      delta
    ];
    shellAliases = {
      la = "eza -a --icons";
      ll = "eza -lah --icons";
      ls = "eza --color=auto";
      cat = "bat";
      repos = "cd ~/Documents/repos; ls";
    };
    sessionPath = [
      "$HOME/.config/zsh"
      "$HOME/.local/bin"
    ];
    sessionVariables = {
      VISUAL = "hx";
      KUBECONFIG = "$HOME/.kube/config";
    };
  };
  programs = {
    git = {
      enable = true;
      settings = {
        user.email = "tahoeschrader@gmail.com";
        user.name = "Tahoe Schrader";
      };
    };
    helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        theme = "base16_transparent";
        editor = {
          file-picker = {
            hidden = false;
          };
          statusline = {
            right = [
              "diagnostics"
              "selections"
              "position"
              "file-encoding"
              "file-line-ending"
              "file-type"
              "total-line-numbers"
            ];
          };
        };
      };
      languages = {
        language = [
          {
            name = "python";
            language-servers = ["pyright"];
          }
        ];
      };
      extraPackages = with pkgs; [
        pyright
        lldb
        nil
        marksman
        dockerfile-language-server
        docker-compose-language-service
      ];
    };
    starship = {
      enable = true;
      settings = {
        kubernetes.disabled = false;
      };
    };
    vim = {
      enable = true;
      settings = {ignorecase = true;};
      extraConfig = ''
        set mouse=a
        set nocompatible
        syntax on
        set number
        set laststatus=2
        set encoding=utf-8
        set autoindent expandtab smarttab tabstop=2 shiftwidth=2 softtabstop=-1
        set cursorline
        autocmd InsertEnter * set nocursorline
        autocmd InsertLeave * set cursorline
      '';
    };
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
    };
    uv = {
      enable = true;
    };
  };
}
