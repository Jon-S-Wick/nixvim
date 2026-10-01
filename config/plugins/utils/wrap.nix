{
  # Marks the start of every soft wrapped continuation row, so it is obvious
  # that the line continues instead of actually starting there.
  extraConfigLua = ''
    vim.api.nvim_set_hl(0, "LineWrap", { link = "Comment", default = true })

    local wrap_ns = vim.api.nvim_create_namespace("nixvim_line_wrap")

    local function mark_wrapped_lines()
      local buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_clear_namespace(buf, wrap_ns, 0, -1)

      if not vim.wo.wrap then
        return
      end

      -- The window is not the whole editor, and it also carries the number and
      -- sign columns, so only `winwidth` of it is available for text.
      local width = vim.fn.winwidth(0) - 1

      for lnum = vim.fn.line("w0"), vim.fn.line("w$") do
        local line = vim.api.nvim_buf_get_lines(buf, lnum - 1, lnum, false)[1]
        if line and not line:match("^%s*$") and vim.fn.strdisplaywidth(line) > width then
          vim.api.nvim_buf_set_extmark(buf, wrap_ns, lnum - 1, 0, {
            virt_lines = { { { "↪ ", "LineWrap" } } },
            virt_lines_above = true,
          })
        end
      end
    end

    vim.api.nvim_create_augroup("nixvim_line_wrap", { clear = true })
    vim.api.nvim_create_autocmd({
      "BufWinEnter",
      "WinEnter",
      "WinScrolled",
      "CursorMoved",
      "CursorMovedI",
      "TextChanged",
      "TextChangedI",
      "VimResized",
    }, {
      group = "nixvim_line_wrap",
      callback = mark_wrapped_lines,
    })
  '';
}