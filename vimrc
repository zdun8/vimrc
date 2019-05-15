"Piotr Zdunek VIMRC file
"============================================= PLUGINS =====================================
if &compatible
set nocompatible               " Be iMproved
endif

"prohibits running scripts from vimrc
set secure

"plugins used 
"git clone https://github.com/scrooloose/nerdtree
"git clone https://github.com/majutsushi/tagbar
"git clone https://github.com/vim-airline/vim-airline
"git clone https://github.com/Valloric/YouCompleteMe
"git clone https://github.com/justinmk/vim-syntax-extra
"git clone https://github.com/junegunn/fzf.vim
"git clone git://github.com/tpope/vim-endwise.git
"git clone https://github.com/mileszs/ack.vim
"git clone https://github.com/rhysd/vim-clang-format
"============================================= STYLE =====================================

"mark line 110 in color
set colorcolumn=120
highlight ColorColumn ctermbg=darkgray

" use indentation of previous line
set autoindent

" use intelligent indentation for C
set smartindent

" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces
set softtabstop=4

" wrap lines at 120 chars. 80 is somewhat antiquated with nowadays displays.
set textwidth=120

" turn syntax highlighting on
set t_Co=256
syntax on

" turn line numbers on
set number

" highlight matching braces
set showmatch

" how many tenths of a second to blink when matching brackets
set mat=2

vnoremap <leader>p "_dP

"filetype detection
augroup project
autocmd!
autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
augroup END

"setting to use tabs in makefiles instead of spaces
autocmd FileType make setlocal noexpandtab

" disable vi compatibility (emulation of old bugs)
set nocompatible

" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */

" smartabs
set smarttab

colorscheme desert 

" wildmenu
set wildmenu

"ignore compiled files
set wildignore=*.o.*~

"set ruler - current position
set ruler

" auto read when file is modified from outside
set autoread

" disable vi compatibility (emulation of old bugs)
set nocompatible
"highlight search results
set hlsearch

"for ctags plugin
filetype on

map <C-s> :w<CR>

nnoremap <silent> <F8> :TagbarToggle<CR>
nnoremap <silent> <F10> :NERDTreeToggle<CR>

"go back to insert mode
:imap jj <ESC>

"save file with capital W
:imap :W<CR> :w<CR>

"for the airbar so that it shows up after opening a file
set laststatus=2 

"block arrow keys
noremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>


"------------------ PLUGINS ------------------"
"fzf 
" If installed using git
set rtp+=~/.fzf


" This is the default extra key bindings
let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }

" Default fzf layout
    " - down / up / left / right
    let g:fzf_layout = { 'down': '~40%' }

" Customize fzf colors to match your color scheme
    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
        \ 'bg':      ['bg', 'Normal'],
        \ 'hl':      ['fg', 'Comment'],
        \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
        \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
        \ 'hl+':     ['fg', 'Statement'],
        \ 'info':    ['fg', 'PreProc'],
        \ 'border':  ['fg', 'Ignore'],
        \ 'prompt':  ['fg', 'Conditional'],
        \ 'pointer': ['fg', 'Exception'],
        \ 'marker':  ['fg', 'Keyword'],
        \ 'spinner': ['fg', 'Label'],
        \ 'header':  ['fg', 'Comment'] }

        " Enable per-command history.
        " CTRL-N and CTRL-P will be automatically bound to next-history and
        " previous-history instead of down and up. If you don't like the change,
        " explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
        let g:fzf_history_dir = '~/.local/share/fzf-history'
        "Command-local options
        " [Buffers] Jump to the existing window if possible
        let g:fzf_buffers_jump = 1

        " [[B]Commits] Customize the options used by 'git log':
        "let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s
        "%C(black)%C(bold)%cr"'

        " [Tags] Command to generate tags file
        let g:fzf_tags_command = 'ctags -R'

        " [Commands] --expect expression for directly executing the command
        let g:fzf_commands_expect = 'alt-enter,ctrl-x'


        " Fix files with prettier, and then ESLint.
        let b:ale_fixers = ['cppcheck', 'clang-format','clang-tidy']
        " Equivalent to the above.
        let b:ale_fixers = {'c': ['cppcheck', 'clang-format','clang-tidy']}

        let g:ale_lint_on_text_changed = 'never'
        let g:ale_lint_on_save = 1
        let g:ale_lint_on_enter = 0

        syn region MySkip contained start="^\s*#\s*\(if\>\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*#\s*endif\>" contains=MySkip

        let g:CommentDefines = ""

        hi link MyCommentOut2 MyCommentOut
        hi link MySkip MyCommentOut
        hi link MyCommentOut Comment

        map <silent> ,a :call AddCommentDefine()<CR>
        map <silent> ,x :call ClearCommentDefine()<CR>

function! AddCommentDefine()
    let g:CommentDefines = "\\(" . expand("<cword>") . "\\)"
    syn clear MyCommentOut
    syn clear MyCommentOut2
    exe 'syn region MyCommentOut start="^\s*#\s*ifdef\s\+' . g:CommentDefines . '\>" end=".\|$"
    contains=MyCommentOut2'
    exe 'syn region MyCommentOut2 contained start="' . g:CommentDefines . '"
    end="^\s*#\s*\(endif\>\|else\>\|elif\>\)" contains=MySkip'
    endfunction

function! ClearCommentDefine()
    let g:ClearCommentDefine = ""
    syn clear MyCommentOut
    syn clear MyCommentOut2
    endfunction
