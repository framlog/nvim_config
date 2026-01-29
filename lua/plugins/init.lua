-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        'b3nj5m1n/kommentary',
        event = { 'BufRead', 'BufNewFile' },
        config = require('plugins.kommentary').config,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        event = { 'BufRead' },
        config = require('plugins.indentline').config,
    },
    {
        'folke/lua-dev.nvim',
        lazy = true,
    },
    { "folke/tokyonight.nvim" },
    { "HiPhish/rainbow-delimiters.nvim" },
    {
        'NTBBloodbath/galaxyline.nvim',
        branch = 'main',
        event = { 'VimEnter' },
        config = function() require("galaxyline.themes.eviline") end,
        dependencies = { 'kyazdani42/nvim-web-devicons' },
    },
    { url = "https://codeberg.org/andyg/leap.nvim" },
    { "onsails/lspkind.nvim" },
    {
        'ur4ltz/surround.nvim',
        event = { 'BufRead', 'BufNewFile' },
        config = require('plugins.surround').config,
    },
    { 'kyazdani42/nvim-web-devicons' },
    { 'p00f/clangd_extensions.nvim' },
    {
        'kyazdani42/nvim-tree.lua',
        dependencies = { 'kyazdani42/nvim-web-devicons' },
        init = require('plugins.nvimtree').setup,
        config = require('plugins.nvimtree').config,
    },
    {
        'lewis6991/gitsigns.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require("gitsigns").setup()
        end,
    },
    {
        'sindrets/diffview.nvim',
        cmd = 'DiffviewOpen',
    },
    {
        'zsugabubus/crazy8.nvim',
        event = { 'BufRead' },
    },
    { 'amix/open_file_under_cursor.vim' },
    {
        'nvim-telescope/telescope.nvim',
        event = { 'VimEnter' },
        init = require('plugins.telescope').setup,
        config = require('plugins.telescope').config,
        dependencies = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
    },
    {
        'nvim-telescope/telescope-github.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' },
        config = function()
            require('telescope').load_extension 'gh'
        end,
    },
    {
        'romgrk/barbar.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons' },
    },
    { 'fatih/vim-go' },
    {
        'neovim/nvim-lspconfig',
        config = function() require 'plugins.lsp' end,
        dependencies = {
            { 'nvim-lua/lsp-status.nvim' },
            { 'nvim-lua/lsp_extensions.nvim' },
        },
    },
    { 'echasnovski/mini.nvim' },
    { 'echasnovski/mini.ai' },
    { 'echasnovski/mini.operators' },
    { 'echasnovski/mini.surround' },
    { 'echasnovski/mini.hues' },
    { 'echasnovski/mini.icons' },
    {
        'echasnovski/mini.completion',
        config = function()
            require('mini.completion').setup({})

            local imap_expr = function(lhs, rhs)
                vim.keymap.set('i', lhs, rhs, { expr = true })
            end

            imap_expr('<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
            imap_expr('<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        event = { 'BufRead', 'BufNewFile' },
        build = ':TSUpdate',
    },
    { "nvim-lua/plenary.nvim" },
    {
        'folke/todo-comments.nvim',
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require('todo-comments').setup {}
        end,
    },
    {
        "folke/trouble.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = function()
            require("trouble").setup {}
        end,
    },
    { 'mfussenegger/nvim-dap' },
    { 'psliwka/vim-smoothie' },
    { 'itchyny/vim-cursorword' },
    { 'vim-scripts/mru.vim' },
    {
        'ThePrimeagen/harpoon',
        branch = "harpoon2",
        event = { 'VimEnter' },
        init = require('plugins.harpoon').setup,
        config = require('plugins.harpoon').config,
    },
    {
        'kevinhwang91/nvim-bqf',
        event = { 'BufWinEnter quickfix' },
        config = require('plugins.quickfix').config,
    },
    { 'mrcjkb/rustaceanvim' },
    {
        'simrat39/symbols-outline.nvim',
        cmd = 'SymbolsOutline',
        init = require('plugins.outline').setup,
        config = require('plugins.outline').config,
    },
    {
        "coder/claudecode.nvim",
        lazy = false,
        priority = 1000,
        dependencies = { "folke/snacks.nvim", "nvim-lua/plenary.nvim" },
        config = function()
          require("claudecode").setup({
            terminal_cmd = "/home/dev/.local/bin/claude",
            auto_start = true,
            port_range = { min = 10000, max = 65535 },
            track_selection = true,
            visual_demotion_delay_ms = 50,
            terminal = {
              split_side = "left",
              split_width_percentage = 0.30,
              provider = "auto"
            },
          })

          -- Setup keymaps
          vim.keymap.set("n", "<leader>h", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude" })
          vim.keymap.set("n", "<leader>ac", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude" })
          vim.keymap.set("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>", { desc = "Focus Claude" })
          vim.keymap.set("n", "<leader>ar", "<cmd>ClaudeCode --resume<cr>", { desc = "Resume Claude" })
          vim.keymap.set("n", "<leader>aC", "<cmd>ClaudeCode --continue<cr>", { desc = "Continue Claude" })
          vim.keymap.set("n", "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", { desc = "Select Claude model" })
          vim.keymap.set("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Add current buffer" })
          vim.keymap.set("v", "<leader>as", "<cmd>ClaudeCodeSend<cr>", { desc = "Send to Claude" })
          vim.keymap.set("n", "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Accept diff" })
          vim.keymap.set("n", "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Deny diff" })
        end,
    }
})
