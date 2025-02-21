{ pkgs, lib, ... }:
{
  imports = [
    ./conform.nix
    # ./fidget.nix

  ];
  plugins = {
    lsp-lines.enable = true;
    lsp-format.enable = false;
    helm.enable = true;
    nvim-jdtls = {
      enable = true;
      cmd = [
        (lib.getExe pkgs.jdt-language-server)
        ""
      ];

    };

    lsp = {
      enable = true;
      inlayHints = true;

      servers = {
        java_language_server.enable = true;

        html = {
          enable = true;
        };
        lua_ls = {
          enable = true;
        };
        nil_ls = {
          enable = true;
        };
        ts_ls = {
          enable = true;
        };
        marksman = {
          enable = true;
        };
        pyright = {
          enable = true;
        };
        gopls = {
          enable = true;
        };
        terraformls = {
          enable = true;
        };
        ansiblels = {
          enable = true;
        };
        jsonls = {
          enable = true;
        };
        jdtls = {
          enable = true;
        };

        nixd = {
          enable = true;
          extraOptions = {
            expr = "import <nixpkgs> {}";
            offset_encoding = "utf-8";
          };
        };
        clangd = {
          enable = true;
        };
      };
      keymaps = {
        silent = true;
        lspBuf = {
          gd = {
            action = "definition";
            desc = "Goto Definition";
          };
          gr = {
            action = "references";
            desc = "Goto References";
          };
          gD = {
            action = "declaration";
            desc = "Goto Declaration";
          };
          gi = {
            action = "implementation";
            desc = "Goto Implementation";
          };
          gT = {
            action = "type_definition";
            desc = "Type Definition";
          };
          K = {
            action = "hover";
            desc = "Hover";
          };
          "<leader>cw" = {
            action = "workspace_symbol";
            desc = "Workspace Symbol";
          };
          "<leader>cr" = {
            action = "rename";
            desc = "Rename";
          };
        };
      };
      # diagnostic = {
      #  "<leader>cd" = {
      #  action = "open_float";
      #  desc = "Line Diagnostics";
      # };
      #  "[d" = {
      #  action = "goto_next";
      #  desc = "Next Diagnostic";
      #  };
      #  "]d" = {
      #  action = "goto_prev";
      #  desc = "Previous Diagnostic";
      #  };
      #  };
    };
  };

  # none-ls = {
  #   enable = true;
  #   sources = {
  #     diagnostic = {
  #       golangci_lint.enable = true;
  #       statix.enable = true;
  #
  #     };
  #     formatting = {
  #       gofmt.enable = true;
  #       goimports.enable = true;
  #       nixfmt.enable = true;
  #       markdownlint.enable = true;
  #       tidy.enable = true;
  #
  #     };
  #   };
  # };
}
