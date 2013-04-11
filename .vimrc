execute pathogen#infect()

set nocompatible

set sw=2
set smarttab

set number
set ruler
syntax on

let mapleader = ','

" Set encoding
set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc

" Status bar
set laststatus=2

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

" NERDTree configuration
let NERDTreeIgnore=['\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

" Command-T configuration
let g:CommandTMaxHeight=20

" ZoomWin configuration
"map <Leader><Leader> :ZoomWin<CR>

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function s:setupWrapping()
  set wrap
  set wm=2
  set textwidth=72
endfunction

function s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Mm <CR>
endfunction

" make uses real tabs
au FileType make                                     set noexpandtab

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

au BufRead,BufNewFile *.txt call s:setupWrapping()

" make python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python  set tabstop=4 textwidth=79

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
"let g:syntastic_quiet_warnings=1
let g:syntastic_auto_loc_list=0

" Use modeline overrides
set modeline
set modelines=10

" Default color scheme
set t_Co=256
color jellybeans+

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

let $JS_CMD='node'
let g:JSLintHighlightErrorLine = 0

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

"puppet test switching - may want to encapsulate this for other projects if I find I need that
function! GoToTheImplementation()
    if exists("b:rails_root") && filereadable(b:rails_root . "/script/spec")
      if match( expand("%:p"), "spec" ) > -1
        exec(":A")
      endif
    else
      if match( expand("%:p"), "spec/unit" ) > -1
          let imp_file = substitute(expand("%:p"), "spec/unit", "lib/puppet", "")
          let imp_file = substitute(imp_file, '\(\w\+\)_spec.rb', '\1.rb', '')
          exec(":e ". imp_file)
      endif
    end
endfunc

function! GoToTheTest()
    if exists("b:rails_root") && filereadable(b:rails_root . "/script/spec")
      if match( expand("%:p"), "spec" ) <= 0
        exec(":A")
      endif
    else
      if match( expand("%:p"), "lib/puppet" ) > -1
          let test_file = substitute(expand("%:p"), "lib/puppet", "spec/unit", "")
          let test_file = substitute(test_file, '\(\w\+\).rb', '\1_spec.rb', '')
          exec(":e ". test_file)
      endif
    end
endfunc
map  <leader>gt      :call GoToTheTest()<CR>
map! <leader>gt <ESC>:call GoToTheTest()<CR>i
map  <leader>gi      :call GoToTheImplementation()<CR>
map! <leader>gi <ESC>:call GoToTheImplementation()<CR>i

" showing git diffs
map  <leader>sd      :w!<CR>:! git diff --color-words HEAD %<CR>
map! <leader>sd <ESC>:w!<CR>:! git diff --color-words HEAD %<CR>

function! RunSpec(args)
      let spec = "rspec"
      let cmd = ":!" . spec . ' ' . expand("%:p") . " -bcfd " . a:args
    execute cmd
endfunction

" run one rspec example or describe block based on cursor position
map <leader>t <ESC>:w<cr>:call GoToTheTest()<CR>:call RunSpec("-l " . <C-r>=line('.')<CR>)<CR>
" run full rspec file
map <leader>T <ESC>:w<cr>:call GoToTheTest()<CR>:call RunSpec("")<CR>

set textwidth=80
set colorcolumn=+1
let g:Powerline_symbols = 'fancy'

set foldmethod=indent
set nofoldenable

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
