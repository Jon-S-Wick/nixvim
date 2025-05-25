{
  imports = [
    ./undotree.nix
    ./treesitter.nix
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

    };

  };

}
