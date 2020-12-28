" 保存vim立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" 定义快捷键的前缀:<Leader>
let mapleader=";"

" map命令
" 在map命令前加上前缀可以组合成几种不同的命令，表示在不同的Vim模式下生效。
" n    在普通模式 (normal) 下生效
" i    在插入模式 (insert) 下生效
" v    在可视化模式 (visual) 下生效
" c    在命令模式 (command-line) 下生效
" o    在命令等待时 (operator pending) 生效，比如输入d之后会等待输入下一个字符，可能是d或者数字
" un   删除键的映射
" nore 非递归 (non-recursive)，意思是将a 映射为b，b映射为c，输入a的时候不会被映射为c，而只会映射为b
" 以上前缀可以组合使用，比如 nnoremap，nunmap，vnoremap 等。不带前缀的map命令默认对 normal 模式和 visual 模式生效
" Vim :map 默认是递归映射模式
" eg: 括号匹配
" inoremap ( ()<Esc>i
" inoremap [ []<Esc>i
" inoremap { {}<Esc>i
" inoremap " ""<Esc>i
" Vim的 mapleader 变量对所有map映射命令起效，它的作用是将参数 <leader> 替换成 mapleader 变量的值。
" 如果 mapleader 变量没有设置，则用默认的反斜杠 \代替，因此Vim映射 :map <Leader>A oanother line<Esc> 等效于：:map \A oanother line<Esc>
" 如果设置了 mapleader 变量，例如 :let mapleader = ","，那么 :map <Leader>A oanother line<Esc> 就等效于： :map ,A oanother line<Esc>

" 插入行，但不进入插入模式
nmap oo o<Esc>k
nmap OO O<Esc>j

" 插件安装
" 自动安装vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ http://image.awesome-daryl.cn/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" 安装插件
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'dense-analysis/ale'
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()


" vim设置
" 不匹配vi模式
set nocompatible
" 显示行号
set nu
" 显示光标所在的当前行的行号，其他行都为相对于该行的相对行号
"set relativenumber
" 设置行宽
set textwidth=80
" 与许多文本编辑器不同，Vim 会区分实际行与屏幕行。当 wrap 设置被启用时 (缺省启用)，每个超出窗口宽度的文本行都会被回绕显示，以保证没有文本显示不出来
" 这样一来，文件中的一行也许会被显示为屏幕上的若干行。要想知道实际行与屏幕行之间的不同，最简单的方法是启用 number设置
" 启用后，以行号开头的行对应着一个实际行，它们会占据着屏幕上的一行或几行; 当一行文本为适应窗口宽度而回绕时，回绕行的前面则不会显示行号.
set wrap
" 只有遇到指定的符号（比如空格、连词号和其他标点符号），才发生折行，不会在单词内部折行
set linebreak "
" 指定折行处与编辑窗口的右边缘之间空出的字符数
set wrapmargin=2
" 左下角显示状态
set showmode
" 一般模式下在底部显示当前键入的指令
set showcmd
" 光标遇到圆括号、方括号、大括号时，自动高亮对应的另一个圆括号、方括号和大括号
set showmatch
" wildmode选项可以自定义命令行模式补全行为.
" 如果习惯用 bash shell 的方式工作，那么下面的设置会满足你的需要:
" set wildmode=longest,list
" 如果你习惯于 zsh shell提供的自动补全菜单，或许会想试试这个:
set wildmenu
set wildmode=full
" 当 wildmenu 选项被启用时，Vim 会提供一个补全导航列表，可以按 <Tab> 、<C-n> 或 <Right> 正向遍历其列表项，也可以用 <S-Tab>、<C-p> 或 <Left> 对其进行反向遍历
" vim 自身命令行模式智能补全
set wildmenu
" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler
" 高亮显示当前行/列
set cursorline
set cursorcolumn
" 开启文件类型侦测
filetype on
" 若filetype开启，检测完成后会触发FileType事件，可以结合autocmd命令为特定类型的文件应用个性化设置
" eg:
"   if has("autocmd")
"       autocmd FileType ruby setlocal ts=2 sts=2 sw=2 et
"       autocmd FileType jabascript setlocal ts=4 sts=4 sw=4 noet
"   endif
" 根据侦测到的不同类型加载对应的插件
filetype plugin on
" 自适应不同语言的智能缩进
filetype indent on
" 开启语法高亮功能
syntax enable
" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=2
" 设置自动缩进时制表符占用空格数
set shiftwidth=2
" 继承前一行的缩进方式，适用于多行注释
set autoindent
" 粘贴模式 在Vim中通过鼠标右键粘贴时会在行首多出许多缩进和空格
" 通过set paste可以在插入模式下粘贴内容时不会有任何格式变形、胡乱缩进等问题,但是换行自动缩进失效了，因此关闭
" set paste
" 设置 Vim 内部使用的字符编码，应用于缓冲区、寄存器、表达式所用的字符
set encoding=utf-8
" 设置一个字符编码的列表，表示 Vim 自动检测文件编码时的备选字符编码列表
set fileencodings=utf-8,ucs-bom,gb18030,gb2312,cp936
" 输出到终端时采用的编码类型
set termencoding=utf-8
" 显示tab和空格
" set listchars=tab:>-,trail:-
" 开启真彩色支持 mac 与 windows 目前使用gruvbox配色，均已开启
set termguicolors
" hlsearch 用于设置将搜索结果高亮显示，而 incsearch 选项会让 Vim 根据已经在查找域中输入的文本，预览第一处匹配目标；每当新输入一个字符时，Vim 会即时更新预览内容
set hlsearch
set incsearch
" 当 ignorecase 和 smartcase 选项均打开时，如果搜索模式中包含大写字母，Vim就会认为当前的查找(搜索)是区分大小写的。如果搜索模式中不包含任何大写字母，Vim 则会认为搜索应该不区分大小写。这是个比较 ”智能的” 推测你搜索意图的机制
set ignorecase
set smartcase
" 解决插入模式下delete/backspce键失效问题
set backspace=2
" fix starting with REPLACE mode in wsl, put end of .vimrc
if $TERM =~ 'xterm-256color'
   set noek
