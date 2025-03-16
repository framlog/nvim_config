vim.cmd [[packadd lsp-status.nvim]]

local nvim_lsp = require('lspconfig') local util = require "lspconfig/util"

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
  vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)

  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.document_formatting then
    vim.keymap.set("n", "<space>f", vim.lsp.buf.formatting, opts)
  elseif client.server_capabilities.document_range_formatting then
    vim.keymap.set("n", "<space>f", vim.lsp.buf.range_formatting, opts)
  end
end

nvim_lsp["pylsp"].setup{on_attach=on_attach, settings={
  pylsp = {
    plugins = {
        pycodestyle = {enabled = false},
        mccabe = {enabled = false},
        pyflakes = {enabled = false},
        mypy_ls = {enabled = true},
        pylsp_black = {enabled = true},
        pyls_isort = {enabled = true},
        pyls_flake8 = {
          enabled = true, 
          maxLineLength = 120
        },
    }
  }
}}
nvim_lsp["clangd"].setup{on_attach=on_attach, settings={
  clangd = {
    cmd = {
        "clangd", "--background-index", "--header-insertion=iwyu",
        "--clang-tidy", "--suggest-missing-includes"
    },
    filetypes = {"c", "cpp", "objc", "objcpp"}
  }
}}
nvim_lsp["gopls"].setup{on_attach=on_attach, settings={
  cmd = {"gopls", "serve"},
    filetypes = {"go", "gomod"},
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
}}
nvim_lsp["metals"].setup{on_attach=on_attach}

-- Configure LSP through rust-tools.nvim plugin.
-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration
local opts = {
  tools = {
    runnables = {
      use_telescope = true,
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  server = {
    -- on_attach is a callback called when the language server attachs to the buffer
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      local rt = require("rust-tools")
      vim.keymap.set('n', 'gh', rt.hover_actions.hover_actions, { buffer = bufnr })
      vim.keymap.set('n', '<space>ca', rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        -- enable clippy on save
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
}

require("rust-tools").setup(opts)

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

-- " Setup Completion
-- " See https://github.com/hrsh7th/nvim-cmp#basic-configuration
local cmp = require("cmp")

cmp.setup({
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    -- Add tab support
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ["<Tab>"] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end),
  },

  -- Installed sources
  sources = {
    { name = "copilot" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "buffer" },
  },
})

local lspkind = require("lspkind")
lspkind.init({
  symbol_map = {
    Copilot = "",
  },
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})

vim.lsp.log.set_level(vim.log.levels.WARN)
