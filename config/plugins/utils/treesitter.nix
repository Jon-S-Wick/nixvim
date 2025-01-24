{ pkgs, ... }: {
  plugins = {
    treesitter = {
      enable = true;
      nixGrammars = true;
      settings = {
        indent.enable = true;
        highlight.enable = true;
      };
      folding = true;

      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        json
        java
        c
        python
        cpp
        lua
        make
        markdown
        nix
        regex
        toml
        vim
        vimdoc
        xml
        yaml
      ];

    };
  };
}
