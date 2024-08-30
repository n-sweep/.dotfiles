{
  description = "A flake for mojo.vim";

  outputs = { self, nixpkgs }: {
    # Define your packages or configurations
    defaultPackage.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.stdenv.mkDerivation {
      pname = "mojo.vim";
      version = "1.0";

      src = nixpkgs.fetchgit {
        url = "https://github.com/czheo/mojo.vim";
        hash = "sha256-gUq2OBA1VuJFgaJCX+9GBFv0jlFL1sKuiDv/DnJl5qo=";
      };

      # buildInputs = [ ];

      installPhase = ''
        dest=$out/.config/nvim/pack/vendor/start/mojo
        mkdir -p $dest
        cp -r $src/* $dest
      '';
    };
  };
}
