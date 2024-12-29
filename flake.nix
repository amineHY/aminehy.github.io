{
  description = "Development environment with Asciidoctor and Go";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      # Define the systems we want to support
      supportedSystems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];
      
      # Helper function to generate attributes for all systems
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      
      # Helper function to get pkgs for each system
      pkgsFor = system: nixpkgs.legacyPackages.${system};
    in
    {
      devShells = forAllSystems (system: {
        default = let pkgs = pkgsFor system; in
          pkgs.mkShell {
            buildInputs = with pkgs; [
              # Asciidoctor and related tools
              asciidoc-full

              # Go development
              go
              gopls        # Go language server
              go-tools     # Additional Go tools
              delve        # Go debugger
            ];

            shellHook = ''
              echo "Development environment loaded!"
              echo "Available tools:"
              echo " - Asciidoctor: $(asciidoctor --version)"
              echo " - Go: $(go version)"
            '';
          };
      });
    };
}