vim.o.laststatus     = 0
vim.o.filetype       = "on"
vim.o.number         = true
vim.o.expandtab      = true
vim.o.pumblend       = 20
vim.o.winblend       = 20
vim.o.relativenumber = true
vim.o.autochdir      = true
vim.o.termguicolors  = true
vim.o.linebreak      = true
vim.o.showbreak      = true
vim.o.showbreak      = "<<<"
vim.o.showmatch      = true
vim.o.ignorecase     = true
vim.o.smartcase      = true
vim.o.incsearch      = true
vim.o.autoindent     = true
vim.o.autoread       = true
vim.o.autowrite      = true
vim.o.undofile       = true
vim.o.splitbelow     = true
vim.o.splitright     = true
vim.o.hidden         = true
vim.o.swapfile       = false
vim.o.cursorline     = true
vim.o.tabstop        = 4
vim.o.shiftwidth     = 4
vim.o.undolevels     = 10000
vim.o.background     = "dark"
vim.o.pyxversion     = 3
vim.opt.completeopt    = { "menu", "menuone", "noselect", "preview", "longest" }

vim.g.surround_45    = "{{c1::\r}}"
vim.g.surround_46    = "\\(\r\\)"
vim.g.surround_47    = "[latex]\r[/latex]"
vim.g.netrw_preview  = 1

vim.cmd "au BufWrite * silent! mkview"
vim.cmd "au BufRead * silent! loadview"
vim.cmd "au BufWritePre * silent! %s/s+$//e"
vim.cmd("au BufWritePre *.js,*.css,*.html,*.lua,*.rs,*.cpp,*.c,*.mjs lua vim.lsp.buf.format()")

vim.cmd "hi CocUnderline gui=undercurl term=undercurl"
vim.cmd
"hi CocErrorHighlight ctermfg=red  guifg=#c4384b gui=undercurl term=undercurl"
vim.cmd
"hi CocWarningHighlight ctermfg=yellow guifg=#c4ab39 gui=undercurl term=undercurl"


vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})
