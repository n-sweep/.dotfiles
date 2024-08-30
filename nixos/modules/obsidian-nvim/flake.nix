{
  description = "A flake for obsidian.nvim";

  outputs = { self, nixpkgs }: {
    # Define your packages or configurations
    packages.x86_64-linux = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux ;
    in pkgs.stdenv.mkDerivation {
      pname = "obsidian.nvim";
      version = "1.0";

      src = pkgs.fetchgit {
        url = "https://github.com/epwalsh/obsidian.nvim";
        sha256 = "sha256-t1MSU1ufujdDI6ne6AOtIqnC45JjWXtOkmFloxsrfRU=";
      };

      buildInputs = with pkgs; [
        luaPackages.luacheck
        stylua
        vim
      ];

      # solves `Couldn't make directory /homeless-shelter: Permission denied` error
      buildPhase = ''
        export HOME=$TMP
      '';

      installPhase = ''
        mkdir -p $out
        cp -r $src/* $out
      '';

    };
  };
}
