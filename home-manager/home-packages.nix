{ pkgs, ... }:
{
  # Here the ones that no require explicit config
  home.packages = with pkgs; [
    fastfetch
    fzf
    jq
    fd
    ripgrep
    nvtopPackages.amd
    btop
    tokei
    tealdeer
    eza
    yazi # TODO: remove from here
    nushell # TODO: remove from here
  ];
}
