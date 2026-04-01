-- Comma as leader (must be set before lazy.nvim loads plugins)
vim.g.mapleader = ","

-- Load plugins via lazy.nvim
require('plugins')

-- Spectre (search and replace)
require('spectre').setup({
  live_update = true,
  ['run_replace'] = {
    map = "<leader>l",
    cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
    desc = "replace all",
  },
  find_engine = {
    ['rg'] = {
      cmd = "rg",
      args = {
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--pcre2',
      },
      options = {
        ['ignore-case'] = {
          value = "--ignore-case",
          icon = "[I]",
          desc = "ignore case",
        },
        ['hidden'] = {
          value = "--hidden",
          desc = "hidden file",
          icon = "[H]",
        },
      },
    },
  },
})

-- Load legacy vimscript options
vim.cmd('so ' .. vim.fn.stdpath('config') .. '/legacy.vim')

-- LSP and completion
require('mylsp')
require('nvimcmp')

-- lsp_signature.nvim
require("lsp_signature").setup({
  hint_prefix = "",
  floating_window = false,
  bind = true,
})

-- Lualine
require('lualine').setup{
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
}

-- Autopairs
require('nvim-autopairs').setup{}

-- nvim-dap: lldb for C/C++ (Arch: pacman -S lldb)
local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = 'lldb-dap',
  name = 'lldb',
}

dap.configurations.c = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}
dap.configurations.cpp = dap.configurations.c
