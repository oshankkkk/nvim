-- fallback keybindings if config falls
local function fallback_config()

    vim.lsp.set_log_level("debug")
    vim.g.mapleader = " "
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.ignorecase = true
    vim.opt.smartcase = true
    vim.opt.clipboard = "unnamedplus"
    -- keymaps
    vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

    vim.keymap.set("n", "<C-h>", "<C-w>h")
    vim.keymap.set("n", "<C-j>", "<C-w>j")
    vim.keymap.set("n", "<C-k>", "<C-w>k")
    vim.keymap.set("n", "<C-l>", "<C-w>l")

    vim.keymap.set("n", "<leader>q", ":q<CR>")
    vim.keymap.set("n", "<leader>w", ":w<CR>")
    vim.keymap.set("n", "<leader>wq", ":wq<CR>")

    vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
    vim.keymap.set("n", "<leader>bp", ":bprevious<CR>")
    vim.keymap.set("n", "<leader>bd", ":bdelete<CR>")
end

local ok, err = pcall(function()
vim.lsp.set_log_level("debug")
--vim.opt.rtp:append("/home/oshankodagoda/Projects/asmr.nvim")
--require("asmr").setup()
-- Onvim
-- relative line numbers and line numbers
vim.opt.number = true
vim.opt.relativenumber = true
--annoying line wrap
vim.opt.wrap = false

vim.opt_local.textwidth = 60
-- 4 spaces for tabs than 8
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
-- clipboard sync
vim.opt.clipboard = "unnamedplus"
-- when typing cmds ignore case
vim.opt.ignorecase = true
vim.opt.scrolloff = 999

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
--this says either vim.uv or vim.loop
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable",
    lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
require("lazy").setup(

    --it goes like setup({plugins},{options})
    {
        {
            "navarasu/onedark.nvim",
            priority = 1000,
            config = function()
                require("onedark").setup({ style = "darker" })
                require("onedark").load()
            end,
        },
        {
            'MeanderingProgrammer/render-markdown.nvim',
            dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
            -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
            -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
            ---@module 'render-markdown'
            ---@type render.md.UserConfig
            opts = {},
        },
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            lazy = true,              -- don't load immediately
            event = "BufReadPost",
            config = function()
                require("nvim-treesitter.config").setup({
                    ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
                    auto_install = true,
                    highlight = { enable = true },
                })
            end,
        },
        -- i dont need mason cause all my LSPs are inside nix-shells
        --mason 
        --{
        --    "mason-org/mason.nvim",
        --    opts = {
        --        ui = {
        --            icons = {
        --                package_installed = "✓",
        --                package_pending = "➜",
        --                package_uninstalled = "✗"
        --            }
        --        }
        --    },
        --    config = function()
        --        require("mason").setup()
        --    end,
        --},
        {
            "neovim/nvim-lspconfig",
        },
{
  "nvim-mini/mini.files",
  opts = {
    content = {
      filter = nil,
      highlight = nil,
      prefix = nil,
      sort = nil,
    },

    mappings = {
    close       = "q",
    go_in       = "<CR>",
    go_in_plus  = "l",    
    go_out      = "-",        
    go_out_plus = "h",
    reset       = "<BS>",
    reveal_cwd  = "@",
    show_help   = "g?",
    synchronize = "=",
    trim_left   = "<",
    trim_right  = ">",
  },

    options = {
      permanent_delete = true,
      use_as_default_explorer = true,
      lsp_timeout = 1000,
    },

    windows = {
      max_number = math.huge,
      preview = false,
      width_focus = 50,
      width_nofocus = 15,
      width_preview = 25,
    },
  },
},
        {
            "sphamba/smear-cursor.nvim",

            opts = {
                -- Smear cursor when switching buffers or windows.
                smear_between_buffers = true,

                -- Smear cursor when moving within line or to neighbor lines.
                -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
                smear_between_neighbor_lines = true,

                -- Draw the smear in buffer space instead of screen space when scrolling
                scroll_buffer_space = true,

                -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
                -- Smears and particles will look a lot less blocky.
                legacy_computing_symbols_support = false,

                -- Smear cursor in insert mode.
                -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
                smear_insert_mode = true,
            },
        },
        --neoscroll makes my eyes hurt
--        {
--            "karb94/neoscroll.nvim",
--            opts = {
--                mappings = {
--                    "<C-u>", "<C-d>",
--                    "<C-b>", "<C-f>",
--                    "<C-y>", "<C-e>",
--                    "zt", "zz", "zb",
--                },
--                hide_cursor = true,
--                stop_eof = true,
--                respect_scrolloff = false,
--                cursor_scrolls_alone = true,
--                duration_multiplier = 1.0,
--                easing = "linear",
--                pre_hook = nil,
--                post_hook = nil,
--                performance_mode = false,
--                ignored_events = {
--                    "WinScrolled",
--                    "CursorMoved",
--                },
--            },
--        },
--
        {
            'saghen/blink.cmp',
            -- optional: provides snippets for the snippet source
            dependencies = { 'rafamadriz/friendly-snippets' },

            version = '1.*',
            opts = {
               
                keymap = { preset = 'default' },

                appearance = {
                    nerd_font_variant = 'mono'
                },

                -- (Default) Only show the documentation popup when manually triggered
                completion = { documentation = { auto_show = true } },
                -- See the fuzzy documentation for more information
                fuzzy = { implementation = "prefer_rust_with_warning" }
            },
            opts_extend = { "sources.default" }
        }
        -- blink conifg end
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    { 
        install = { colorscheme = { "habamax" } },
        -- automatically check for plugin updates
        checker = { enabled = true },
    }
)

-- keymaps
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>e", function()
  vim.cmd("lua MiniFiles.open()")
end)
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>wq", ":wq<CR>")

vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>")
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>")

-- LSP
vim.lsp.enable("pyright")
vim.lsp.enable("lua_ls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("sqlls")
vim.lsp.enable("gopls")
vim.lsp.enable("clangd")
-- LSP keybindings
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Show References" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format Buffer" })

-- Diagnostic keybindings
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show Diagnostic" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostics to Location List" })
-- markdown linewrap
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
vim.opt.wrap = true
  end,
})
end)
-- run config with fallback
if not ok then
  fallback_config()

  vim.schedule(function()
    vim.notify(
      "Your main init.lua failed, so fallback config was loaded:\n\n" .. tostring(err),
      vim.log.levels.ERROR
    )
  end)
end
