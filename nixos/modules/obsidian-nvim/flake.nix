{
  description = "A flake for obsidian.nvim";

  outputs = { self, nixpkgs }: {
    # Define your packages or configurations
    packages.x86_64-linux = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux ;
    in pkgs.stdenv.mkDerivation {
      pname = "obsidian-nvim";
      version = "1.0";

      src = pkgs.fetchgit {
        url = "https://github.com/epwalsh/obsidian.nvim";
        sha256 = "sha256-mbq7fAPmlwOAbWlN3lGX9WGBKTV8cAPZx8pnRCyszJc=";
      };

      buildInputs = with pkgs; [
        luaPackages.luacheck
        stylua
        vim
      ];

      # solves `Couldn't make directory /homeless-shelter: Permission denied` error
      # this may have something to do with --impure when building flakes?
      buildPhase = ''export HOME=$TMP'';

      installPhase = ''
        mkdir -p $out
        cp -r $src/* $out
      '';

    };
  };
}
