{
  imports = [./packages.nix ./ssh.nix];
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
}
