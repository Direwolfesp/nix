{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    openssl
    gdb
    gnumake
    valgrind
    clang-tools
    file
    man-pages
    man-pages-posix
    cmake
    cargo
    rustc
    rust-analyzer
    rustfmt
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
