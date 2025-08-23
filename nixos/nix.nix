{
  nix = {
    settings = {
      auto-optimise-store = true;
      # enable flakes and more features
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
    };

    gc = {
      # garbage collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 15d";
    };
  };
}
