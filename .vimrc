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
if has('vim_starting')
    if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
        echo "install neobundle..."
        :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
    endif
    set rtp+=~/.vim/bundle/neobundle.vim/ 
endif
call neobundle#rc(expand('~/.vim/bundle'))

NeoBundleFetch "Shougo/neobundle.vim"

NeoBundle 'Shougo/unite.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'osyo-manga/unite-quickfix'

NeoBundleLazy 'mattn/wwwrenderer-vim'

NeoBundle 'Shougo/neocomplete', {
    \ 'depends' : 'Shougo/context_filetype.vim',
    \ 'disabled' : !has('lua'),
    \ 'vim_version' : '7.3.885'
    \ }

NeoBundle 'Shougo/neosnippet-snippets', {
    \ 'depends' :
    \     ['Shougo/neosnippet.vim']
    \ }

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
    \     'commands' : ['VimShell', 'VimShellSendString', 'VimShellCurrentDir']
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

NeoBundleLazy 'kana/vim-smartinput', { 
	\ 'autoload' : {
	\	'insert' : '1'
	\	}
	\}

NeoBundleLazy 'thinca/vim-quickrun', {
    \ 'autoload' : {
    \     'commands' : ['QuickRun']
    \     }
    \ }

NeoBundleLazy 'mattn/emmet-vim', {
    \ 'autoload' : {
    \   'filetypes' : ['htm', 'html', 'css'],
    \   }
    \ }

NeoBundleLazy 'sgur/vim-gitgutter', {
    \ 'depends' : 
    \     ['Shougo/vimproc'],
    \ 'autoload' : {
    \     'commands' : ['GitGutterToggle'],
    \     }
    \ }

NeoBundleLazy 'thinca/vim-ref', {
    \ 'autoload' : {
    \     'commands' : ['Ref']
    \     }
    \ }

NeoBundleLazy 'osyo-manga/vim-over', {
    \ 'autoload' : {
    \     'commands' : ['OverCommandLine']
    \     }
    \ }

NeoBundleLazy 'basyura/TweetVim', {
    \ 'depends' :
    \     ['basyura/twibill.vim',
    \      'mattn/webapi-vim',
    \      'tyru/open-browser.vim'],
    \ 'autoload' : {
    \     'commands' :
    \         ['TweetVimHomeTimeline',
    \          'TweetVimMentions',
    \          'TweetVimSay',
    \          'TweetVimUserTimeline',
    \          'TweetVimUserStream'],
    \     'unite_sources' : 
    \         ['tweetvim']
    \     }
    \ }

NeoBundleLazy 'LeafCage/yankround.vim', {
    \ 'autoload' : {
    \   'mappings' : ['<Plug>(yankround-']
    \   }
    \ }

NeoBundleLazy 'junegunn/vim-easy-align', {
    \ 'autoload' : {
    \   'mappings' : ['<Plug>(EasyAlign']
    \   }
    \ }

NeoBundleLazy 'rhysd/clever-f.vim', {
    \ 'autoload' : {
    \   'mappings' : ['n', 'f', 'F', 't', 'T']
    \   }
    \ }

NeoBundleLazy 'rhysd/unite-codic.vim', {
    \ 'depends' : 'koron/codic-vim',
    \    'autoload' : {
    \       'unite_sources' : ['codic'],
    \    }
    \ }


NeoBundleLazy 'ujihisa/unite-colorscheme', {
    \    'autoload' : {
    \       'unite_sources' : ['colorscheme'],
    \    }
    \ }

"color scheme
function! s:LazyLoadColorSheme(repository) 
    execute "NeoBundleLazy '". a:repository . "', { 'autoload' : {'unite_sources' : ['colorscheme'] } }"
endfunction 

call s:LazyLoadColorSheme('w0ng/vim-hybrid')
call s:LazyLoadColorSheme('cocopon/iceberg.vim')
call s:LazyLoadColorSheme('vim-scripts/moria')
call s:LazyLoadColorSheme('w0ng/vim-hybrid')
call s:LazyLoadColorSheme('vim-scripts/louver.vim')


filetype plugin indent on

" Installation check.
 NeoBundleCheck


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

"Escの2回押しでハイライト消去
nmap <ESC><ESC> :nohlsearch<CR><ESC>

" Use pt as grep
set grepprg=pt
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
vnoremap <silent> <C-p> "0p

" "タブ操作キーマッピング 
nnoremap [tabcmd]  <Nop>
nmap     <leader>t [tabcmd]

" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> <leader>'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" c 新しいタブを一番右に作る
map <silent> [tabcmd]c :tablast <bar> tabnew<CR>
" x タブを閉じる
map <silent> [tabcmd]x :tabclose<CR>
" n 次のタブ
map <silent> [tabcmd]n :tabnext<CR>
" p 前のタブ
map <silent> [tabcmd]p :tabprevious<CR>




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


augroup DisableAutoCommentLine
	autocmd!
	autocmd BufEnter * setlocal formatoptions-=r
	autocmd BufEnter * setlocal formatoptions-=o
augroup END


" Open new lines without going into insert mode
" http://www.vimbits.com/bits/493
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>


"+plugin----------------------------------------------------------
"plugin設定は全て.vimrcへ

"" NERD_comments
let NERDSpaceDelims = 1

