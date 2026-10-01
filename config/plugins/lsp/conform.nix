{ pkgs, lib, ... }:
{
  extraPackages = with pkgs; [
    shfmt
    google-java-format
    nixfmt
    prettierd
    prettier
    yamlfmt
    yamllint
    black
    stylua
  ];
  plugins.conform-nvim = {
    enable = true;

    # lazyLoad.settings = {
    #   cmd = [
    #     "ConformInfo"
    #   ];
    #   event = [ "BufWrite" ];
    # };

    settings = {
      format_on_save = {
        lspFallback = true;
        timeoutMs = 500;
      };
      notify_on_error = true;

      formatters = {
        # `lspFallback` would otherwise hand texlab's latexindent formatter
        # every save, which reindents the whole document. Opt out explicitly;
        # swap in "texlab_indent" if you do want it.
        noop = {
          command = lib.getExe' pkgs.coreutils "true";
        };
      };

      formatters_by_ft = {

        html = [
          "prettierd"
          "prettier"
        ];
        css = [
          "prettierd"
          "prettier"
        ];
        javascript = [
          "prettierd"
          "prettier"
        ];
        javascriptreact = [
          "prettierd"
          "prettier"
        ];
        typescript = [
          "prettierd"
          "prettier"
        ];
        typescriptreact = [
          "prettierd"
          "prettier"
        ];
        markdown = [
          "prettierd"
          "prettier"
        ];

        python = [ "black" ];
        lua = [ "stylua" ];
        nix = [ "nixfmt" ];

        yaml = [
          "yamlfmt"
          "yamllint"
        ];
        java = [ "google-java-format" ];
        bash = [ "shfmt" ];
        sh = [ "shfmt" ];
        tex = [ "noop" ];
        plaintex = [ "noop" ];
      };
    };
  };
}
