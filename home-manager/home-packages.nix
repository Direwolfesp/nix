{ pkgs, ... }:
{
  # Here the ones that no require explicit config
  home.packages = with pkgs; [
    fastfetch
    fzf
    fd
    ripgrep
    yazi # TODO: remove from here
    nushell # TODO: remove from here
  ];
}
