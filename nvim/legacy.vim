" enable history for fzf
let g:fzf_history_dir = '~/.local/share/fzf-history'

" easy-motion
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

nmap .s <Plug>(easymotion-overwin-f)
nmap .d <Plug>(easymotion-overwin-f2)
nmap .g <Plug>(easymotion-overwin-w)
nmap .t <Plug>(easymotion-tl)
nmap .f <Plug>(easymotion-fl)

let g:EasyMotion_startofline = 1

nmap .j <Plug>(easymotion-j)
nmap .k <Plug>(easymotion-k)
nmap ./ <Plug>(easymotion-overwin-line)
nmap .a <Plug>(easymotion-jumptoanywhere)

" faster updates!
set updatetime=100

" no hidden buffers
set nohidden

" actual clipboard
set clipboard=unnamedplus

" history (auto-create undodir)
let s:undodir = expand('~/.cache/nvim/undodir')
if !isdirectory(s:undodir)
  call mkdir(s:undodir, 'p')
endif
let &undodir = s:undodir
set undofile

" automatically read on change
set autoread

" ;t is trim
nnoremap <silent> ;t :Trim<CR>

" easy search
nnoremap ;s :s/

" easy search/replace with current visual selection
xnoremap ;s y:%s/<C-r>"//g<Left><Left>

" easy search/replace on current line with visual selection
xnoremap ;ls y:.s/<C-r>"//g<Left><Left>

" ;w is save
noremap <silent> ;w :update<CR>

" ;f formats in normal mode
noremap <silent> ;f gg=G``:w<CR>

let g:lion_squeeze_spaces = 1

" no folds, ever
set foldlevelstart=99

" rainbow parens
let g:rainbow_active = 1

let c_no_curly_error=1

" C/C++ settings
autocmd BufRead,BufNewFile *.c,*.h setlocal colorcolumn=80 | SetTab 8
autocmd BufRead,BufNewFile *.cpp,*.hpp setlocal colorcolumn=80 | SetTab 8
au FileType cpp setlocal formatprg=clang-format | setlocal equalprg=clang-format
au FileType c setlocal formatprg=clang-format | setlocal equalprg=clang-format
set cino=(0,W4

" switch between h/c and hpp/cpp
au BufEnter,BufNew *.c nnoremap <silent> ;p :e %<.h<CR>
au BufEnter,BufNew *.h nnoremap <silent> ;p :e %<.c<CR>
au BufEnter,BufNew *.cpp nnoremap <silent> ;p :e %<.hpp<CR>
au BufEnter,BufNew *.hpp nnoremap <silent> ;p :e %<.cpp<CR>

" Use ripgrep as grep
set grepprg=rg\ --vimgrep\ --smart-case\ --follow


" Disable C-z from job-controlling neovim
nnoremap <c-z> <nop>

" Close all floating windows
nnoremap <silent> <c-k> <cmd>lua for _, win in ipairs(vim.api.nvim_list_wins()) do if vim.api.nvim_win_get_config(win).relative ~= '' then vim.api.nvim_win_close(win, true) end end<CR>

" Remap C-c to <esc>
nmap <c-c> <esc>
imap <c-c> <esc>
vmap <c-c> <esc>
omap <c-c> <esc>

" HJKL arrow navigation in insert mode
imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>

" Syntax highlighting
syntax on

" Position in code
set number
set ruler

" Don't make noise
set visualbell

" default file encoding
set encoding=utf-8

" Line wrap
set wrap

" C-p: FZF find files
nnoremap <silent> <C-p> :Files<CR>

" C-g: FZF ('g'rep)/find in files
nnoremap <silent> <C-g> :Rg<CR>

" <leader>l: find and replace with nvim-spectre
nnoremap <silent> <leader>l :lua require('spectre').open()<CR>

" <leader>g: find and replace in current file
nnoremap <silent> <leader>g viw:lua require('spectre').open_file_search()<CR>

" <leader>s: outline
nnoremap <silent> <leader>s :Outline<CR>

" Function to set tab width to n spaces
function! SetTab(n)
  let &tabstop=a:n
  let &shiftwidth=a:n
  let &softtabstop=a:n
  set expandtab
  set autoindent
  set smartindent
endfunction

command! -nargs=1 SetTab call SetTab(<f-args>)

set noexpandtab
set autoindent
set smartindent

" Function to trim extra whitespace in whole file
function! Trim()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

command! -nargs=0 Trim call Trim()

set laststatus=2

" Highlight search results
set hlsearch
set incsearch

" Binary files -> xxd
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END

" Mouse support
set mouse=a

" disable backup files
set nobackup
set nowritebackup

set shortmess+=c
set signcolumn=yes

" show syntax group of symbol under cursor
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" nvim-dap bindings
nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <Leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>
