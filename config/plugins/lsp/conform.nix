{ pkgs, ... }:
{
  extraPackages = with pkgs; [
    shfmt
    google-java-format
    nixfmt
    prettierd
    prettier
    yamlfmt
    yamllint

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
      };
    };
  };
}
