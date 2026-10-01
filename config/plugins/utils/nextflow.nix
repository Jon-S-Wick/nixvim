{ pkgs, lib, ... }:
let
  # Not packaged in nixpkgs, so build a tiny wrapper around the official
  # "all in one" jar release.
  nextflow-language-server = pkgs.stdenvNoCC.mkDerivation {
    pname = "nextflow-language-server";
    version = "26.04.4";

    dontUnpack = true;

    src = pkgs.fetchurl {
      url = "https://github.com/nextflow-io/language-server/releases/download/v26.04.4/language-server-all.jar";
      hash = "sha256-4cXakMfwVlup5krDxbWPEhXjFda/5EFNYv8tAnSeiIc=";
    };

    installPhase = ''
      runHook preInstall

      install -Dm444 "$src" "$out/lib/nextflow-language-server-all.jar"

      mkdir -p "$out/bin"
      cat > "$out/bin/nextflow-language-server" <<EOF
      #!${pkgs.runtimeShell}
      exec ${pkgs.jre_headless}/bin/java -jar "$out/lib/nextflow-language-server-all.jar" "\$@"
      EOF
      chmod +x "$out/bin/nextflow-language-server"

      runHook postInstall
    '';

    meta = {
      description = "Language Server for Nextflow pipeline scripts";
      homepage = "https://github.com/nextflow-io/language-server";
      license = lib.licenses.asl20;
      mainProgram = "nextflow-language-server";
      platforms = lib.platforms.unix;
    };
  };
in
{
  # `nextflow run`, `nextflow console`, `nextflow log`, ...
  extraPackages = [ pkgs.nextflow ];

  filetype = {
    extension.nf = "nextflow";
    filename = {
      "nextflow.config" = "nextflow";
      "nextflow.config.json" = "json";
    };
  };

  lsp.servers.nextflow_ls = {
    enable = true;

    # Everything here ends up verbatim in the `vim.lsp.config` entry for
    # `nextflow_ls`, so `cmd` and the server's `settings` live side by side.
    config = {
      cmd = [ "${nextflow-language-server}/bin/nextflow-language-server" ];

      settings.nextflow.files.exclude = [
        ".git"
        ".nf-test"
        ".nextflow"
        ".lineage"
        "work"
      ];
    };
  };

  keymaps = [
    {
      key = "<leader>nf";
      action = "<cmd>NextflowRun<cr>";
      options.desc = "Nextflow: run pipeline in a split";
    }
    {
      key = "<leader>nc";
      action = "<cmd>NextflowConsole<cr>";
      options.desc = "Nextflow: open the DSL console";
    }
    {
      key = "<leader>nl";
      action = "<cmd>NextflowLog<cr>";
      options.desc = "Nextflow: tail the latest execution log";
    }
  ];

  extraConfigLua = ''
    -- `cwd` has to be worked out before the split, because after it the current
    -- buffer is the new (still unnamed) terminal buffer.
    local function nextflow_term(cmd, name, cwd)
      vim.cmd("botright split")
      local buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_set_name(buf, "term://nextflow " .. name)
      vim.fn.termopen(cmd, {
        cwd = cwd,
        on_exit = function()
          vim.schedule(function()
            vim.api.nvim_buf_delete(buf, { force = true })
          end)
        end,
      })
      vim.cmd("startinsert")
    end

    -- The whole path, so the command runs the script you are editing no matter
    -- which directory Neovim was started from.
    local function current_script()
      -- Terminals, oil, help buffers and friends have no path to work with.
      if vim.bo.buftype ~= "" then
        return nil
      end

      local path = vim.fn.expand("%:p")
      if path == "" or vim.fn.filereadable(path) == 0 then
        return nil
      end

      return path
    end

    local function no_script()
      vim.notify("No Nextflow script in this buffer", vim.log.levels.WARN, { title = "nextflow" })
    end

    vim.api.nvim_create_user_command("NextflowRun", function(args)
      local entry = args.args ~= "" and args.args or current_script()
      if not entry then
        return no_script()
      end

      nextflow_term(
        { "nextflow", "run", entry },
        "run " .. vim.fn.fnamemodify(entry, ":t"),
        vim.fn.fnamemodify(entry, ":h")
      )
    end, { desc = "Run the current Nextflow script in a split", nargs = "?" })

    vim.api.nvim_create_user_command("NextflowConsole", function()
      local entry = current_script()
      if not entry then
        return no_script()
      end

      nextflow_term(
        { "nextflow", "console", entry },
        "console " .. vim.fn.fnamemodify(entry, ":t"),
        vim.fn.fnamemodify(entry, ":h")
      )
    end, { desc = "Open the Nextflow DSL console", nargs = 0 })

    vim.api.nvim_create_user_command("NextflowLog", function()
      nextflow_term({ "nextflow", "log", "-f" }, "log", vim.fn.getcwd())
    end, { desc = "Follow the latest Nextflow execution log", nargs = 0 })
  '';
}
