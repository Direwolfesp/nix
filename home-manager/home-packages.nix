{ pkgs, ... }:
{
  # Here the ones that no require explicit config,
  # the rest are either managed by home-manager program.enable option
  # or if they are system packages.
  home.packages = with pkgs; [
    # CLI
    fastfetch
    jq
    fd
    bat
    ouch
    ripgrep
    nvtopPackages.amd
    btop
    tokei
    tealdeer
    eza
    nh
    socat
    dust
    libqalculate

    # GUI
    xournalpp
    pear-desktop
    zed-editor
    smile
    libreoffice-qt6-fresh
    jellyfin-desktop

    # audio
    pulseaudioFull
    playerctl
  ];
}
