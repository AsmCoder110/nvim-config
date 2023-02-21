vim.o.mouse = 'a'
vim.o.guifont = 'FantasqueSansMono Nerd Font Mono:h17'
vim.o.guifontwide = 'Noto Color Emoji:h17'
vim.o.laststatus = 0
-- vim.cmd('GuiPopupmenu 0')
-- vim.cmd('GuiScrollBar 0')
vim.keymap.set("n", "<silent><RightMouse>", ":call GuiShowContextMenu()<CR>")
vim.keymap.set("i", "<C-BS>", "<C-w>")
