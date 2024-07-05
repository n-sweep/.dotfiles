{
  description = "a dev shell for python 3.11";

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
        python = pkgs.python311;

        pyPkgsCommon = ps: with ps; [
            aiohttp
            beautifulsoup4
            black
            flask
            flask-socketio
            google-api-python-client
            google-auth-httplib2
            google-auth-oauthlib
            ipykernel
            ipython
            jupyter
            jupytext
            matplotlib
            numpy
            openpyxl
            pandas
            plotly
            pynvim
            pyperclip
            pyqt6
            pytz
            requests
            scikit-learn
            scipy
            seaborn
            stdenv.cc.cc.lib  # make
            xgboost
            xlrd
        ];

        # common packages plus extras
        pyPkgsCL = ps: pyPkgsCommon ps ++ (with ps; [
          # add cl packages
          (buildPythonPackage {
            name = "closedloop-api-private";
            src = /home/n/work/cl/Repos/closedloop-api-python;
            format = "pyproject";
            buildInputs = [ pkgs.python3Packages.setuptools ];
            propagatedBuildInputs = with pkgs.python3Packages; [
              boto3
              cachecontrol
              certifi
              deepdiff
              google-api-python-client
              google-auth
              google-cloud-storage
              hvac
              pyjwt
              pytest
              pyyaml
              requests
              requests-toolbelt
              six
              sqlparse
              websocket_client

              geopandas
              shapely
            ];
           })

          (buildPythonPackage {
            name = "closedloop-ds";
            src = /home/n/work/cl/Repos/closedloop-ds;
            format = "pyproject";
            buildInputs = [ pkgs.python3Packages.setuptools ];
            # propagatedBuildInputs = with pkgs.python3Packages; [ ]
          })

        ]);

      in {

        default = pkgs.mkShell {
          packages = [(python.withPackages pyPkgsCommon)];
          shellHook = ''export DEVSHELL="default"'';
        };

        cl = pkgs.mkShell {
          packages = [(python.withPackages pyPkgsCL)];
          shellHook = ''export DEVSHELL="cl"'';
        };

    });
  };
}
