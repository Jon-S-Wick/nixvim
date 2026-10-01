{
  imports = [
    ./undotree.nix
    ./treesitter.nix
    ./wrap.nix
    ./latex.nix
    ./jupyter.nix
    ./nextflow.nix
  ];
  plugins = {
    telescope = {

      enable = true;
      extensions.fzf-native = {
        enable = true;
      };
      settings.defaults = {
        selection_caret = "❚ ";
      };
    };
    nvim-surround.enable = true;
    flash = {

      enable = true;
      autoLoad = true;
      lazyLoad.enable = false;
    };

  };

}
