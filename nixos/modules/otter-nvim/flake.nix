{
  description = "A flake for otter.nvim";

  outputs = { self, nixpkgs }: {
    # Define your packages or configurations
    defaultPackage.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.stdenv.mkDerivation {
      pname = "otter.nvim";
      version = "1.0";

      src = nixpkgs.fetchgit {
        url = "https://github.com/jmbuhr/otter.nvim";
        sha256 = "sha256-7y+dqDAx3EHL4A4bvWzoDi9aXwQMp4NfLgVp++XTfps=";
      };

      # buildInputs = [ ];

      installPhase = ''
        mkdir -p $out
        cp -r $src/* $out/.config/nvim/pack/vendor/start/otter
      '';
    };
  };
}
