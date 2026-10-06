{
  # Marks the start of every soft wrapped continuation row, so it is obvious
  # that the line continues instead of actually starting there. showbreak
  # prefixes each wrapped row, putting the arrow on the wrapped portion.
  extraConfigLua = ''
    vim.wo.showbreak = "↪ "
  '';
}
