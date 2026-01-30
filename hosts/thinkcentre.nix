{pkgs, ...}: {
  home = {
    shellAliases = {
      thinkcentre = "home-manager switch --flake ~/Documents/repos/dotfiles#thinkcentre; echo Remember to close and reopen shell!\n";
      checkhooks = "pre-commit run --hook-stage manual --all-files";
    };
    packages = with pkgs; [
      xclip
    ];
  };
  programs = {
    fastfetch = {
      enable = true;
      settings = {
        logo = {
          source = "ubuntu";
          padding = {
            right = 2;
          };
        };
        display = {
          size = {
            binaryPrefix = "si";
          };
          color = "blue";
          separator = "  ";
        };
        modules = [
          {
            type = "title";
          }
          {
            type = "separator";
            string = "ハ";
          }
          {
            type = "datetime";
            key = "Date";
            format = "{1}/{3}/{11}";
          }
          {
            type = "datetime";
            key = "Time";
            format = "{14}:{17}";
          }
          {
            type = "uptime";
            key = "Up";
          }
          "break"
          {
            type = "host";
            key = "Host";
          }
          {
            type = "os";
            key = "OS";
          }
          {
            type = "kernel";
            key = "Kernel";
          }
          {
            type = "shell";
            key = "Shell";
          }
          {
            type = "terminal";
            key = "Terminal";
          }
          {
            type = "de";
            key = "DE";
          }
          {
            type = "wm";
            key = "WM";
          }
          {
            type = "theme";
            key = "Theme";
          }
          {
            type = "font";
            key = "Font";
          }
          "break"
          {
            type = "cpu";
            key = "CPU";
            format = "{name} ({cores-physical}C/{cores-logical}T) @ {freq-max}";
          }
          {
            type = "gpu";
            key = "GPU";
          }
          {
            type = "memory";
            key = "Memory";
            format = "{used}/{total} ({percentage})";
          }
          {
            type = "disk";
            key = "Disk";
            folders = ["/"];
          }
          {
            type = "display";
            key = "Display";
          }
          "break"
          {
            type = "localip";
            key = "IP";
          }
          "player"
          "media"
        ];
      };
    };
  };
}
