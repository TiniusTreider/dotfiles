-- Diagnostic keymaps
vim.keymap.set('n', ',e', vim.diagnostic.open_float, { silent = true, desc = "Open diagnostic float" })
vim.keymap.set('n', 'ge', function() vim.diagnostic.jump({ count = -1 }) end, { silent = true, desc = "Previous diagnostic" })
vim.keymap.set('n', 'gE', function() vim.diagnostic.jump({ count = 1 }) end, { silent = true, desc = "Next diagnostic" })
vim.keymap.set('n', ',q', vim.diagnostic.setloclist, { silent = true, desc = "Diagnostics to loclist" })

-- Buffer-local keymaps on LSP attach
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local function buf_map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
    end

    buf_map('n', 'gD', vim.lsp.buf.declaration, "Go to declaration")
    buf_map('n', 'gd', vim.lsp.buf.definition, "Go to definition")
    buf_map('n', 'K', vim.lsp.buf.hover, "Hover")
    buf_map('n', 'gi', vim.lsp.buf.implementation, "Go to implementation")
    buf_map('n', 's', vim.lsp.buf.signature_help, "Signature help")
    buf_map('i', ',s', vim.lsp.buf.signature_help, "Signature help")
    buf_map('n', ',wa', vim.lsp.buf.add_workspace_folder, "Add workspace folder")
    buf_map('n', ',wr', vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
    buf_map('n', ',wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "List workspace folders")
    buf_map('n', ',D', vim.lsp.buf.type_definition, "Type definition")
    buf_map('n', ',rn', vim.lsp.buf.rename, "Rename")
    buf_map('n', ',qf', vim.lsp.buf.code_action, "Code action")
    buf_map('n', 'gr', vim.lsp.buf.references, "References")
    buf_map('n', ',f', function() vim.lsp.buf.format({ async = true }) end, "Format")
  end,
})

-- Capabilities from cmp-nvim-lsp (applies to all servers)
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}

vim.lsp.config('*', {
  capabilities = capabilities,
})

-- clangd for C/C++
vim.lsp.config('clangd', {
  cmd = {
    "clangd",
    "--background-index",
    "--pch-storage=memory",
    "--all-scopes-completion",
    "--header-insertion=never",
    "--completion-style=detailed",
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_markers = { "compile_commands.json", ".clangd", ".git" },
})

-- Python
vim.lsp.config('pyright', {
  root_markers = { "pyrightconfig.json", "pyproject.toml", ".git" },
})

-- Lua (with nvim API awareness)
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
    },
  },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
})

-- Bash
vim.lsp.config('bashls', {
  root_markers = { ".git" },
})

-- Enable all configured servers
vim.lsp.enable({ 'clangd', 'pyright', 'lua_ls', 'bashls' })
