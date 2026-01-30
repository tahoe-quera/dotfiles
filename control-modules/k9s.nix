{pkgs, ...}: {
  config.programs.k9s = {
    enable = true;
    settings = {
      k9s = {
        ui = {
          headless = true;
          logoless = true;
          reactive = false;
          enableMouse = false;
        };
        refreshRate = "5s";
      };
    };
  };
}
