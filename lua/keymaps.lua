vim.keymap.set("i", "<C-h>", "<Plug>luasnip-expand-or-jump")
vim.keymap.set("i", "<C-j><C-s>", "<C-o>:w<cr>")
vim.keymap.set("i", "<C-BS>", "<C-w>")

vim.keymap.set("n", "L", "Lzz")
vim.keymap.set("n", "H", "Hzz")
vim.keymap.set("n", "G", "Gzz")

vim.keymap.set("n", "<Esc><Esc>", ":noh<cr>")
vim.keymap.set("n", "<C-j><C-s>", ":w<cr>")

vim.keymap.set("n", "<F6>", ":Dispatch browser-sync start --server --files '*.js, *.html, *.css'<CR>")

vim.keymap.set("n", "<leader>d", ":bd<CR>")
vim.keymap.set("n", "<leader>l",
    ":lua require('lazy.util').float_term(nil, { cwd = vim.fn.getcwd(), })<CR>")

vim.keymap.set("x", "Y", ":w !wl-copy<CR><CR>")

-- Trouble.nvim
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
               { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
               { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
               { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
               { silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
               { silent = true, noremap = true }
)
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
               { silent = true, noremap = true }
)
