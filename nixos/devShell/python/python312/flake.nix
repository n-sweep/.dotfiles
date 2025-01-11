{
  description = "a dev shell for python 3.12";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {self, nixpkgs, ... }:
  let
    allSystems = [
      "x86_64-linux"  # 64-bit intel/amd linux
      # add other system architectures as needed
    ];

    # helper to provide system-specific attributes
    forAllSystems = f:
      nixpkgs.lib.genAttrs allSystems
      (system: f { pkgs = import nixpkgs { inherit system; }; });

  in {
    devShells = forAllSystems ({ pkgs }:
      let
        python = pkgs.python312;

        pyPkgsCommon = ps: with ps; [
            aiohttp
            beautifulsoup4
            black
            discordpy
            duckdb
            flask
            flask-socketio
            google-api-python-client
            google-auth-httplib2
            google-auth-oauthlib
            graph-tool
            ipykernel
            ipython
            imageio
            jupyter
            jupytext
            lxml
            matplotlib
            pymssql
            numpy
            opencv4
            openpyxl
            pandas
            pillow
            plotly
            pynvim
            pyperclip
            pyqt6
            pytesseract
            pytz
            requests
            scikit-learn
            scipy
            seaborn
            selenium
            stdenv.cc.cc.lib  # make
            xgboost
            xlrd
        ];

      in {

        default = pkgs.mkShell {
          packages = [(python.withPackages pyPkgsCommon)];
          shellHook = ''export DEVSHELL="default"'';
        };

    });
  };
}
