set nocompatible

" OS判定フラグ
let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_mac = !s:is_windows && !s:is_cygwin
      \ && (has('mac') || has('macunix') || has('gui_macvim')
      \ || (!executable('xdg-open') && system('uname') =~? '^darwin'))

" 言語指定
if s:is_windows
  " For Windows.
  language messages ja_JP
elseif s:is_mac
  " For Mac.
  language messages ja_JP.UTF-8
  language ctype ja_JP.UTF-8
  language time ja_JP.UTF-8
else
  " For Linux.
  language messages C
endif


"--------------------------------
"neobundle.vim設定
"--------------------------------
filetype off

if has("win32") || has("win64")
	set rtp+=~/vimfiles/neobundle.vim.git/ 
	call neobundle#rc(expand('~/vimfiles/bundle'))
else
	set rtp+=~/.vim/neobundle.vim.git/ 
	call neobundle#rc(expand('~/.vim/bundle'))
endif

NeoBundle 'Shougo/unite.vim'
NeoBundle 'osyo-manga/unite-quickfix'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/wwwrenderer-vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'vim-scripts/Align'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'rhysd/clever-f.vim'

function! s:meet_neocomplete_requirements()
    return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
endfunction

if s:meet_neocomplete_requirements()
    NeoBundle 'Shougo/neocomplete.vim'
    NeoBundleFetch 'Shougo/neocomplcache.vim'
else
    NeoBundleFetch 'Shougo/neocomplete.vim'
    NeoBundle 'Shougo/neocomplcache.vim'
endif

NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \     'windows' : 'make -f make_mingw32.mak',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }

NeoBundleLazy 'Shougo/vimshell', {
    \ 'autoload' : {
    \     'commands' : ['VimShell', 'VimShellSendString', 'VimShellCurrentDir'],
    \     }
    \ }

NeoBundleLazy 'Shougo/vimfiler', {
    \ 'depends' : 
    \     ['Shougo/unite.vim'],
    \ 'autoload' : {
    \     'commands' : ['VimFiler', 'VimFilerCurrentDir',
    \                   'VimFilerBufferDir', 'VimFilerSplit',
    \                   'VimFilerExplorer']
    \     }
    \ }

NeoBundleLazy 'sgur/vim-gitgutter', {
    \ 'depends' : 
    \     ['Shougo/vimproc'],
    \ 'autoload' : {
    \     'commands' : ['GitGutterToggle', 'GitGutterLineHighlightsToggle']
    \     }
    \ }


NeoBundleLazy 'sgur/vim-gitgutter', {
    \ 'autoload' : {
    \     'commands' : ['GitGutterToggle', 'GitGutterLineHighlightsToggle']
    \     }
    \ }

NeoBundleLazy 'basyura/twibill.vim'
NeoBundleLazy 'basyura/TweetVim', {
    \ 'depends' :
    \     ['basyura/twibill.vim',
    \      'tyru/open-browser.vim'],
    \ 'autoload' : {
    \     'commands' :
    \         ['TweetVimHomeTimeline',
    \          'TweetVimMentions',
    \          'TweetVimSay',
    \          'TweetVimUserTimeline',
    \          'TweetVimUserStream']
    \     }
    \ }

"color scheme
NeoBundleLazy 'w0ng/vim-hybrid'

filetype plugin indent on



