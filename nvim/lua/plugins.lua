-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Colorscheme
  {
    "morhetz/gruvbox",
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      vim.g.gruvbox_contrast_dark = 'hard'
      vim.g.gruvbox_contrast_light = 'hard'
      vim.cmd('colorscheme gruvbox')
    end,
  },

  -- Tim Pope essentials
  { "tpope/vim-surround" },
  { "tpope/vim-commentary" },
  { "tpope/vim-dispatch" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-abolish" },

  -- Fuzzy finder
  { "junegunn/fzf" },
  { "junegunn/fzf.vim" },

  -- Search and replace
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- LSP
  { "neovim/nvim-lspconfig" },
  { "ray-x/lsp_signature.nvim" },

  -- Completion
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/nvim-cmp" },
  {
    "SirVer/ultisnips",
    init = function()
      vim.g.UltisnipsExplandTrigger = '<f13>'
      vim.g.UltisnipsJumpForwardTrigger = '<f14>'
      vim.g.UltisnipsJumpBackwardTrigger = '<f15>'
    end
  },
  { "quangnguyen30192/cmp-nvim-ultisnips" },
  { "honza/vim-snippets" },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "python", "bash" },
      })
    end,
  },

  -- UI
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    config = function()
      require("outline").setup()
    end,
  },
  { "luochen1990/rainbow" },

  -- Editing
  { "ntpeters/vim-better-whitespace" },
  { "windwp/nvim-autopairs" },
  { "sbdchd/neoformat" },
  { "RRethy/vim-illuminate" },
  { "tommcdo/vim-lion" },
  { "easymotion/vim-easymotion" },

  -- Debugging
  { "mfussenegger/nvim-dap" },

  -- Git
  { "sindrets/diffview.nvim" },
})

