{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    openssl
    gdb
    gnumake
    clang-tools
    man-pages
    man-pages-posix
    cmake
    cargo
    rustc
    zig
    zls
    fzf
    vim
    git
    wget
    curl
    zenity
    libnotify
  ];
}
