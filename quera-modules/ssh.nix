{pkgs, ...}: {
  config.programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = [
      "~/src/q/share/ssh/config"
      "~/.ssh/config.local"
    ];
    matchBlocks = {
      "github.com" = {
        identityFile = "~/.ssh/id_ed25519";
      };
      "*".addKeysToAgent = "yes";
    };
  };
}
