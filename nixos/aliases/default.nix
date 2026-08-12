{config, pkgs, ... }:

{
  environment.shellAliases = {
    ls = "eza";
    ll = "ls -l --header";
    lt = "ls --header --tree";
  };
}
