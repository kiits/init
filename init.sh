#!/bin/bash

sudo yum -y install tmux
cat>~/.tmux.conf<<EOF
unbind-key C-b
set-option -g prefix C-a
bind-key C-a last-window # 方便切换，个人习惯
bind-key a send-prefix
# shell下的Ctrl+a切换到行首在此配置下失效，此处设置之后Ctrl+a再按a即可切换至she l行首

# reload settings # 重新读取加载配置文件
bind R source-file ~/.tmux.conf \; display-message "Config reloaded..."

# Ctrl-Left/Right cycles thru windows (no prefix)
# 不使用prefix键，使用Ctrl和左右方向键方便切换窗口
bind-key -n "C-Left" select-window -t :-
bind-key -n "C-Right" select-window -t :+

# displays
bind-key * list-clients

set -g default-terminal "screen-256color"   # use 256 colors
set -g display-time 5000                    # status line messages display
# set -g status-utf8 on                       # enable utf-8
# set-option -g status-utf8 on
set -g history-limit 100000                 # scrollback buffer n lines
setw -g mode-keys vi                        # use vi mode

# start window indexing at one instead of zero 使窗口从1开始，默认从0开始
set -g base-index 1

# key bindings for horizontal and vertical panes
unbind %
bind | split-window -h      # 使用|竖屏，方便分屏
unbind '"'
bind - split-window -v      # 使用-横屏，方便分屏

# window title string (uses statusbar variables)
set -g set-titles-string '#T'

#set-option -g repeat-time 1000             #控制台激活后的持续时间；设置合适的时间以避免每次操作都要先激活控制台，单位为毫秒

# status bar with load and time
set -g status-bg blue
set -g status-fg '#bbbbbb'
set -g status-left-fg green
set -g status-left-bg blue
set -g status-right-fg green
set -g status-right-bg blue
set -g status-left-length 90
set -g status-right-length 90
set -g status-left '[#(whoami)]'
set -g status-right '[#(date +" %m-%d %H:%M ")]'
set -g status-justify "centre"
set -g window-status-format '#I #W'
set -g window-status-current-format ' #I #W '
setw -g window-status-current-bg blue
setw -g window-status-current-fg green
bind  k resize-pane -U 5
bind  j resize-pane -D 5
bind  h resize-pane -L 5
bind  l resize-pane -R 5
#bind-key -r    C-Up resize-pane -U
#bind-key -r  C-Down resize-pane -D
#bind-key -r  C-Left resize-pane -L
#bind-key -r C-Right resize-pane -R

# 设置标签自动重命名
set-option -g allow-rename off

# pane border colors
set -g pane-active-border-fg '#55ff55'
set -g pane-border-fg '#555555'
EOF

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cat>~/.vimrc<<EOF
set nocompatible              " required
filetype off                  " required
set pastetoggle=<F12>
syntax enable
colorscheme desert " 设定配色方案
set number " 显示行号
set autoindent

" 注释的颜色
hi comment ctermfg=6 

" set hlsearch " 搜索时高亮显示被找到的文本
"映射
""
nnoremap <space> za




"映射
""

"设置折叠
"设置折叠
" filetype plugin indent on " 开启插件
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" 插件写在这之间
" Plugin 'tmhedberg/SimpylFold'
" Plugin 'nvie/vim-flake8'
" Bundle "vim-scripts/taglist.vim" "感觉不好用
Plugin 'VundleVim/Vundle.vim'
" Bundle "vim-syntastic/syntastic" "打开py文件太慢是跳转和检错的插件
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
" Bundle "tomasr/molokai"
" Bundle "majutsushi/tagbar"
" Bundle "scrooloose/nerdtree"
" Bundle 'Valloric/YouCompleteMe'
" Plugin 'Valloric/YouCompleteMe'
"  安装插件
"  :BundleInstall
"  # 更新插件
"  :BundleUpdate
"  # 清除不需要的插件
"  :BundleClean
"  # 列出当前的插件
"  :BundleList
"  # 搜索插件
"  :BundleSearch

" 插件写在这之间 
call vundle#end()

" supertab settings
let g:SuperTabDefaultCompletionType = 'context'

" required
"网上
" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible

" Highlight current line
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn
highlight cursorcolumn ctermbg=103

" Leader
let mapleader = ","

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set confirm       " Need confrimation while exit
set fileencodings=utf-8,gb18030,gbk,big5

