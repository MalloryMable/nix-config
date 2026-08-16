{config, pkgs, ... }:

{
  environment.shellAliases = {
    ls = "eza";
    ll = "ls -l --header";
    lt = "ls --header --tree";
    lg = "lt -l --git";

    inlyne = "WAYLAND_DISPLAY= inlyne --theme dark";
  };
}
