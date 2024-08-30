{
  description = "A flake for obsidian.nvim";

  outputs = { self, nixpkgs }: {
    # Define your packages or configurations
    defaultPackage.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.stdenv.mkDerivation {
      pname = "obsidian.nvim";
      version = "1.0";

      src = nixpkgs.fetchgit {
        url = "https://github.com/epwalsh/obsidian.nvim";
        sha256 = "sha256-t1MSU1ufujdDI6ne6AOtIqnC45JjWXtOkmFloxsrfRU=";
      };

      # buildInputs = [ ];

      installPhase = ''
        mkdir -p $out
        cp -r $src/* $out/.config/nvim/pack/vendor/start/obsidian
      '';
    };
  };
}
