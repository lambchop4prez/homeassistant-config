{
    description = "Home Assistant config flake";
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };
    outputs = inputs@{self, nixpkgs}:
    let
        darwinSystems = ["aarch64-darwin" "x86_64-darwin"];
        linuxSystems = ["aarch64-linux" "x86_64-linux"];
        allSystems = darwinSystems ++ linuxSystems;
    in
    {
        devShells = nixpkgs.lib.genAttrs allSystems (
            system:
            let
                pkgs = import nixpkgs {
                    inherit system;
                };
                # python = pkgs.python312;
                # pythonPackages = python.pkgs;
                # lib-path = with pkgs; lib.makeLibraryPath [
                #     libffi
                #     openssl
                #     stdenv.cc.cc
                # ];
            in
            {
                default = pkgs.mkShell {
                    packages = with pkgs; [
                        # (python312Full.withPackages (
                        #     ps: with ps; [
                        #         pip
                        #         jmespath
                        #         requests
                        #         setuptools
                        #         pyyaml
                        #         pyopenssl
                        #     ]
                        # ))
                        esphome
                    ];

                    # shellHook = ''
                    #     SOURCE_DATE_EPOCH=$(date +%s)
                    #     export "LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${lib-path}"
                    #     VENV=.venv

                    #     if test ! -d $VENV; then
                    #         python3.12 -m venv $VENV
                    #     fi
                    #     source ./$VENV/bin/activate
                    #     export PYTHONPATH=`pwd`/$VENV/${python.sitePackages}/:$PYTHONPATH
                    #     pip install -r requirements.txt
                    # '';

                    # postShellHook = ''
                    #     ln -sf ${python.sitePackages}/* ./.venv/lib/python3.12/site-packages
                    # '';
                };
            }
        );
    };
}