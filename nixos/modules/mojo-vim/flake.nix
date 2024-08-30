{
  description = "A flake for mojo.vim";

  outputs = { self, nixpkgs }: {
    # Define your packages or configurations
    packages.x86_64-linux = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux ;
    in pkgs.stdenv.mkDerivation {
      pname = "mojo.vim";
      version = "1.0";

      src = pkgs.fetchgit {
        url = "https://github.com/czheo/mojo.vim";
        sha256 = "sha256-gUq2OBA1VuJFgaJCX+9GBFv0jlFL1sKuiDv/DnJl5qo=";
      };

      installPhase = ''
        mkdir -p $out
        cp -r $src/* $out
      '';

    };
  };
}
