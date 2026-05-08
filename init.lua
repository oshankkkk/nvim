-- fallback config if the main breaks
local function fallback_config()
  vim.lsp.set_log_level("debug")

  vim.g.mapleader = " "
  vim.g.maplocalleader = "\\"

  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.ignorecase = true
  vim.opt.smartcase = true
  vim.opt.clipboard = "unnamedplus"

  vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
  vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "Open netrw" })

  vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
  vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
  vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
  vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

  vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
  vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Write" })
  vim.keymap.set("n", "<leader>wq", ":wq<CR>", { desc = "Write and quit" })

  vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
  vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
  vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

  vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", {
    desc = "Clear search highlight",
    silent = true,
  })
end

local ok, err = xpcall(function()
  require("mycolorpencils")
end, debug.traceback)

if not ok then
  fallback_config()

  vim.schedule(function()
    vim.notify(
      "main-config.lua failed, fallback config loaded:\n\n" .. tostring(err),
      vim.log.levels.ERROR,
      {
        title = "Neovim fallback config",
      }
    )
  end)
end