endif


" 插件设置
" 设置主题
set background=dark
colorscheme gruvbox
" 设置NEEDTree
" q                关闭 NERDTree
" o                在已有窗口中打开文件或目录，并将光标跳到该窗口
" O                递归打开选中 结点下的所有目录
" x                合拢选中结点的父目录
" X                递归 合拢选中结点下的所有目录
" P                跳到根结点
" p                跳到父结点
" u                设置上级目录为根路径
" U                设置上级目录为跟路径，但是维持原来目录打开的状态
" r                刷新光标所在的目录
" R                刷新当前根路径
" I                显示或者不显示隐藏文件
" f                打开和关闭文件过滤器
" A                全屏显示 NERDTree，或者关闭全屏
" C                将根路径设置为光标所在的目录
"    隐藏NEEDTree
nmap <C-n> :NERDTreeToggle<CR>
"    设置NERDTree子窗口宽度
let NERDTreeWinSize=28
"    设置NERDTree子窗口位置
let NERDTreeWinPos="left"
"    显示隐藏文件
let NERDTreeShowHidden=1
"    NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
"    删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1
"    当窗口只剩下NEEDTree时 直接退出
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"    自动打开
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" 设置nedtree-git-plugin
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" 设置ale
let g:airline#extensions#ale#enabled = 1
"let g:ale_completion_enabled = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier'],
\   'json': ['prettier'],
\   'vue': ['prettier'],
\   'html': ['prettier'],
\   'css': ['prettier'],
\   'c': ['clang-format'],
\   'cpp': ['clang-format']
\}
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_column_always = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <C-f>  :ALEFix<CR>

" 设置ctrlp.vim
" Esc 或 <Ctrl-c> 可退出ctrlp，返回到Vim窗口中
" F5 用于刷新当前操作路径下的文件缓存，可以使用命令 let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp' 设置缓存文件存放路径
" <Ctrl-k> 和 <Ctrl-j> 在模糊搜索结果列表中上下移动 (当然也可以使用键盘上的上下方向键)
" <Ctrl-f> 和 <Ctrl-b> 在查找文件模式、查找缓冲区模式、查找MRU文件几种模式间进行切换 (cycle between modes)
" <Ctrl-d> 在 路径匹配 和 文件名匹配 之间切换 (switch to filename search instead of full path) ，可以通过设置 let g:ctrlp_by_filename = 1 来设置默认使用 文件名匹配 模式进行模糊搜索
" <Ctrl-r> 在 字符串模式 和 正则表达式模式 之间切换 (switch to regexp mode)
" <Ctrl-t> 在新的Vim标签页中打开文件 (open the selected entry in a new tab)
" <Ctrl-v> 垂直分割窗口打开文件
" <Ctrl-x> 水平分割窗口打开文件
" <Ctrl-p> 或` 选择前或后一条历史记录
" <Ctrl-y> 用于当搜索的目标文件不存在时创建文件及父目录 (create a new file and its parent directories)
" <Ctrl-z> 标记或取消标记多个文件， 标记多个文件后可以使用 <Ctrl-o> 同时打开多个文件 (mark/unmark multiple files and to open them)
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn))|(node_modules)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
