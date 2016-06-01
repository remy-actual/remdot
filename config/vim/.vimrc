set encoding=utf-8
scriptencoding utf-8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""																PROLOGUE																	""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" auto reload .vimrc on write
" http://www.bestofvim.com/tip/auto-reload-your-vimrc/
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END
" make Vim behave in a more useful way with 'nocompatible'
set nocp
" Manage Vim plugins with Vundle
" required for Vundle init
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()	" add plugin commands after here
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Plugins
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-scriptease'
Plugin 'scrooloose/syntastic'
Plugin 'pangloss/vim-javascript'
Plugin 'chrisbra/csv.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'terryma/vim-expand-region'
Plugin 'rking/ag.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-surround'
" Plugin 'shougo/neocomplete.vim'
" Plugin 'shougo/neosnippet.vim'
" Plugin 'shougo/neosnippet-snippets'
Plugin 'fatih/vim-go'
Plugin 'mattn/emmet-vim'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-fugitive'
call vundle#end()		"keep Plugin commands before here, required

""" Following handled by Plugin Vim Sensible
""""" BEHAVIORS """""
" set autoindent
"" Enable File-type based indentation
" filetype plugin indent on
""" INSERT MODE """
"" auto insert current comment leader with 'enter' key
" set fo+=j
"" delete indent, eol, and start with 'backspace' key
" set bs=2
""" SEARCH MODE """
"" command-line completion operates in an enhanced mode; incremental search
" set wildmenu incsearch
"" extend command history
" set history=1000
""""" DISPLAY """""
"" always display status line; show commands
" set laststatus=2 showcmd

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""																MAIN																			""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""" KEY BINDINGS """""
set timeoutlen=600 "reduce window for key press sequences; default is 1000

"" File writes ""
" write to file with single kOBey press
noremap <F6> :w<CR>
" double-tap to write to file and exit
noremap <F6><F6> :x<CR>

"" Accessing Vim Documentation ""
" open help in vertical split window on the right
" with Ctrl+H
nnoremap <C-H> :vert bo help 
" search help for term under cursor
" with Shift+H
nnoremap <S-H> K

""" SOLARIZED """
"" Toggle between 'Light' and 'Dark' colorscheme
call togglebg#map('<F5>')

""" TAGBAR """
"" Toggle display ""
nmap <F3> :TagbarToggle<CR>

"" Timestamp ""
" Insert current timestamp in normal or insert mode
" use "Day MON DD 24:MM:SS YYYY" format
nnoremap <S-F7> "=strftime("%Y%m%d %T ")<CR>P
inoremap <S-F7> <C-R>=strftime("%Y%m%d %T ")<CR>
" use "           24:MM:SS     " (white space matching %c) format
nnoremap <F7> "=strftime("         %T ")<CR>P
inoremap <F7> <C-R>=strftime("         %T ")<CR>
" in "24:MM:SS" format
nnoremap <F8> "=strftime("%T ")<CR>P
inoremap <F8> <C-R>=strftime("%T ")<CR>
" in "YY:MM:DD" format
nnoremap <S-F8> "=strftime("%Y%m%d ")<CR>P
inoremap <S-F8> <C-R>=strftime("%Y%m%d ")<CR>

"" Map globalDouble Leader key to Space. ""
" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
let mapleader = "\<Space>"

" fuzzy search in working directory for files to open with CtrlP Plugin
let g:ctrlp_map = '<Leader>o'

""" SPLIT WINDOW VIEWS """
" horizontally split current buffer with Leader double-tap 't' 
nnoremap <Leader>s :split<CR>
" vertically split current buffer with Leader double-tap 'y' 
nnoremap <Leader>v :vsplit<CR>
" increase vertical split size
nnoremap <Leader>w <C-W>>
" decrease vertical split size
nnoremap <Leader>q <C-W><
" increase horizontal split size
nnoremap <Leader>W <C-W>+
" decrease horizontal split size
nnoremap <Leader>Q <C-W>-
" equalize all split sizes
nnoremap <Leader>e <C-W>=
" swap top/bottom or left/right split
nnoremap <Leader>r <C-W>R

""" NAVIGATION """

"" Line Position ""
" move to end of line with '-'
nnoremap - <End>
" Insert and append after last character in line with Leader '-'
nnoremap <Leader>- A
" Insert and prepend before first non-blank character at beginning of line
" with Leader '0'
nnoremap <Leader>0 I
" jump between paired characters
nnoremap ; %

"" EasyMotion Plugin ""
" with Space+m
nmap <Leader>m <Plug>(easymotion-prefix)
" trigger word motion 
" with Double Leader
nmap <Leader><Leader> <Plug>(easymotion-w)

" Navigate between windows
" jump down
nnoremap <Leader>j <C-W><C-J>
" jump up
nnoremap <Leader>k <C-W><C-K>
" jump right
nnoremap <Leader>l <C-W><C-L>
" jump left
nnoremap <Leader>h <C-W><C-H>

" Navigate between buffers
" last buffer
nnoremap <silent> <Leader><Leader>j :bl<CR>
" first buffer
nnoremap <silent> <Leader><Leader>k :bf<CR>
" next buffer
nnoremap <silent> <Leader><Leader>l :bn<CR>
" previous buffer
nnoremap <silent> <Leader><Leader>h :bp<CR> 

"" History ""
" map redo to <Leader> undo
nnoremap <Leader>u <C-R>
" go to [count] older cursor position in jump list
nnoremap <Leader>[ 
" go to [count] newer cursor position in jump list
nnoremap <Leader>] <Tab>

""" COPY AND PASTE """
" replace visual selection without yanking over default register
" http://superuser.com/questions/321547/how-do-i-replace-paste-yanked-text-in-vim-without-yanking-the-deleted-lines
vnoremap P "_dP
" use Space+p when replacing at end of line 
vnoremap p "_dp
" auto jump to end of text on paste
vmap <silent> y y`]
vmap <silent> p p`]
"" Access Mac OS X clipboard via pipe to system utilities
" cut current line to copy
nnoremap dd :.!pbcopy<CR>
" yank current line to copy
nnoremap yy :.w !pbcopy<CR><CR>
" paste into new line from copy
nnoremap pp :r !pbpaste<CR>

""" SEARCH """
" switch off highlighting of current search
" http://www.bestofvim.com/tip/switch-off-current-search/
nnoremap <silent> <Leader>n :noh<CR>

" search working directory files for word under cursor
" with Triple 's'
nnoremap sss :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

""""" BEHAVIORS """""
" switch buffers without writing to file
set hidden

" enable mouse scrolling and auto switch mode on mouse select; 
set mouse=a 

"" Command Completion ""
" When more than one match,
" list all matches and complete till longest common string.
set wildmode=list:longest
" directories and file types to ignore in completion
set wildignore+=*/tmp/*,*.so,*.swp,*.zip 

"" neocomplete Plugin ""
" enable on startup "
let g:neocomplete#enable_at_startup = 1
" use smartcase.
let g:neocomplete#enable_smart_case = 1
" minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
" increase limit for tag cache files to 16MB
let g:neocomplete#sources#tags#cache_limit_size = 16777216
" max completions
let g:neocomplete#max_list = 12
let g:neocomplete#max_keyword_width = 32


""" TEXT EXPANSION """
"" HTML and CSS with Emmet Plugin ""
" map Emmet plugin expansion to Tab key
" http://bling.github.io/blog/2013/07/21/smart-tab-expansions-in-vim-with-expression-mappings/
function! s:emmet_html_tab()
	let line = getline('.')
	if match(line, '<.*>') >= 0
		return "\<c-y>n"
	endif
	return "\<c-y>,"
endfunction

augroup plugins_emmet
	autocmd!
	autocmd FileType css,html,markdown,sass,scss imap <buffer><expr><S-Tab> <sid>emmet_html_tab()
augroup END


"" Visual Mode ""
" visually select increasingly larger regions of text
" https://github.com/terryma/vim-expand-region
" 'v' key to expand; 'Ctrl-V' to contract
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

"" Copy and Paste ""
" no line numbers in copy and paste;
" enable Mac OS X system clipboard with vim paste register;
" http://superuser.com/questions/356970/smooth-scrolling-for-vim-in-mac-terminal-iterm
set clipboard=unnamedplus
" Toggle paste mode
set pastetoggle=<F4>

"" Split Window Views ""
" put new split windows below the current one with 'splitbelow';
" put new split windows to the right of the current one with 'splitright'
set sb spr

"" Tabs and Indentation ""
" set tabstops and indentation to 2 columns wide
set expandtab smarttab tabstop=2 softtabstop=2 shiftwidth=2

"" 'formatoptions' ""
" add 'after' directory to runtime path; override vim 'formatoptions'
" do not add comment leader on new line with 'o'/'O' key
set rtp+=~/.vim/after/ftplugin/vim.vim
" remove a existing comment leader character when joining lines;
set fo+=r

"" Paired characters ""
" add angle brackets to 'matchpairs'
set mps+=<:>

""" SEARCH MODE """
" apply 'ignorecase' to search patterns with only lowercase;
" otherwise case-sensive with 'smartcase';
" dynamically 'hslight' search term found in file while typing
set ic scs hls

"" CtrlP ""
" Default to opening files in vertical split
let g:ctrlp_open_new_file = 'v'
" Set mode for local working directory
let g:ctrlp_working_path_mode = 'ra'
" Default to searching by file name instead of full path
let g:ctrlp_by_filename = 0
" Set persistent cache
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 1

"" ag command - The Silver Searcher ""
if executable('ag')
	" grep command uses ag
	set gp=ag\ --nogroup\ --nocolor\ --column
	set grepformat=%f:%l:%c%m

	" Use ag in CtrlP for listing files.
	" Lightning fast and respects .gitignore
	let g:ctrlp_user_command = 'ag %s -i -l --nocolor --nogroup --hidden
		\ --ignore .git
		\ --ignore .svn
		\ --ignore .hg
		\ --ignore .DS_Store
		\ --ignore "**/*.pyc"
		\ -g ""'
endif


""""" DISPLAY """""

" show line numbers; default to relative line numbers
set number rnu
" wrap lines visually; without inserting EOL; autowrap words; highlight column after 'textwidth'
" https://robots.thoughtbot.com/wrap-existing-text-at-80-characters-in-vim
" http://superuser.com/questions/249779/how-to-setup-a-line-length-marker-in-vim-gvim
set wrap colorcolumn=81

" enable syntax highlighting
syntax on
""  Whitespace ""
" toggle display of hidden characters 
nmap <silent> <leader>tt :set nolist!<CR>
" set display characters with 'listchars'
set lcs=tab:>-,trail:·,eol:$ list

"" vim-javascript Plugin ""
" Enables HTML/CSS syntax highlighting in your JavaScript file
let g:javascript_enable_domhtmlcss = 1

""" COLORSCHEME """
"" Solarized ""
set background=dark
colorscheme solarized

"" STATUSBAR """
" minimize command bar height;
set cmdheight=1

"" Vim-Airline ""
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
" Auto populate g:airline_symbols dictionary with powerline symbols
let g:airline_powerline_fonts = 1
" Enable buffers list at top of screen
let g:airline#extensions#tabline#enabled = 1

"" Syntastic ""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Enable tidy for HTML5, but only when you ask for it. 
let g:syntastic_html_tidy_exec = 'tidy'
let syntastic_mode_map = { 'passive_filetypes': ['html'] }

" Enable checkers by filetype
" let g:syntastic_sql_checkers = ['sqlint'] " default
let g:syntastic_text_checkers = ['atdtool']
let g:syntastic_vim_checkers = ['vint'] " vint instead of vimlint
" let g:syntastic_yaml_checkers = ['jsyaml'] " default

