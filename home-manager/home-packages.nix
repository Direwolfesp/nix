{ pkgs, ... }:
{
  # Here the ones that no require explicit config,
  # the rest are either managed by home-manager program.enable option
  # or if they are system packages.
  home.packages = with pkgs; [
    fastfetch
    fzf
    jq
    fd
    bat
    ripgrep
    nvtopPackages.amd
    btop
    tokei
    tealdeer
    eza
  ];
}
