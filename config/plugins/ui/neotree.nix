{
  plugins.oil = {
    enable = true;

  };
  plugins.neo-tree = {

    enable = true;
    settings = {

      sources = [
        "filesystem"
        "buffers"
        "git_status"
        "document_symbols"
      ];
      addBlankLineAtTop = false;
      filesystem = {
        bindToCwd = false;
        followCurrentFile = {
          enabled = true;
        };
      };
      enableDiagnostics = true;
      enableGitStatus = true;
      enableModifiedMarkers = true;
      enableRefreshOnWrite = true;
      closeIfLastWindow = true;
      popupBorderStyle = "rounded"; # Type: null or one of “NC”, “double”, “none”, “rounded”, “shadow”, “single”, “solid” or raw lua code

      default_component_configs = {
        indent = {
          withExpanders = true;
          expanderCollapsed = "󰅂";
          expanderExpanded = "󰅀";
          expanderHighlight = "NeoTreeExpander";
        };

        gitStatus = {
          symbols = {
            added = " ";
            conflict = "󰩌 ";
            deleted = "󱂥";
            ignored = " ";
            modified = " ";
            renamed = "󰑕";
            staged = "󰩍";
            unstaged = "";
            untracked = " ";
          };
        };
      };
    };
  };

  keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>e";
      action = "<cmd>Neotree toggle<cr>";
      options = {
        desc = "Open/Close Neotree";
      };
    }
  ];
}
