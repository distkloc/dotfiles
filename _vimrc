"--------------------------------
"neobundle.vim設定
"--------------------------------
set nocompatible
filetype off

if has("win32") || has("win64")
	set rtp+=~/vimfiles/neobundle.vim.git/ 
	call neobundle#rc(expand('~/vimfiles/bundle'))
else
	set rtp+=~/.vim/neobundle.vim.git/ 
	call neobundle#rc(expand('~/.vim/bundle'))
endif

 NeoBundle 'Shougo/neocomplcache'        
 NeoBundle 'Shougo/unite.vim'
 NeoBundle 'osyo-manga/unite-quickfix'
 NeoBundle 'scrooloose/nerdcommenter'
 NeoBundle 'thinca/vim-ref'
 NeoBundle 'thinca/vim-quickrun'
 NeoBundle 'mattn/webapi-vim'
 NeoBundle 'mattn/wwwrenderer-vim'
 NeoBundle 'mattn/emmet-vim'
 NeoBundle 'vim-scripts/Align'
 NeoBundle 'tpope/vim-surround'

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


filetype plugin indent on



scriptencoding cp932


" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
	let s:enc_euc = 'eucjp-ms'
	let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
	let s:enc_euc = 'euc-jisx0213'
	let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
	let s:fileencodings_default = &fileencodings
	let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
	let &fileencodings = &fileencodings .','. s:fileencodings_default
	unlet s:fileencodings_default
  else
	let &fileencodings = &fileencodings .','. s:enc_jis
	set fileencodings+=utf-8,ucs-2le,ucs-2
	if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
	  set fileencodings+=cp932
	  set fileencodings-=euc-jp
	  set fileencodings-=euc-jisx0213
	  set fileencodings-=eucjp-ms
	  let &encoding = s:enc_euc
	  let &fileencoding = s:enc_euc
	else
	  let &fileencodings = &fileencodings .','. s:enc_euc
	endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
	if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
	  let &fileencoding=&encoding
	endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
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

"ステータスライン
set statusline=%t%m%R%H%W\ %=[%{(&fenc!=''?&fenc:&enc)}/%{&ff}][%Y][#%n][ASCII=\%03.3b]\ %l,%v


 "+plugin----------------------------------------------------------
 "plugin設定は全て.vimrcへ

 """ NERD_comments
 let NERDSpaceDelims = 1


 """ neocomplcache
 let g:neocomplcache_enable_at_startup = 1
 let g:neocomplcache_max_list = 30
 let g:neocomplcache_auto_completion_start_length = 3
 let g:neocomplcache_enable_smart_case = 1
 "" like AutoComplPop
 let g:neocomplcache_enable_auto_select = 1
 "" search with camel case like Eclipse
 let g:neocomplcache_enable_camel_case_completion = 1
 let g:neocomplcache_enable_underbar_completion = 1
 "" zencoding連携
 let g:use_zen_complete_tag = 1
 
 "imap <C-k> <Plug>(neocomplcache_snippets_expand)
 "smap <C-k> <Plug>(neocomplcache_snippets_expand)
 inoremap <expr><C-g> neocomplcache#undo_completion()
 inoremap <expr><C-l> neocomplcache#complete_common_string()
 "" SuperTab like snippets behavior.
 "imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

 "" <TAB> or <CR>: completion.
 inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
 inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
 inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"
 "" <C-h>, <BS>: close popup and delete backword char.
 inoremap <expr><C-h> neocomplcache#smart_close_popup() . "\<C-h>"
 inoremap <expr><BS> neocomplcache#smart_close_popup() . "\<C-h>"
 inoremap <expr><C-e> neocomplcache#cancel_popup()



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

