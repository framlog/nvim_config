return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use {
        'b3nj5m1n/kommentary',
        event = { 'BufRead', 'BufNewFile' },
        config = require('plugins.kommentary').config,
    }
    use {
        'lukas-reineke/indent-blankline.nvim',
        event = { 'BufRead' },
        config = require('plugins.indentline').config,
    }
    use {
        'folke/lua-dev.nvim',
        opt = true
    }
    use { "folke/tokyonight.nvim" }
    use { "HiPhish/rainbow-delimiters.nvim" }
    use {
        'NTBBloodbath/galaxyline.nvim',
        branch = 'main',
        event = { 'VimEnter' },
        config = function() require("galaxyline.themes.eviline") end,
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use {
        'ggandor/leap.nvim',
        config = function() require("leap").set_default_keymaps() end
    }
    use { "onsails/lspkind.nvim" }
    use { 
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({})
        end,
    }
    use {
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua" },
        config = function ()
            require("copilot_cmp").setup()
        end
    }
    use {
        'ur4ltz/surround.nvim',
        event = { 'BufRead', 'BufNewFile' },
        config = require('plugins.surround').config,
    }
    use 'kyazdani42/nvim-web-devicons'
    use 'p00f/clangd_extensions.nvim'
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        setup = require('plugins.nvimtree').setup,
        config = require('plugins.nvimtree').config,
    }
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }
    use { 'sindrets/diffview.nvim', opt = true, cmd = 'DiffviewOpen' }
    use { 'zsugabubus/crazy8.nvim', event = { 'BufRead' } } -- detect indentation automatically
    use 'amix/open_file_under_cursor.vim'
    use {
        'nvim-telescope/telescope.nvim',
        event = { 'VimEnter' },
        setup = require('plugins.telescope').setup,
        config = require('plugins.telescope').config,
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}, {'BurntSushi/ripgrep'}}
    }
    use {
        'nvim-telescope/telescope-github.nvim',
        after = { 'telescope.nvim' },
        config = function()
            require('telescope').load_extension 'gh'
        end,
    }
    use {
        'romgrk/barbar.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }
    use 'fatih/vim-go'
    use {
        'neovim/nvim-lspconfig',
        config = function() require 'plugins.lsp' end,
        requires = {
            { 'nvim-lua/lsp-status.nvim', opt = true },
            { 'nvim-lua/lsp_extensions.nvim', opt = true },
        },
    }
    use 'hrsh7th/nvim-cmp'
    use({
        -- cmp LSP completion
        "hrsh7th/cmp-nvim-lsp",
        -- cmp Snippet completion
        "hrsh7th/cmp-vsnip",
        -- cmp Path completion
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        after = { "hrsh7th/nvim-cmp" },
        requires = { "hrsh7th/nvim-cmp" },
    })
    use {
        'nvim-treesitter/nvim-treesitter',
        event = { 'BufRead', 'BufNewFile' },
        requires = {
            {
                'nvim-treesitter/nvim-treesitter-refactor',
                after = 'nvim-treesitter',
            },
            {
                'nvim-treesitter/nvim-treesitter-textobjects',
                after = 'nvim-treesitter',
            },
        },
        run = ':TSUpdate',
        config = require('plugins.treesitter').config
    }
    use 'rust-lang/rust.vim'
    use {
        'folke/todo-comments.nvim',
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require('todo-comments').setup {}
        end,
    }
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {}
        end
    }
    use 'mfussenegger/nvim-dap'
    use 'psliwka/vim-smoothie'
    use 'itchyny/vim-cursorword'
    use 'vim-scripts/mru.vim'
    use {
        'ThePrimeagen/harpoon',
        branch = "harpoon2",
        opt = true,
        event = { 'VimEnter' },
        setup = require('plugins.harpoon').setup,
        config = require('plugins.harpoon').config,
    }
    use {
        'kevinhwang91/nvim-bqf',
        opt = true,
        event = { 'BufWinEnter quickfix' },
        config = require('plugins.quickfix').config,
    }
    use { 'simrat39/rust-tools.nvim' }
    use {
        'simrat39/symbols-outline.nvim',
        cmd = 'SymbolsOutline',
        setup = require('plugins.outline').setup,
        config = require('plugins.outline').config,
    }
end)
