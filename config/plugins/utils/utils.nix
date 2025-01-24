{
  imports = [ ./undotree.nix ./treesitter.nix ];
  plugins = {
    telescope = {

      enable = true;
      extensions.fzf-native = { enable = true; };
      settings.defaults = { selection_caret = "❚ "; };
    };

  };

}
