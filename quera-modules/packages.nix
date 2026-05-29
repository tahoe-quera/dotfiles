{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  home = {
    packages = with pkgs; [
      # System, fonts, etc.
      nerd-fonts.fira-code
      nerd-fonts.hack

      # programming
      jdk
      scala
      bun
      plantuml
      
      # Misc. TUIs and CLIs
      tree
      eza
      bat
      kubectl
      talosctl
      fluxcd
      graphviz
      lazygit
      lazydocker
      awscli2
      yazi
      jfrog-cli
      minicom
      yq-go
      jsonnet
      delta
      sops
      age
    ];
    shellAliases = {
      la = "eza -a --icons";
      ll = "eza -lah --icons";
      ls = "eza --color=auto";
      cat = "bat";
      repos = "cd ~/src; ls";
    };
    sessionPath = [
      "$HOME/.config/zsh"
      "$HOME/.local/bin"
      "$HOME/.cargo/bin"
    ];
    sessionVariables = {
      VISUAL = "hx";
      PATH = "${pkgs.graphviz}/bin:$PATH";
      PKG_CONFIG_PATH = "${pkgs.graphviz}/lib/pkgconfig:$PKG_CONFIG_PATH";
      C_INCLUDE_PATH = "${pkgs.graphviz}/include:$C_INCLUDE_PATH";
      LIBRARY_PATH = "${pkgs.graphviz}/lib:$LIBRARY_PATH";
      GRAPHVIZ_DOT = "${pkgs.graphviz}/bin/dot";
      KUBECONFIG = "$HOME/.kube/config:$HOME/.kube/tschrader.kubeconfig";
      GITHUB_USER = "tahoe-quera";
      GITHUB_TOKEN = "$(cat ~/.secrets/github-token)";
      UV_INDEX_JFROG_PASSWORD = "$(cat ~/.secrets/jfrog-token)";
      UV_INDEX_JFROG_USERNAME = "tschrader@quera.com";
      UV_INDEX_JFROGALGO_PASSWORD = "$(cat ~/.secrets/jfrog-algo-token)";
      UV_INDEX_JFROGALGO_USERNAME = "tschrader@quera.com";
      UV_INDEX_KIRIN_PASSWORD = "$(cat ~/.secrets/jfrog-kirin-token)";
      UV_INDEX_KIRIN_USERNAME = "tschrader@quera.com";
      FLUX_SYSTEM = "$(cat ~/.secrets/flux-system)";
    };
  };
  programs = {
    git = {
      enable = true;
      settings = {
        user.email = "tschrader@quera.com";
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
      settings = {
        index = [
          {
            name = "JFROG";
            url = "https://quera.jfrog.io/artifactory/api/pypi/Development/simple";
          }
          {
            name = "JFROGALGO";
            url = "https://quera.jfrog.io/artifactory/api/pypi/quera-pypi-algo/simple";
          }
          {
            name = "KIRIN";
            url = "https://quera.jfrog.io/artifactory/api/pypi/kirin/simple";
          }
        ];
      };
    };
    k9s = {
      enable = true;

      settings = {
        k9s = {
          ui = {
            enableMouse = true;
            skin = "transparent";
          };
        };
      };
      skins = {
        transparent = {
          k9s = {
            body = {
              bgColor = "default";
            };

            prompt = {
              bgColor = "default";
            };

            info = {
              sectionColor = "default";
            };

            dialog = {
              bgColor = "default";
              labelFgColor = "default";
              fieldFgColor = "default";
            };

            frame = {
              crumbs = {
                bgColor = "default";
              };
              title = {
                bgColor = "default";
                counterColor = "default";
              };
              menu = {
                fgColor = "default";
              };
            };

            views = {
              charts = {
                bgColor = "default";
              };
              table = {
                bgColor = "default";
                header = {
                  fgColor = "default";
                  bgColor = "default";
                };
              };
              xray = {
                bgColor = "default";
              };
              logs = {
                bgColor = "default";
                indicator = {
                  bgColor = "default";
                  toggleOnColor = "default";
                  toggleOffColor = "default";
                };
              };
              yaml = {
                colonColor = "default";
                valueColor = "default";
              };
            };
          };
        };
      };
    };
  };
}
