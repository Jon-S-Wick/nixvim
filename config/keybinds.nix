{
  globals.mapleader = " ";
  plugins = {
    which-key.enable = true;
    tmux-navigator.enable = true;
  };
  keymaps = [
    #navigation
    {
      key = "<C-h>";
      action = "<cmd>TmuxNavigateLeft<cr>";
    }
    {
      key = "<C-j>";
      action = "<cmd>TmuxNavigateDown<cr>";
    }
    {
      key = "<C-k>";
      action = "<cmd>TmuxNavigateUp<cr>";
    }
    {
      key = "<C-l>";
      action = "<cmd>TmuxNavigateRight<cr>";
    }
    #search
    {
      key = "s";
      action = "function() require('flash').jump() end, desc = 'Flash'";

    }
    {
      key = "S-s";
      action = "function() require('flash').treesitter() end, desc = 'Flash Treesitter' ";

    }

    #window resizing
    {
      mode = "n";
      key = "<C-Up>";
      action = "<cmd>resize +2<cr>";
      options = {
        desc = "Increase Window Height";
      };
    }
    {
      mode = "n";
      key = "<C-Down>";
      action = "<cmd>resize -2<cr>";
      options = {
        desc = "Decrease Window Height";
      };
    }
    {
      mode = "n";
      key = "<C-Left>";
      action = "<cmd>vertical resize -2<cr>";
      options = {
        desc = "Decrease Window Width";
      };
    }
    {
      mode = "n";
      key = "<C-Right>";
      action = "<cmd>vertical resize +2<cr>";
      options = {
        desc = "Increase Window Width";
      };
    }

    {
      key = "<leader>uw";
      action = "<cmd>set wrap!<cr>";
      options.desc = "Toggle word wrapping";
    }
    {
      key = "<leader> ";
      action = "<cmd>lua require('telescope.builtin').find_files()<cr>";
      options.desc = "Telescope";
    }
    {
      key = "<leader>sg";
      action = "<cmd>lua require('telescope.builtin').live_grep()<cr>";
      options.desc = "Livegrep";
    }
    {
      key = "<leader>sf";
      action = "<cmd>lua require('telescope.builtin').find_files()<cr>";
      options.desc = "Find Files";
    }
    {
      key = "<leader>sb";
      action = "<cmd>lua require('telescope.builtin').buffers()<cr>";
      options.desc = "Buffers";
    }
    {
      key = "<leader>sh";
      action = "<cmd>lua require('telescope.builtin').help_tags()<cr>";
      options.desc = "Help Tags";
    }
    {
      key = "<leader>sc";
      action = "<cmd>lua require('telescope.builtin').commands()<cr>";
      options.desc = "Commands";
    }
    {
      key = "<leader>sm";
      action = "<cmd>lua require('telescope.builtin').marks()<cr>";
      options.desc = "Marks";
    }
    {
      key = "<leader>so";
      action = "<cmd>lua require('telescope.builtin').oldfiles()<cr>";
      options.desc = "Oldfiles";
    }
    {
      key = "<leader>ss";
      action = "<cmd>lua require('telescope.builtin').spell_suggest()<cr>";
      options.desc = "Spell Suggest";
    }
    {
      key = "<leader>sr";
      action = "<cmd>:noh<return><esc>";
      options.desc = "Reset search";
    }
    {
      key = "<leader>st";
      action = "<cmd>TodoTelescope<cr>";
      options.desc = "Todos";
    }
    # Trouble
    {
      key = "<leader>tx";
      action = "<cmd>Trouble diagnostics toggle<cr>";
      options.desc = "Diagnostics (Trouble)";
    }
    {
      key = "<leader>tX";
      action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
      options.desc = "Buffer Diagnostics (Trouble)";
    }
    {
      key = "<leader>ts";
      action = "<cmd>Trouble symbols toggle focus=false<cr>";
      options.desc = "Symbols (Trouble)";
    }
    {
      key = "<leader>tl";
      action = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>";
      options.desc = "LSP Definitions / references / ... (Trouble)";
    }
    {
      key = "<leader>tL";
      action = "<cmd>Trouble loclist toggle<cr>";
      options.desc = "Location List (Trouble)";
    }
    {
      key = "<leader>tQ";
      action = "<cmd>Trouble qflist toggle<cr>";
      options.desc = "Quickfix List (Trouble)";
    }
    #window splitting
    {
      key = "<leader>ws";
      action = "<cmd>split<cr>";
      options.desc = "Split";
    }
    {
      key = "<leader>wv";
      action = "<cmd>vsplit<cr>";
      options.desc = "VSplit";
    }
    {
      key = "<leader>wd";
      action = "<cmd>close<cr>";
      options.desc = "Close";
    }
    # Code
    {
      key = "<leader>cd";
      action = "<cmd>lua vim.lsp.buf.definition()<cr>";
      options.desc = "LSP Definition";
    }
    {
      key = "<leader>cr";
      action = "<cmd>lua vim.lsp.buf.references()<cr>";
      options.desc = "LSP References";
    }
    {
      key = "<leader>ct";
      action = "<cmd>lua vim.lsp.buf.type_definition()<cr>";
      options.desc = "LSP Type Definition";
    }
    {
      key = "<leader>ca";
      action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
      options.desc = "LSP Code Action";
    }
    {
      key = "<leader>cf";
      action = "<cmd>lua vim.lsp.buf.formatting()<cr>";
      options.desc = "LSP Formatting";
    }
    {
      key = "<leader>cn";
      action = "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>";
      options.desc = "LSP Next Diagnostic";
    }
    {
      key = "<leader>cp";
      action = "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>";
      options.desc = "LSP Previous Diagnostic";
    }
    {
      key = "<leader>cu";
      action = "<cmd>lua require('dapui').toggle()<CR>";
      options.desc = "Toggle Dapui";
    }
    {
      key = "<leader>cb";
      action = "<cmd>lua require('dap').toggle_breakpoint()<CR>";
      options.desc = "Toggle breakpoint";
    }
  ];
}
