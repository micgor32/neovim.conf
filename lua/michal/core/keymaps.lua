vim.g.mapleader = " "

local keymap = vim.keymap
local builtin = require("telescope.builtin")
keymap.set("n", "<leader>sf", builtin.find_files, {})
keymap.set("n", "<leader>sg", builtin.live_grep, {})
keymap.set("n", "<leader>sb", builtin.buffers, {})
keymap.set("n", "<leader>sh", builtin.help_tags, {})
-- keymaps

keymap.set("n", "<leader>nn", ":nohl<CR>")

-- inc/dec
keymap.set("n", "<leader>+", "<C-a>")
keymap.set("n", "<leader>-", "<C-x>")

-- moving
keymap.set("n", "<leader>h", "<C-w>h")
keymap.set("n", "<leader>l", "<C-w>l")
keymap.set("n", "<leader>j", "<C-w>j")
keymap.set("n", "<leader>k", "<C-w>k")

-- windows
keymap.set("n", "<leader>v", "<C-w>v")
keymap.set("n", "<leader>nh", "<C-w>s")
keymap.set("n", "<leader>e", "<C-w>=")
keymap.set("n", "<leader>x", ":close<CR>")

-- tabs
keymap.set("n", "<leader>n", ":tabnew<CR>")
-- keymap.set("n", "<leader>to", ":tabnew<CR>")
-- keymap.set("n", "<leader>tx", ":tabclose<CR>")
-- keymap.set("n", "<leader>tn", ":tabn<CR>")
-- keymap.set("n", "<leader>tp", ":tabp<CR>")

-- nvimtree
keymap.set("n", "<leader>f", ":NvimTreeToggle<CR>")

-- java tests
keymap.set("n", "<leader>t", ":TestNearest<CR>")
keymap.set("n", "<leader>tc", ":TestClass<CR>")
keymap.set("n", "<leader>tp", ":Mvn test-compile org.pitest:pitest-maven:mutationCoverage<CR>")

-- todo
keymap.set("n", "<leader>td", ":TodoQuickFix<CR>")

-- git automatisation
keymap.set("n", "<leader>ga", ":Git add *<CR>")
keymap.set("n", "<leader>gc", ":Git commit<CR>")
keymap.set("n", "<leader>gp", ":Git push<CR>")
keymap.set("n", "<leader>pp", ":Git pull<CR>")
