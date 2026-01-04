{
  home = {
    shellAliases = {
      quera = "home-manager switch --flake ~/Documents/repos/dotfiles#turingpi; echo Remember to close and reopen shell!\n";
      checkhooks = "pre-commit run --hook-stage manual --all-files";
    };
  };
}
