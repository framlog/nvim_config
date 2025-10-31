vim.cmd [[packadd lsp-status.nvim]]

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(args.buf, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(args.buf, ...) end

    vim.api.nvim_buf_set_option(args.buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true, buffer=args.buf }
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

    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true)
    end
  end
})

vim.lsp.config('pylsp', {
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
})
vim.lsp.enable('pylsp')

vim.lsp.config('clangd', {
  cmd = {
        "clangd", "--background-index", "--header-insertion=iwyu",
        "--clang-tidy", "--suggest-missing-includes"
  },
  filetypes = {"c", "cpp", "objc", "objcpp"}
})
vim.lsp.enable('clangd')

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

local lspkind = require("lspkind")
lspkind.init({
  symbol_map = {
    Copilot = "",
  },
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})

vim.lsp.log.set_level(vim.log.levels.WARN)
