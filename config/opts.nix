{ pkgs, ... }:
{
  # formatter = pkgs.nixfmt-rfc-style;
  clipboard = {
    providers.wl-copy.enable = true;
  };
  opts = {

    updatetime = 50; # Faster completion

    number = true;
    relativenumber = true;

    autoindent = true;
    clipboard = "unnamed,unnamedplus";

    expandtab = true;
    tabstop = 4;
    softtabstop = 4;
    shiftwidth = 2;
    smartindent = true;
    breakindent = true;

    ignorecase = true;
    incsearch = true;
    hlsearch = true;
    smartcase = true;
    wildmode = "list:longest";
    completeopt = [
      "menuone"
      "noselect"
      "noinsert"
    ];
    signcolumn = "yes";
    cursorline = true;
    scrolloff = 8;
    mouse = "a";
    termguicolors = true;
    showmode = false;
    foldmethod = "manual";
    foldenable = false;
    linebreak = true;

    wrap = false;

    swapfile = false;
    undofile = true;
    conceallevel = 3;
  };
}
