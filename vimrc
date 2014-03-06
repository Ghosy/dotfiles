""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Title: Vimrc                                                 ""
"" Author: Ghosy                                                ""
"" Source: https://github.com/Ghosy/dotfiles/blob/master/vimrc  ""
""""Plugins---------{                                           ""
""""--Vundle                                                    ""
""""--NERDTree                                                  ""
""""--Buftabs                                                   ""
""""--Restore_View                                              ""
""""--TComment                                                  ""
""""--SuperTab                                                  ""
""""--Surround                                                  ""
""""--Solarized (Color Scheme)                                  ""
""""--Eclim                                                     ""
""""----------------}                                           ""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""Initial-----------------------------------------------------{

"startup for vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"Installs bundles
Bundle 'gmarik/vundle'
Bundle 'buftabs'
Bundle 'restore_view.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-surround'
Bundle 'altercation/vim-colors-solarized'

"""""------------------------------------------------------------}
"""""Appearance--------------------------------------------------{

colorscheme solarized "Sets colorscheme
filetype plugin indent on "Turns on indenting and plugins for specific filetypes
let g:solarized_termcolors=16 "Makes solarized use 16 colors for URxvt compatiblity
if has('syntax')
	syntax enable
	if &term == 'rxvt-unicode'
		set t_Co=16
	endif
endif
set background=dark "Sets the background of the colorscheme to dark
set number "Sets the line numbers visable
set cmdheight=2 "Sets the space at the bottom of the terminal 2 characters high
set cul " Highlights current line
set showmatch " Shows matching bracket
set list "Makes whitespace characters visable
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮ "Defines characters for whitespace
set hlsearch "Highlights the term searched
set foldtext=MyFoldText() "Sets template for foldtext
set viewoptions=cursor,folds,slash,unix "Saves view info for reloading later

"""""------------------------------------------------------------}
"""""Keybinds----------------------------------------------------{

"Maps leader to ,
let mapleader=","
"Easier movement to start of line
map H ^
"Easier movement to end of line
map L $
"Unbinds help from F1
map <F1> :echo<CR>
"Opens/closes NERDTree
map <F2> :NERDTreeToggle<CR>
"Easier buffer movement
noremap <F3> :bprev<CR>
noremap <F4> :bnext<CR>
"Keeps matching term in the center of the screen
nnoremap n nzzzv
nnoremap N Nzzzv
"Removes matches from screen
nnoremap <leader><space> :noh<CR>:call clearmatches()<CR>
"Binds for highlighting words
nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>
"Disables the arrow keys in normal and insert mode
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>
"Easier Writes
nmap <c-s> :w<CR>
vmap <c-s> <Esc><c-s>gv
imap <c-s> <Esc><c-s>

inoremap <silent><F5> :call SpellToggle()<CR>
map <silent><F5> :call SpellToggle()<CR>

nnoremap <space> <c-f>
nnoremap <space> <c-b>
"""""------------------------------------------------------------}
"""""Saving/Backup-----------------------------------------------{

set backup
set backupdir=~/.vim/backup "Sets backup directory outside of local directory
set directory=~/.vim/tmp "Sets temp directory outside of local directory
set autoread "Watch for file changes

"""""------------------------------------------------------------}
"""""Other/Unsorted----------------------------------------------{

set lazyredraw "Redraw only when it has to
set undolevels=1000 "1000 undos
set ttyfast "Gotta go fast
set foldmethod=manual
set ignorecase "Ignores caps in searches
set smartcase "Pays attention to caps you add only
set clipboard=unnamedplus " Allows for use of the system clipboard in Unix-based systems
set paste
set spelllang=en_us

"""""------------------------------------------------------------}
"""""Functions---------------------------------------------------{
"""""""Highlight Word--------------------------------------------{
"
" This mini-plugin provides a few mappings for highlighting words temporarily.
"
" Sometimes you're looking at a hairy piece of code and would like a certain
" word or two to stand out temporarily.  You can search for it, but that only
" gives you one color of highlighting.  Now you can use <leader>N where N is
" a number from 1-6 to highlight the current word in a specific color.

function! HiInterestingWord(n)
    " Save our location.
    normal! mz
    " Yank the current word into the z register.
    normal! "zyiw
    " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
    let mid = 86750 + a:n
    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(mid)
    " Construct a literal pattern that has to match at boundaries.
    let pat = '\V\<' . escape(@z, '\') . '\>'
    " Actually match the words.
    call matchadd("InterestingWord" . a:n, pat, 1, mid)
    " Move back to our original location.
    normal! `z
endfunction

hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195
"""""""----------------------------------------------------------}
"""""""FoldText--------------------------------------------------{

function! MyFoldText()
    let line = getline(v:foldstart)
    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart
    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')
    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction 

"""""""----------------------------------------------------------}
"""""""Spell Toggle----------------------------------------------{

function SpellToggle()
    if &spell == 1
        set nospell
    else
        set spell
    endif
endfunction

"""""""----------------------------------------------------------}
"""""------------------------------------------------------------}
