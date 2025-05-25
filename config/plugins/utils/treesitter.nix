{ pkgs, ... }:
{
  filetype.extension.liq = "liquidsoap";
  plugins = {
    treesitter = {
      enable = true;
      nixGrammars = true;
      settings = {
        indent.enable = true;
        highlight.enable = true;
      };
      folding = true;
      nixvimInjections = true;
      languageRegister.liq = "liquidsoap";

      grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
      # grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      #   bash
      #   json
      #   java
      #   c
      #   python
      #   cpp
      #   lua
      #   make
      #   markdown
      #   nix
      #   regex
      #   toml
      #   vim
      #   vimdoc
      #   xml
      #   yaml
      # ];

    };
  };
}
