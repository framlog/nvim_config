return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use {
        'hrsh7th/nvim-compe',
        event = { 'InsertEnter' },
        config = require('plugins.compe').config,
    }
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
        'glepnir/galaxyline.nvim',
        branch = 'main',
        event = { 'VimEnter' },
        config = function() require 'plugins.statusline' end,
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use {
        'blackCauldron7/surround.nvim',
        event = { 'BufRead', 'BufNewFile' },
        config = require('plugins.surround').config,
    }
    use 'kyazdani42/nvim-web-devicons'
    use {
        'kyazdani42/nvim-tree.lua',
        cmd = { 'NvimTreeOpen', 'NvimTreeToggle' },
        setup = require('plugins.nvim_tree').setup,
        config = require('plugins.nvim_tree').config,
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function() 
            require('gitsigns').setup{}
        end
    }
    use { 'sindrets/diffview.nvim', opt = true, cmd = 'DiffviewOpen' }
    use { 'zsugabubus/crazy8.nvim', event = { 'BufRead' } } -- detect indentation automatically
    use 'amix/open_file_under_cursor.vim'
    use {
        'nvim-telescope/telescope.nvim',
        event = { 'VimEnter' },
        setup = require('plugins.telescope').setup,
        config = require('plugins.telescope').config,
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
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
    use {
        'steelsojka/pears.nvim',
        event = { 'BufRead' },
        config = require('plugins.pears').config,
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
    use 'vim-scripts/peaksea'
    use 'folke/tokyonight.nvim'
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
    use { 'simrat39/rust-tools.nvim', opt = true }
    use {
        'simrat39/symbols-outline.nvim',
        cmd = 'SymbolsOutline',
        setup = require('plugins.outline').setup,
        config = require('plugins.outline').config,
    }
end)
