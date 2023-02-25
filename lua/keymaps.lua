vim.keymap.set("i", "<C-h>", "<Plug>luasnip-expand-or-jump")
vim.keymap.set("i", "<C-j><C-s>", "<C-o>:w<cr>")
vim.keymap.set("i", "<C-BS>", "<C-w>")

vim.keymap.set("n", "L", "Lzz")
vim.keymap.set("n", "H", "Hzz")
vim.keymap.set("n", "G", "Gzz")

vim.keymap.set("n", "<Esc><Esc>", ":noh<cr>")
vim.keymap.set("n", "<C-j><C-s>", ":w<cr>")

vim.keymap.set("n", "<F6>",
               ":Dispatch browser-sync start --server --files '*.js, *.html, *.css'<CR>")

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

-- nvim-treesitter-textobjects

local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- Make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
