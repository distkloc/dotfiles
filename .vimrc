if &compatible
  set nocompatible
endif

" Detect OS
let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_mac = !s:is_windows && !s:is_cygwin
      \ && (has('mac') || has('macunix') || has('gui_macvim')
      \ || (!executable('xdg-open') && system('uname') =~? '^darwin'))

" Specify language
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


let $MYVIM = '~/.vim'
let s:myvimrtp = expand($MYVIM)

if has('vim_starting')
    let &rtp .= ',' . $MYVIM . '/bundle/repos/github.com/Shougo/dein.vim'
end

"--------------------------------
"dein.vim
"--------------------------------
if dein#load_state(s:myvimrtp . '/bundle')
  call dein#begin(s:myvimrtp . '/bundle')
  
  let s:toml_path = s:myvimrtp . '/dein.toml'
  let s:toml_lazy_path = s:myvimrtp . '/deinlazy.toml'

  call dein#load_toml(s:toml_path,      {'lazy': 0})
  call dein#load_toml(s:toml_lazy_path, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif 



filetype plugin indent on

" Installation check.
if dein#check_install()
  call dein#install()
endif


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
" System
"----------------------------------------
" bell
set belloff=all


"--------------------------------------
"その他設定
"--------------------------------------
"折り返し無し
set nowrap

"Use space instead of hard tab
set expandtab

"tab挿入時の空白数
set tabstop=2
"オートインデント時に挿入される空白数
set shiftwidth=2

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

let &backupdir = s:myvimrtp . '/backup'
let &directory = s:myvimrtp . '/swap'
let &undodir = s:myvimrtp . '/undo'

" prevent vim from appending duplicate option when :source is executed
if has('vim_starting')
  let &viminfo .= ',n' . s:myvimrtp . '/viminfo/.viminfo'
end

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

"Disable arrow key
noremap  <up>    <nop>
noremap  <left>  <nop>
noremap  <right> <nop>
noremap  <down>  <nop>

"Disable mouse middle click
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


set background=dark
call dein#source('vim-hybrid')
colorscheme hybrid

" Highlight double-byte space
augroup highlightIdegraphicSpace
	autocmd!
	autocmd VimEnter,ColorScheme * highlight def link IdeographicSpace Visual
	autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END

" Markdown
augroup MarkdownExtensions
  autocmd!
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END


"+plugin----------------------------------------------------------
"plugin設定は全て.vimrcへ

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



"" unite.vim
" Start with insert mode
let g:unite_enable_start_insert = 1
" 絞り込みテキスト候補の表示更新間隔
let g:unite_update_time = 1000

call unite#custom#source('file_rec,file_rec/async',
\ 'max_candidates', 1000)

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
" file_rec under current project root
nnoremap <silent> [unite]e :<C-u>call UniteFileRecUnderCurrentProjectRoot()<CR>

function! UniteFileRecUnderCurrentProjectRoot()
    if s:is_windows
        execute "Unite file_rec:!"
    else
        execute "Unite file_rec/async:!"
    end
endfunction

" unite-quickfix
nnoremap <silent> [unite]q :<C-u>Unite quickfix<CR>
" unite-bookmark
nnoremap <silent> [unite]k :<C-u>Unite bookmark<CR>
" unite-help
nnoremap <silent> [unite]h :<C-u>Unite help<CR>
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
    imap <silent><buffer> <ESC> i_<Plug>(unite_exit)
    imap <silent><buffer> <C-j> i_<Plug>(unite_exit)
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

"" unite neomru
" 最近使用したファイルの最大保存件数
let g:neomru#file_mru_limit = 1000
" 最近使用したディレクトリの最大保存件数
let g:neomru#directory_mru_limit = 1000


"" VimFiler
let g:vimfiler_as_default_explorer = 1

" Disable netrw.vim
let g:loaded_netrwPlugin = 1

nnoremap <silent> <leader>vf :<C-u>VimFiler<CR>

"" VimShell
nnoremap <silent> <leader>vs :<C-u>VimShell<CR>
nnoremap <silent> <leader>vsc :<C-u>VimShellCurrentDir<CR>

"" vim-ref



"" quickrun
let g:quickrun_config = {
\ '*': {
\   'runmode': 'async:remote:vimproc'
\ },
\ 'cs' : {
\   'command'  : 'csc',
\   'runmode'  : 'simple',
\   'exec'     : ['%c /nologo %s:gs?/?\\? > /dev/null', '"%S:p:r:gs?/?\\?.exe" %a', ':call delete("%S:p:r.exe")'],
\   'tempfile' : '{tempname()}.cs',
\   }
\ }



"" watchdogs.vim
let g:watchdogs_check_BufWritePost_enable = 1

nnoremap <leader>wd :<C-u>WatchdogsRun<CR>


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
    \ 'colorscheme': 'jellybeans',
		\ 'component': {
		\   'lineinfo': ' %3l:%-2v',
		\ },
		\ 'component_function': {
		\   'readonly': 'LightlineReadonly',
		\   'fugitive': 'LightlineFugitive'
		\ },
		\ 'separator': { 'left': '', 'right': '' },
		\ 'subseparator': { 'left': '', 'right': '' }
		\ }
	function! LightlineReadonly()
		return &readonly ? '' : ''
	endfunction
	function! LightlineFugitive()
		if exists('*fugitive#head')
			let branch = fugitive#head()
			return branch !=# '' ? ''.branch : ''
		endif
		return ''
	endfunction



"" over.vim 
nnoremap <silent> <Leader>oc :OverCommandLine<CR>

"" yankround
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)


"" EasyMotion
let g:EasyMotion_do_mapping = 0

map f <Plug>(easymotion-fl)
map t <Plug>(easymotion-tl)
map F <Plug>(easymotion-Fl)
map T <Plug>(easymotion-Tl)

nmap s <Plug>(easymotion-s2)
xmap s <Plug>(easymotion-s2)
" Avoid conflict between vim-easymotion and surround.vim
omap z <Plug>(easymotion-s2)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1

" Extend search motions with vital-over command line interface
" Incremental highlight of all the matches
" Now, you don't need to repetitively press `n` or `N` with EasyMotion feature
" `<Tab>` & `<S-Tab>` to scroll up/down a page of next match
" :h easymotion-command-line
nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)


"" incsearch.vim
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map s/ <Plug>(incsearch-stay)

set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)


"" caw.vim
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)


"" vim-markdown
let g:vim_markdown_folding_disabled = 1

"" shiba
command! Shiba :silent call system('shiba ' . expand('%') . ' &>/dev/null 2>&1 &') | redraw!