" " Switch syntax highlighting on, when the terminal has colors
" " Also switch on highlighting the last used search pattern.
" if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
"   syntax on
" endif
" 
" if filereadable(expand("~/.vimrc.bundles"))
"   source ~/.vimrc.bundles
" endif
" 
" filetype plugin indent on
" 
" 
" " Softtabs, 2 spaces
" set tabstop=4
" set shiftwidth=4
" set shiftround
" set expandtab
" 
" " Display extra whitespace
" set list listchars=tab:»·,trail:·
" 
" " Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
" if executable('ag')
"   " Use Ag over Grep
"   set grepprg=ag\ --nogroup\ --nocolor
" 
"   " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
"   let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" 
"   " ag is fast enough that CtrlP doesn't need to cache
"   let g:ctrlp_use_caching = 0
" endif
" 
" " Color scheme
" " colorscheme molokai
" highlight NonText guibg=#060606
" highlight Folded  guibg=#0A0A0A guifg=#9090D0
" 
" " Make it obvious where 80 characters is
" " set textwidth=80
" set colorcolumn=+1
" 
" " Numbers
" set number
" set numberwidth=5
" 
" " " Tab completion
" " " will insert tab at beginning of line,
" " " will use completion if not at beginning
" " set wildmode=list:longest,list:full
" " function! InsertTabWrapper()
" "     let col = col('.') - 1
" "     if !col || getline('.')[col - 1] !~ '\k'
" "         return "\<tab>"
" "     else
" "         return "\<c-p>"
" "     endif
" " endfunction
" " inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
" " inoremap <S-Tab> <c-n>
" 
" " Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
" let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"
" 
" " Index ctags from any project, including those outside Rails
" map <Leader>ct :!ctags -R .<CR>
" 
" " Switch between the last two files
" nnoremap <leader><leader> <c-^>
" 
" " Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>
" 
" " vim-rspec mappings
" nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
" nnoremap <Leader>s :call RunNearestSpec()<CR>
" nnoremap <Leader>l :call RunLastSpec()<CR>
" 
" " Run commands that require an interactive shell
" nnoremap <Leader>r :RunInInteractiveShell<space>
" 
" " Treat <li> and <p> tags like the block tags they are
" let g:html_indent_tags = 'li\|p'
" 
" " Open new split panes to right and bottom, which feels more natural
" set splitbelow
" set splitright
" 
" " Quicker window movement
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-h> <C-w>h
" nnoremap <C-l> <C-w>l
" 
" " configure syntastic syntax checking to check on open as well as save
" let g:syntastic_check_on_open=1
" let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
" 
" autocmd Syntax javascript set syntax=jquery " JQuery syntax support
" 
" set matchpairs+=<:>
" "set statusline+=%{fugitive#statusline()} "  Git Hotness
" 
" " Nerd Tree
" let NERDChristmasTree=0
" let NERDTreeWinSize=40
" let NERDTreeChDirMode=2
" let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
" let NERDTreeShowBookmarks=1
" let NERDTreeWinPos="right"
" autocmd vimenter * if !argc() | NERDTree | endif " Automatically open a NERDTree if no files where specified
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif " Close vim if the only window left open is a NERDTree
" nmap <F5> :NERDTreeToggle<cr>
" 
" " Emmet
" let g:user_emmet_mode='i' " enable for insert mode
" 
" " Search results high light
" set hlsearch
" 
" " nohlsearch shortcut
" nmap -hl :nohlsearch<cr>
" nmap +hl :set hlsearch<cr>
" 
" " Javascript syntax hightlight
" syntax enable
" 
" " ctrap
" set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux"
" let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
" 
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
" 
" " RSpec.vim mappings
" map <Leader>t :call RunCurrentSpecFile()<CR>
" map <Leader>s :call RunNearestSpec()<CR>
" map <Leader>l :call RunLastSpec()<CR>
" map <Leader>a :call RunAllSpecs()<CR>
" 
" " Vim-instant-markdown doesn't work in zsh
" set shell=bash\ -i
" 
" " Snippets author
" let g:snips_author = 'Yuez'
" 
" " Local config
" if filereadable($HOME . "/.vimrc.local")
"   source ~/.vimrc.local
" endif
" 
" 
" 
" 
" " 自己
" set backupcopy=yes " 设置备份时的行为为覆盖
" set ignorecase smartcase " 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感
" " set nowrapscan " 禁止在搜索到文件两端时重新搜索
" " set incsearch " 输入搜索内容时就显示搜索结果
" set hlsearch " 搜索时高亮显示被找到的文本
set ts=4  "(注：ts是tabstop的缩写，设TAB宽4个空格)
set expandtab
set softtabstop=4
set shiftwidth=4
" 
" 
" " Tagbar
" let g:tagbar_width=35
" let g:tagbar_autofocus=1
" nmap <F6> :TagbarToggle<CR>
EOF

#vim
#:PluginInstall

sudo yum install git
sudo yum -y install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# vim ~/.zshrc
# ZSH_THEME="ys"
cat>>~/.zshrc<<EOF
# session history not share
setopt noincappendhistory
setopt nosharehistory

function grf(){
grep -r \$1 ./
}

function fgg(){
fg %\$1
}
EOF
