{ pkgs, ... }:
{
  home = {
    shellAliases = {
      salaryman = "home-manager switch --flake ~/Documents/repos/dotfiles#salaryman; echo Remember to close and reopen shell!\n";
      checkhooks = "pre-commit run --hook-stage manual --all-files";
    };
  };
}
