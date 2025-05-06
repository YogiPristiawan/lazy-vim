-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- vim.keymap.set("n", "gh", ":lua vim.lsp.buf.hover()<CR>", { desc = "Hover" })

-- Normal mode mappings
map("n", "<leader>a", ":TestSuite<CR>")
map("n", "<leader>t", ":TestNearest<CR>")
map("n", "<leader>T", ":TestFile<CR>")
map("n", "<leader>l", ":TestLast<CR>")
-- map("n", "<leader>g", ":TestVisit<CR>")
map("n", "<leader>cb", "<cmd>AerialToggle!<CR>")
map("n", "<leader>ct", "<cmd>AerialNavToggle<CR>")
map("i", "<C-e>", "<Esc>", { desc = "Exit insert mode" })
