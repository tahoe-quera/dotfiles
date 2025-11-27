{
  home = {
    shellAliases = {
      quera = "sudo darwin-rebuild switch --flake ~/Documents/repos/dotfiles#quera; echo Remember to close and reopen shell!\n";
      checkhooks = "pre-commit run --hook-stage manual --all-files";
    };
  };
}
