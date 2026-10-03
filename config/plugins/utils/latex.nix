{ pkgs, ... }:
{
  plugins = {
    vimtex = {
      enable = true;

      settings = {
        compiler_method = "latexmk";
        view_method = "zathura";
      };

    # scheme-small already ships the engines (pdflatex, xelatex, lualatex),
    # latex-dev, bibtex and makeindex; the rest are the packages that are
    # commonly reached for while writing papers. Anything \usepackage'd in a
    # document MUST be listed here or kpathsea will not find the .sty and
    # the compile dies at the first \usepackage line.
    texlivePackage = pkgs.texlive.withPackages (
      ps: with ps; [
        scheme-small
        latexmk
        latexindent
        chktex
        biber
        biblatex
        microtype
        geometry
        hyperref
        unicode-math
        enumitem
        xcolor
        etoolbox
        booktabs
        mathtools
        siunitx
        fontspec
        polyglossia
        natbib
        caption
        float
        listings
        tabularray
        titlesec
        fancyhdr
        todonotes
        pgfplots
        # resume / cover letter templates
        lipsum
        blindtext
        ulem
        fontawesome5
        eso-pic
        paracol
        changepage
        needspace
        lastpage
        datetime
        lato
      ]
    );

    };
  };

  extraConfigLua = ''
    local vimtex_maps = {
      { "<leader>lc", "\\ll", "LaTeX: compile document" },
      { "<leader>lb", "\\llb", "LaTeX: compile document (background)" },
      { "<leader>lv", "\\lv", "LaTeX: view PDF" },
      { "<leader>lr", "\\lr", "LaTeX: refresh PDF view" },
      { "<leader>lk", "\\lk", "LaTeX: kill compilation" },
      { "<leader>ld", "\\llc", "LaTeX: delete auxiliary files" },
      { "<leader>lo", "\\lo", "LaTeX: clean output files" },
      { "<leader>lw", "\\lt", "LaTeX: toggle line wrap" },
      { "<leader>lf", "\\lf", "LaTeX: toggle current section fold" },
      { "<leader>lF", "\\zf", "LaTeX: fold current section" },
      { "<leader>lm", "\\lim", "LaTeX: toggle inline math" },
      { "<leader>lx", "\\lx", "LaTeX: clear cache" },
    }

    vim.api.nvim_create_augroup("nixvim_latex_keys", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = "nixvim_latex_keys",
      pattern = { "tex", "plaintex" },
      callback = function(ev)
        for _, map in ipairs(vimtex_maps) do
          vim.keymap.set("n", map[1], "<cmd>" .. map[2] .. "<cr>", {
            buffer = ev.buf,
            silent = true,
            desc = map[3],
          })
        end
      end,
    })
  '';
}