"" smartinput
call smartinput#map_to_trigger('i', '<Plug>(smartinput_BS)', '<BS>', '<BS>')
call smartinput#map_to_trigger('i', '<Plug>(smartinput_C-h)', '<BS>', '<C-h>')
call smartinput#map_to_trigger('i', '<Plug>(smartinput_CR)', '<Enter>', '<Enter>')

"" neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#max_list = 30
let g:neocomplete#auto_completion_start_length = 3
let g:neocomplete#enable_smart_case = 1
"" like AutoComplPop
" let g:neocomplete#enable_auto_select = 1
"" search with camel case like Eclipse
let g:neocomplete#enable_camel_case_completion = 1
let g:neocomplete#enable_underbar_completion = 1

inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()

"" <TAB> or <CR>: completion.
" inoremap <expr><TAB> pumvisible() ? "\<C-n>" . neocomplete#close_popup() : "\<TAB>"
inoremap <expr><CR> pumvisible() ? neocomplete#close_popup() : "\<CR>"
"" <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> neocomplete#smart_close_popup() . "\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup() . "\<C-h>"
inoremap <expr><C-e> neocomplete#cancel_popup()
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" <BS> でポップアップを閉じて文字を削除
imap <expr> <BS> neocomplete#smart_close_popup() . "\<Plug>(smartinput_BS)"

" <C-h> でポップアップを閉じて文字を削除
imap <expr> <C-h> neocomplete#smart_close_popup() . "\<Plug>(smartinput_C-h)"

" <CR> でポップアップ中の候補を選択し改行する
imap <expr> <CR> neocomplete#smart_close_popup() . "\<Plug>(smartinput_CR)"

" <CR> でポップアップ中の候補を選択するだけで、改行はしないバージョン
" ポップアップがないときには改行する
imap <expr> <CR> pumvisible() ? neocomplete#close_popup() : "\<Plug>(smartinput_CR)"

"" neosnippet
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
	\ "\<Plug>(neosnippet_expand_or_jump)"
	\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
	\ "\<Plug>(neosnippet_expand_or_jump)"
	\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif



function! s:LoadVBSSnippet() "{{{
    if !isdirectory(expand("~/.vim/bundle/mysnippets/vbs.snip/"))
        echo "install mysnippets..."
        :call system("git clone https://gist.github.com/9682844.git ~/.vim/bundle/mysnippets/vbs.snip")
    endif

    NeoSnippetSource ~/.vim/bundle/mysnippets/vbs.snip/vbs.snip

    let g:neosnippet#scope_aliases['vb'] = 'vb,aspvbs'
endfunction "}}}

augroup LoadVBSSnippet
    autocmd!
    autocmd FileType vb,aspvbs call s:LoadVBSSnippet()
augroup END



"" unite.vim
" Start with insert mode
let g:unite_enable_start_insert = 1
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
" unite-codic
nnoremap <silent> [unite]c :<C-u>Unite codic<CR>
" unite-colorscheme
nnoremap <silent> [unite]s :<C-u>Unite colorscheme<CR>
" unite-tweetvim
nnoremap <silent> [unite]t :<C-u>Unite tweetvim<CR>

" unite.vim上でのキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
    " 単語単位からパス単位で削除するように変更
    nmap <buffer> <C-w> <Plug>(unite_delete_backward_path)
    imap <buffer> <C-w> <Plug>(unite_delete_backward_path)

    " Close Unite buffer
    imap <silent><buffer> <C-q> i_<Plug>(unite_exit)
endfunction

" unite-grep
nnoremap <silent> [unite]g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_max_candidates = 5000
endif

" unite yankround
nnoremap <silent> [unite]y :<C-u>Unite yankround<CR>

"" VimFiler
nnoremap <silent> <leader>vf :<C-u>VimFiler<CR>

"" VimShell
nnoremap <silent> <leader>vs :<C-u>VimShell<CR>
nnoremap <silent> <leader>vsc :<C-u>VimShellCurrentDir<CR>

"" vim-ref



"" quickrun
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



"" TweetVim
" Post
nnoremap <leader>ws :<C-u>TweetVimSay<CR>
" TL
nnoremap <leader>wh :<C-u>TweetVimHomeTimeline<CR>
" Mention
nnoremap <leader>wm :<C-u>TwetVimMentions<CR>


"" vim-easy-align
" Start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign with a Vim movement
nmap <Leader>a <Plug>(EasyAlign)


"" vim-gitgutter
let g:gitgutter_enabled = 0
let g:gitgutter_highlight_lines = 1
let g:gitgutter_system_function       = 'vimproc#system'
let g:gitgutter_system_error_function = 'vimproc#get_last_status'
let g:gitgutter_shellescape_function  = 'vimproc#shellescape'

nnoremap <silent> <leader>gg :<C-u>GitGutterToggle<CR>
nnoremap <silent> <leader>gh :<C-u>GitGutterLineHighlightsToggle<CR>



"" lightline
let g:lightline = {
        \ 'colorscheme': 'Tomorrow_Night',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
        \   'right': [ [ 'lineinfo' ],
        \            [ 'percent' ],
        \            [ 'bufnum' ],
        \            [ 'fileformat', 'fileencoding', 'filetype' ] ] 
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



"" clever-f
let g:clever_f_smart_case = 1
let g:clever_f_use_migemo = 1
let g:clever_f_fix_key_direction = 1
let g:clever_f_chars_match_any_signs = ';'


"" over.vim 
nnoremap <silent> <Leader>oc :OverCommandLine<CR>

"" yankround
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)


