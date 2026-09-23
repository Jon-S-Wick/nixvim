{
  plugins.nvim-autopairs = {
    enable = true;
    settings = {
      disable_filetype = [
        "TelescopePrompt"
        "vim"
      ];
      fast_wrap = {
        map = "<leader>wr";
        end_key = "$";
      };
    };
  };
}
