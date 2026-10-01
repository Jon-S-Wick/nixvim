{ pkgs, ... }:
let
  # Everything needed to round-trip and execute notebooks: jupytext for the
  # .ipynb <-> plain text conversions, ipykernel/nbclient so that
  # `jupytext --execute` can actually run the cells.
  jupyterEnv = pkgs.python3.withPackages (
    ps: with ps; [
      jupytext
      ipykernel
      jupyter-client
      jupyter-core
      nbclient
      nbconvert
      nbformat
    ]
  );

  # The store is read only, so ipykernel cannot register itself into the python
  # environment. Ship a kernelspec pointing back at the environment and expose
  # it through JUPYTER_PATH.
  jupyterKernels = pkgs.runCommand "jupyter-kernels" { } ''
    mkdir -p "$out/kernels/python3"
    cat > "$out/kernels/python3/kernel.json" <<'EOF'
    {
      "argv": [
        "${jupyterEnv}/bin/python3",
        "-m",
        "ipykernel_launcher",
        "-f",
        "{connection_file}"
      ],
      "display_name": "Python 3 (ipykernel)",
      "language": "python",
      "metadata": { "debugger": true }
    }
    EOF
  '';
in
{
  env.JUPYTER_PATH = "${jupyterKernels}";

  extraPackages = [ jupyterEnv ];

  plugins = {
    # Opens `foo.ipynb` as `foo.py` (percent format) and writes it back.
    jupytext = {
      enable = true;

      settings = {
        # `percent` keeps the plain text file free of the per-line jupyter
        # metadata comments that the other styles add, which is what makes the
        # text version pleasant to edit and diff.
        style = "percent";
        output_extension = "auto";
        custom_language_formatting = { };
      };
    };

    # Quick REPL for evaluating a cell while you are still editing it.
    iron = {
      enable = true;

      settings = {
        scratch_repl = true;

        repl_definition.python = {
          command = [ "python3" ];
          format.__raw = "require('iron.fts.common').bracketed_paste_python";
        };

        keymaps = {
          send_motion = "<leader>is";
          visual_send = "<leader>is";
          send_line = "<leader>il";
          send_file = "<leader>iF";
        };
      };
    };
  };

  extraConfigLua = ''
    -- The `jupytext` plugin module pulls in nixpkgs' standalone `jupytext`,
    -- which sits in front of this environment on $PATH and has no jupyter_client
    -- next to it, so the commands call the copy that can actually execute.
    local jupytext = "${jupyterEnv}/bin/jupytext"

    -- `jobstart` takes an argv list, so nothing here is shell escaped: paths
    -- are handed to jupytext exactly as Neovim spells them.
    local function jupytext_cmd(args)
      -- jupytext reads from disk, so flush the buffer first.
      local file = vim.fn.expand("%:p")
      if vim.bo.modified then
        if file:match("%.ipynb$") then
          -- Inside a notebook buffer jupytext.nvim owns :write, and its handler
          -- does a plain `write` of the paired script, which errors out when
          -- that script is already open in another buffer. The buffer holds the
          -- percent text anyway (behind the blank line the plugin adds for
          -- undo), so landing it in the paired script directly is equivalent.
          local target = vim.fn.fnamemodify(file, ":r") .. ".py"
          vim.fn.writefile(vim.api.nvim_buf_get_lines(0, 1, -1, false), target)
          vim.bo.modified = false
        else
          vim.cmd("write")
        end
      end

      local err = {}
      local argv = { jupytext }
      vim.list_extend(argv, args)
      table.insert(argv, vim.fn.fnamemodify(file, ":t"))

      vim.fn.jobstart(argv, {
        -- jupytext resolves its relative paths against the cwd, so pin it to
        -- the file's directory instead of wherever Neovim was started.
        cwd = vim.fn.fnamemodify(file, ":h"),
        stderr_buffered = true,
        on_stderr = function(_, data)
          for _, line in ipairs(data) do
            if line ~= "" then
              table.insert(err, (line:gsub("^%s+", "")))
            end
          end
        end,
        on_exit = function(_, code)
          if code ~= 0 then
            vim.notify(table.concat(err, "\n"), vim.log.levels.ERROR, { title = "jupytext" })
          end
        end,
      })
    end

    vim.api.nvim_create_user_command("NotebookExport", function()
      jupytext_cmd({ "--to", "ipynb", "--set-kernel", "python3" })
    end, { desc = "Regenerate the .ipynb counterpart from this script", nargs = 0 })

    vim.api.nvim_create_user_command("NotebookRun", function()
      local stem = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":r")
      jupytext_cmd({
        "--to",
        "notebook",
        "--execute",
        "--set-kernel",
        "python3",
        "--output",
        stem .. ".ipynb",
      })
    end, { desc = "Execute the current script and store the outputs in the .ipynb", nargs = 0 })

    -- The `percent` style cannot carry jupytext's pairing metadata, so
    -- `jupytext --sync` has nothing to go on and refuses to run. The two sides
    -- always share a basename, so the direction is taken from the buffer
    -- instead: whatever you are looking at is the source of truth.
    vim.api.nvim_create_user_command("NotebookSync", function()
      if vim.fn.expand("%:p"):match("%.ipynb$") then
        local stem = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":r")
        jupytext_cmd({
          "--to",
          "py:percent",
          "--update",
          "--output",
          stem .. ".py",
        })
      else
        jupytext_cmd({
          "--to",
          "ipynb",
          "--update",
          "--set-kernel",
          "python3",
        })
      end
    end, { desc = "Update the counterpart of the current notebook pair", nargs = 0 })
  '';

  keymaps = [
    {
      key = "<leader>jr";
      action = "<cmd>NotebookRun<cr>";
      options.desc = "Jupyter: execute and store outputs in the .ipynb";
    }
    {
      key = "<leader>je";
      action = "<cmd>NotebookExport<cr>";
      options.desc = "Jupyter: export to .ipynb";
    }
    {
      key = "<leader>jy";
      action = "<cmd>NotebookSync<cr>";
      options.desc = "Jupyter: sync the notebook pair";
    }
    {
      key = "<leader>ii";
      action = "<cmd>IronRepl python<cr>";
      options.desc = "Iron: toggle the Python REPL";
    }
  ];
}
