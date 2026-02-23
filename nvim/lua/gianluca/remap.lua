vim.g.mapleader = " "

-- File explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Muovi righe in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Join senza muovere il cursore
vim.keymap.set("n", "J", "mzJ`z")

-- Scroll centrato
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Ricerca centrata
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Incolla sopra selezione senza perdere il registro
vim.keymap.set("x", "<leader>P", [["_dP]])

-- Copia nella clipboard di sistema
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Cancella senza salvare nel registro
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Esc alternativo
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Quick replace parola sotto cursore
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
