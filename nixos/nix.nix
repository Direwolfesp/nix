{
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        # enable flakes
        "nix-command"
        "flakes"
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
