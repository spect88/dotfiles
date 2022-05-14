-- Set up which-key
local wk = require('which-key')
wk.setup({
  window = {
    border = "single",
    margin = { 0, 0, 1, 0 },
    padding = { 1, 1, 1, 1 },
  },
  layout = {
    height = { min = 10 },
  },
})

-- Set up LSP
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Enable formatting triggered by gq
  vim.api.nvim_buf_set_option(0, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')

  wk.register({
    ['<space>'] = {
      name = 'lsp',
      e = { vim.diagnostic.open_float, 'show diagnostic' },
      q = { vim.diagnostic.setqflist, 'diagnostics to quick fix list' },
      k = { vim.lsp.buf.signature_help, 'show signature help'},
      w = {
        name = 'workspace',
        a = { vim.lsp.buf.add_workspace_folder, 'add workspace folder' },
        r = { vim.lsp.buf.remove_workspace_folder, 'remove workspace folder' },
        l = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, 'list workspace folders' },
      },
      c = {
        name = 'change',
        a = { vim.lsp.buf.code_action, 'code action' },
        r = { vim.lsp.buf.rename, 'rename' },
      },
      f = { vim.lsp.buf.formatting, 'format code' },
    },
    g = {
      D = { vim.lsp.buf.declaration, 'go to declaration' },
      d = { vim.lsp.buf.definition, 'go to definition' },
      I = { vim.lsp.buf.implementation, 'go to implementation' },
      r = { vim.lsp.buf.references, 'find references' },
      T = { vim.lsp.buf.type_definition, 'go to type definition' },
    },
    ['[d'] = { vim.diagnostic.goto_prev, 'prev diagnostic' },
    [']d'] = { vim.diagnostic.goto_next, 'next diagnostic' },
    K = { vim.lsp.buf.hover, 'show hover info' },
  }, { mode = 'n', silent=true, buffer=0 })
end
local servers = { 'solargraph', 'tsserver', 'pyright' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup { on_attach = on_attach }
end

-- Bridge simple external tools to the LSP client
local null_ls = require('null-ls')
local sources = {
  -- null_ls.builtins.formatting.prettier, -- tsserver does that
  -- null_ls.builtins.diagnostics.rubocop, -- solargraph does that
  -- null_ls.builtins.formatting.rubocop -- solargraph does that
  null_ls.builtins.diagnostics.flake8
}
null_ls.setup({ sources = sources })

-- Set up snippets
require('luasnip.loaders.from_snipmate').lazy_load()

-- Set up telescope
require('telescope').load_extension('luasnip')

-- Set up treesitter
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'bash', 'css', 'dockerfile', 'fish', 'html', 'javascript', 'json',
    'lua', 'python', 'ruby', 'rust', 'scss', 'vim', 'yaml',
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['ac'] = '@class.outer',
        ['ab'] = '@block.outer',
        ['if'] = '@function.inner',
        ['ic'] = '@class.inner',
        ['ib'] = '@block.inner',
      },
    },
    swap = {
      enable = true,
      swap_previous = {
        ['[,'] = '@parameter.inner',
        ['[<'] = '@function.outer',
      },
      swap_next = {
        ['],'] = '@parameter.inner',
        [']<'] = '@function.outer',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
    },
  },
})
wk.register({
  a = {
    f = { 'function' },
    c = { 'class' },
    b = { 'block' },
  },
  i = {
    f = { 'function body' },
    c = { 'class body' },
    b = { 'block body' },
  },
}, { mode = 'o' })
wk.register({
  ['['] = {
    [','] = { 'swap with prev function arg' },
    ['<'] = { 'swap with prev method' },
    m = { 'prev function start' },
    ['['] = { 'prev class start' },
    M = { 'prev function end' },
    [']'] = { 'prev class end' },
  },
  [']'] = {
    [','] = { 'swap with next function arg' },
    ['<'] = { 'swap with next method' },
    m = { 'next function start' },
    [']'] = { 'next class start' },
    M = { 'next function end' },
    ['['] = { 'next class end' },
  },
})
