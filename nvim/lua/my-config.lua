require('nvim-web-devicons').setup({
 default = true,
})
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

-- Set up diagnostics
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = false,
    close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
    border = 'rounded',
    source = 'always',
    prefix = ' ',
  },
})

-- Set up LSP
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Enable formatting triggered by gq
  vim.api.nvim_buf_set_option(0, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')

  local diagnostics_on = true
  local toggle_diagnostics = function()
    diagnostics_on = not diagnostics_on
    if diagnostics_on then
      vim.diagnostic.show()
    else
      vim.diagnostic.hide()
    end
  end
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
    ['yop'] = { toggle_diagnostics, 'toggle diagnostics' },
    K = { vim.lsp.buf.hover, 'show hover info' },
  }, { mode = 'n', silent=true, buffer=0 })

  -- auto-open diagnostic float
  vim.api.nvim_create_autocmd('CursorHold', {
    buffer = bufnr,
    callback = function()
      vim.diagnostic.open_float(nil, { scope = 'cursor' })
    end
})
end
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = { 'solargraph', 'tsserver', 'pyright' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
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

-- Set up completion
local lspkind = require('lspkind')
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  completion = {
    autocomplete = false,
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      menu = {
        nvim_lsp = "[lsp]",
        nvim_lua = "[lua]",
        path = "[path]",
        luasnip = "[snip]",
        buffer = "[buf]",
      },
    }),
  },
  window = {
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'path', options = { trailing_slash = true } },
    { name = 'luasnip' },
  }, {
    { name = 'buffer', keyword_length = 5 },
  }),
  experimental = {
    ghost_text = true,
  },
})
wk.register({
  ['<C-x><C-o>'] = { cmp.complete, 'trigger completion' },
}, { mode = 'i' })