"---------------------------------------------------------------------------
" Encoding: "{{{

set encoding=utf-8

scriptencoding utf-8


" https://github.com/Shougo/shougo-s-github
" termencoding 
if !has('gui_running')
  if &term ==# 'win32' &&
        \ (v:version < 703 || (v:version == 703 && has('patch814')))
    " Setting when use the non-GUI Japanese console.

    " Garbled unless set this.
    set termencoding=cp932
    " Japanese input changes itself unless set this.  Be careful because the
    " automatic recognition of the character code is not possible!
    set encoding=japan
  else
    if $ENV_ACCESS ==# 'linux'
      set termencoding=euc-jp
    elseif $ENV_ACCESS ==# 'colinux'
      set termencoding=utf-8
    else  " fallback
      set termencoding=  " same as 'encoding'
    endif
  endif
elseif s:is_windows
  " For system.
  set termencoding=cp932
endif
"}}}

" The automatic recognition of the character code."{{{
if !exists('did_encoding_settings') && has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'

  " Does iconv support JIS X 0213?
  if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213,euc-jp'
    let s:enc_jis = 'iso-2022-jp-3'
  endif

  " Build encodings.
  let &fileencodings = 'ucs-bom'
  if &encoding !=# 'utf-8'
    let &fileencodings = &fileencodings . ',' . 'ucs-2le'
    let &fileencodings = &fileencodings . ',' . 'ucs-2'
  endif
  let &fileencodings = &fileencodings . ',' . s:enc_jis

  if &encoding ==# 'utf-8'
    let &fileencodings = &fileencodings . ',' . s:enc_euc
    let &fileencodings = &fileencodings . ',' . 'cp932'
  elseif &encoding =~# '^euc-\%(jp\|jisx0213\)$'
    let &encoding = s:enc_euc
    let &fileencodings = &fileencodings . ',' . 'utf-8'
    let &fileencodings = &fileencodings . ',' . 'cp932'
  else  " cp932
    let &fileencodings = &fileencodings . ',' . 'utf-8'
    let &fileencodings = &fileencodings . ',' . s:enc_euc
  endif
  let &fileencodings = &fileencodings . ',' . &encoding

  unlet s:enc_euc
  unlet s:enc_jis

  let did_encoding_settings = 1
endif
"}}}

if has('kaoriya')
  " For Kaoriya only.
  set fileencodings=guess
endif

" When do not include Japanese, use encoding for fileencoding.
function! s:ReCheck_FENC() "{{{
  let is_multi_byte = search("[^\x01-\x7e]", 'n', 100, 100)
  if &fileencoding =~# 'iso-2022-jp' && !is_multi_byte
    let &fileencoding = &encoding
  endif
endfunction "}}}

augroup ReCheckFenc
	autocmd!
    autocmd BufReadPost * call s:ReCheck_FENC()
augroup END



set fileformat=unix
set fileformats=unix,dos,mac

" □や◯文字があってもカーソル位置がずれないように
" Win版Kaoriyaではautoが使用可能
if &ambiwidth !=# 'auto'
  set ambiwidth=double
endif


 "----------------------------------------
 "システム設定
 "----------------------------------------
 "エラー時の音とビジュアルベルの抑制。
 set noerrorbells
 set novisualbell
 set visualbell t_vb=


"--------------------------------------
"その他設定
"--------------------------------------
"折り返し無し
set nowrap

"tabを半角スペースに展開
set expandtab
augroup ettext
	autocmd!
	autocmd BufRead,BufNewFile *.asp,*inc,*.htm set noexpandtab
augroup END

"tab挿入時の空白数
set tabstop=4
"オートインデント時に挿入される空白数
set shiftwidth=4

"ヤンクでクリップボードへ
set clipboard=unnamed

"常にタブを表示
set showtabline=2

"自動改行無効
set formatoptions=q

"自動改行OFF
" set textwidth=0

" 検索時に大文字小文字を無視
set ignorecase
" 大文字が入力されたときはignorecaseをoff
set smartcase

"escキーをCtl+jに割り当て
map <C-j> <esc>
imap <C-j> <esc>

"行番号表示
set number

"自動バックアップファイルのパス
set backupdir=~/dotfiles/vimbkup
let &directory = &backupdir

"C言語スタイルのインデント
set cindent

"コマンドラインの高さ
set cmdheight=2

"runtime path
set runtimepath+=$HOME/vimfiles

"Escの2回押しでハイライト消去
nmap <ESC><ESC> :nohlsearch<CR><ESC>

"grepをackにする
set grepprg=ack
" "grep後にquickfixを開く
" augroup grepOpen
  " autocmd!
  " autocmd QuickfixCmdPost grep cw
" augroup END


"マウス中クリックでペースト機能無効化
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>


"visualモードで削除時にレジスタに入れないキーマッピング
xnoremap bx "_x

"ペースト時にヤンクしない
vnoremap <silent> <C-p> "0p<CR>

"タブ操作キーマッピング 
nnoremap [tabcmd]  <Nop>
nmap     <leader>t [tabcmd]

nnoremap <silent> [tabcmd]f :<C-u>tabfirst<CR>
nnoremap <silent> [tabcmd]l :<C-u>tablast<CR>
nnoremap <silent> [tabcmd]e :<C-u>tabedit<CR>
nnoremap <silent> [tabcmd]c :<C-u>tabclose<CR>
nnoremap <silent> [tabcmd]o :<C-u>tabonly<CR>
nnoremap <silent> [tabcmd]s :<C-u>tabs<CR>
"現在のタブを指定タブ位置へ移動
nnoremap [tabcmd]m :<C-u>tabmove<Space>
"指定タブへ移動
nnoremap [tabcmd]n :<C-u>tabnext<Space>


"カレントディレクトリ設定
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>') 
function! s:ChangeCurrentDir(directory, bang)
  if a:directory == ''
	lcd %:p:h
	else
	execute 'lcd' . a:directory
  endif
	
  if a:bang == ''
	pwd
  endif
endfunction

" Change current directory.
nnoremap <silent> <Leader>cd :<C-u>CD<CR>


"diffオプション
set diffopt=vertical
"diffsplit
nnoremap <Leader>di :<C-u>diffsplit<Space>#



 "+plugin----------------------------------------------------------
 "plugin設定は全て.vimrcへ

 """ NERD_comments
 let NERDSpaceDelims = 1


 """ neocomplete
if s:meet_neocomplete_requirements()
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#max_list = 30
    let g:neocomplete#auto_completion_start_length = 3
    let g:neocomplete#enable_smart_case = 1
    "" like AutoComplPop
    " let g:neocomplete#enable_auto_select = 1
    "" search with camel case like Eclipse
    let g:neocomplete#enable_camel_case_completion = 1
    let g:neocomplete#enable_underbar_completion = 1

    "imap <C-k> <Plug>(neocomplete#snippets_expand)
    "smap <C-k> <Plug>(neocomplete#snippets_expand)
    inoremap <expr><C-g> neocomplete#undo_completion()
    inoremap <expr><C-l> neocomplete#complete_common_string()
    "" SuperTab like snippets behavior.
    "imap <expr><TAB> neocomplete#sources#snippets_complete#expandable() ? "\<Plug>(neocomplete#snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

    "" <TAB> or <CR>: completion.
    " inoremap <expr><TAB> pumvisible() ? "\<C-n>" . neocomplete#close_popup() : "\<TAB>"
    inoremap <expr><CR> pumvisible() ? neocomplete#close_popup() : "\<CR>"
    "" <C-h>, <BS>: close popup and delete backword char.
    " inoremap <expr><C-h> neocomplete#smart_close_popup() . "\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup() . "\<C-h>"
    inoremap <expr><C-e> neocomplete#cancel_popup()
else
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_max_list = 30
    let g:neocomplcache_auto_completion_start_length = 3
    let g:neocomplcache_enable_smart_case = 1
    "" like AutoComplPop
    " let g:neocomplcache_enable_auto_select = 1
    "" search with camel case like Eclipse
    let g:neocomplcache_enable_camel_case_completion = 1
    let g:neocomplcache_enable_underbar_completion = 1

    "imap <C-k> <Plug>(neocomplcache_snippets_expand)
    "smap <C-k> <Plug>(neocomplcache_snippets_expand)
    inoremap <expr><C-g> neocomplcache#undo_completion()
    inoremap <expr><C-l> neocomplcache#complete_common_string()
    "" SuperTab like snippets behavior.
    "imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

    " inoremap <expr><TAB> pumvisible() ? "\<C-n>" . neocomplcache#close_popup() : "\<TAB>"
    inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"
    "" <C-h>, <BS>: close popup and delete backword char.
    " inoremap <expr><C-h> neocomplcache#smart_close_popup() . "\<C-h>"
    inoremap <expr><BS> neocomplcache#smart_close_popup() . "\<C-h>"
    inoremap <expr><C-e> neocomplcache#cancel_popup()
endif

"" <TAB> or <CR>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"



 """ unite.vim
 " 最近使用したファイルの最大保存件数
 let g:unite_source_file_mru_limit = 20
 " 最近使用したディレクトリの最大保存件数
 let g:unite_source_directory_mru_limit = 15
 " 絞り込みテキスト候補の表示更新間隔
 let g:unite_update_time = 1000

 nnoremap [unite]  <nop>
 xnoremap [unite]  <nop>
 nmap     <leader>u [unite]
 xmap     <leader>u [unite]
 
 " バッファ一覧
 nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
 " 現在のディレクトリのファイル一覧
 nnoremap <silent> [unite]d :<C-u>Unite file -buffer-name=files<CR>
 " 現在開いているファイルのディレクトリ以下のファイル一覧
 nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
 " レジスタ一覧
 nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
 " 最近使用したファイル一覧
 nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
 " カレントディレクトリ内の最近使用したファイル一覧
 nnoremap <silent> [unite]c :<C-u>UniteWithCurrentDir file_mru<CR>
 " 最近開いたファイル
 nnoremap <silent> [unite]u :<C-u>Unite buffer file_mru<CR>
 " 全部乗せ
 nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
 " unite-quickfix
 nnoremap <silent> [unite]q :<C-u>Unite quickfix<CR>
 " unite-bookmark
 nnoremap <silent> [unite]k :<C-u>Unite bookmark<CR>
 " " unite-help
 " nnoremap <silent> [unite]h :<c-u>unite help<cr>

 " unite.vim上でのキーマッピング
 autocmd FileType unite call s:unite_my_settings()
 function! s:unite_my_settings()
	 " 単語単位からパス単位で削除するように変更
	 nmap <buffer> <C-w> <Plug>(unite_delete_backward_path)
	 imap <buffer> <C-w> <Plug>(unite_delete_backward_path)

	 " ウィンドウを分割して開く
	 nnoremap <silent> <buffer> <expr> <C-h> unite#do_action('split')
	 inoremap <silent> <buffer> <expr> <C-h> unite#do_action('split')

	 " ウィンドウを縦に分割して開く
	 nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
	 inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')

	 " ESCキーを2回押すと終了する
	 nmap <silent><buffer> <ESC><ESC> q
	 imap <silent><buffer> <ESC><ESC> <ESC>q
 endfunction

 " unite-grep
 let g:unite_source_grep_default_opts = "-iHn"

 " unite history/yank
 let g:unite_source_history_yank_enable = 1
 let g:unite_source_history_yank_limit = 30
 nnoremap <silent> [unite]y :<C-u>Unite history/yank<CR>
 xnoremap <silent> [unite]r d:<C-u>Unite -buffer-name=register register history/yank<CR>

 """ VimFiler
 nnoremap <silent> <leader>vf :<C-u>VimFiler<CR>

 """ VimShell
 nnoremap <silent> <leader>vs :<C-u>VimShell<CR>
 nnoremap <silent> <leader>vsc :<C-u>VimShellCurrentDir<CR>

 """ vim-ref



 """ quickrun
 let g:quickrun_config = {
 \   '*': {'runmode': 'async:remote:vimproc'},
 \ }

 "c#
 let g:quickrun_config = { }
 let g:quickrun_config['cs'] = {
			 \ 'command'  : 'csc',
			 \ 'runmode'  : 'simple',
			 \ 'exec'     : ['%c /nologo %s:gs?/?\\? > /dev/null', '"%S:p:r:gs?/?\\?.exe" %a', ':call delete("%S:p:r.exe")'],
			 \ 'tempfile' : '{tempname()}.cs',
			 \ }



 " ローカルに配置する設定ファイル
 " if filereadable(expand('~/.vimrc.local'))
 "  source ~/.vimrc.local
 " endif




 """ TweetVim
 " Post
 nnoremap <leader>ws :<C-u>TweetVimSay<CR>
 " TL
 nnoremap <leader>wh :<C-u>TweetVimHomeTimeline<CR>
 " Mention
 nnoremap <leader>wm :<C-u>TwetVimMentions<CR>


 """ Align
 let g:Align_xstrlen=3


 """ vim-gitgutter
let g:gitgutter_system_function       = 'vimproc#system'
let g:gitgutter_system_error_function = 'vimproc#get_last_status'
let g:gitgutter_shellescape_function  = 'vimproc#shellescape'

nnoremap <silent> <leader>gg :<C-u>GitGutterToggle<CR>
nnoremap <silent> <leader>gh :<C-u>GitGutterLineHighlightsToggle<CR>



""" lightline
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode'
        \ }
        \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction



""" clever-f
let g:clever_f_smart_case = 1
let g:clever_f_use_migemo = 1
let g:clever_f_fix_key_direction = 1
let g:clever_f_chars_match_any_signs = ';'

