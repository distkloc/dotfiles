"--------------------------------
"vundle�ݒ�
"--------------------------------
set nocompatible
filetype off

if has("win32") || has("win64")
  set rtp+=~/vimfiles/vundle.git/ 
  call vundle#rc('~/vimfiles/bundle/')
else
  set rtp+=~/.vim/vundle.git/ 
  call vundle#rc()
endif

Bundle 'Shougo/neocomplcache'        
Bundle 'Shougo/unite.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'thinca/vim-ref'

filetype plugin indent on



scriptencoding cp932


" �����R�[�h�̎����F��
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconv��eucJP-ms�ɑΉ����Ă��邩���`�F�b�N
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconv��JISX0213�ɑΉ����Ă��邩���`�F�b�N
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodings���\�z
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
  " �萔������
  unlet s:enc_euc
  unlet s:enc_jis
endif
" ���{����܂܂Ȃ��ꍇ�� fileencoding �� encoding ���g���悤�ɂ���
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" ���s�R�[�h�̎����F��
set fileformats=unix,dos,mac
" ���Ƃ����̕����������Ă��J�[�\���ʒu������Ȃ��悤�ɂ���
if exists('&ambiwidth')
  set ambiwidth=double
endif



"----------------------------------------
"�V�X�e���ݒ�
"----------------------------------------
"�G���[���̉��ƃr�W���A���x���̗}���B
set noerrorbells
set novisualbell
set visualbell t_vb=

if has('multi_byte_ime') || has('xim')
  set iminsert=0 imsearch=0
  if has('xim') && has('GUI_GTK')
    "XIM�̓��͊J�n�L�[
    "set imactivatekey=C-space
  endif
endif



"--------------------------------------
"���̑��ݒ�
"--------------------------------------
"�܂�Ԃ�����
set nowrap
"���X�N���[���o�[�\��
set guioptions+=b
"�c�[���o�[��\��
set guioptions-=T
"tab�}�����̋󔒐�
set tabstop=4
"�I�[�g�C���f���g���ɑ}�������󔒐�
set softtabstop=4
"tab�̑���ɔ��p�X�y�[�X�ő}������󔒐�
set shiftwidth=4

"�����N�ŃN���b�v�{�[�h��
set clipboard+=unnamed

"��Ƀ^�u��\��
set showtabline=2
"�����^�u�\����
set tabpagemax=15




"esc�L�[��Ctl+j�Ɋ��蓖��
map <C-j> <esc>
imap <C-j> <esc>

"�s�ԍ��\��
set number

"�����o�b�N�A�b�v�t�@�C���̃p�X
set backupdir=~/dotfiles/vimbkup
let &directory = &backupdir

"C����X�^�C���̃C���f���g
set cindent

"runtime path
set runtimepath+=$HOME/vimfiles

"qfuxgrep
set runtimepath+=C:\Progra~1\qfixapp
let mygrepprg = 'c:/Progra~1/Gow/bin/grep'

"grep
" set grepprg=grep\ -rnIH\ 

"grep.vim
" let Grep_Path = 'C:\Progra~1\GnuWin32\bin\grep.exe -i'
" let Fgrep_Path = 'C:\Progra~1\GnuWin32\bin\fgrep.exe -i'
" let Egrep_Path = 'C:\Progra~1\GnuWin32\bin\egrep.exe -i'
" let Grep_Find_Path = 'C:\Progra~1\GnuWin32\bin\find.exe'
" let Grep_Xargs_Path = 'C:\Progra~1\GnuWin32\bin\xargs.exe'

" let Grep_Shell_Quote_Char = '"'

" let Grep_Skip_Dirs = '.svn'
" let Grep_Skip_Files = '*.bak *~'


"Esc��2�񉟂��Ńn�C���C�g����
nmap <ESC><ESC> :nohlsearch<CR><ESC>


"�}�E�X���N���b�N�Ńy�[�X�g�@�\������
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>



"�^�u����L�[�}�b�s���O 
nnoremap [TABCMD]  <nop>
nmap     <leader>t [TABCMD]

nnoremap <silent> [TABCMD]f :<c-u>tabfirst<cr>
nnoremap <silent> [TABCMD]l :<c-u>tablast<cr>
nnoremap <silent> [TABCMD]n :<c-u>tabnext<cr>
nnoremap <silent> [TABCMD]N :<c-u>tabNext<cr>
nnoremap <silent> [TABCMD]p :<c-u>tabprevious<cr>
nnoremap <silent> [TABCMD]e :<c-u>tabedit<cr>
nnoremap <silent> [TABCMD]c :<c-u>tabclose<cr>
nnoremap <silent> [TABCMD]o :<c-u>tabonly<cr>
nnoremap <silent> [TABCMD]s :<c-u>tabs<cr>




"+plugin----------------------------------------------------------
"plugin�ݒ�͑S��.vimrc��

" NERD_comments
let NERDSpaceDelims = 1
let NERDShutUp = 1


" neocomplcache
let g:neocomplcache_enable_at_startup = 1
" NeoComplCacheEnable
let g:neocomplcache_max_list = 30
let g:neocomplcache_auto_completion_start_length = 2
let g:neocomplcache_enable_smart_case = 1
"" like AutoComplPop
let g:neocomplcache_enable_auto_select = 1
"" search with camel case like Eclipse
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
"imap <C-k> <Plug>(neocomplcache_snippets_expand)
"smap <C-k> <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()
"" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
"" <CR>: close popup and save indent.
"inoremap <expr><CR> neocomplcache#smart_close_popup() . (&indentexpr != '' ? "\<C-f>\<CR>X\<BS>":"\<CR>")
inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"
"" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
"" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup() . "\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup() . "\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()



" unite.vim
" ���̓��[�h�ŊJ�n����
" let g:unite_enable_start_insert=1

" �o�b�t�@�ꗗ
nnoremap <silent> <leader>ub :<C-u>Unite buffer<CR>
" ���݂̃f�B���N�g���̃t�@�C���ꗗ
nnoremap <silent> <leader>ud :<C-u>Unite file -buffer-name=files<CR>
" ���݊J���Ă���t�@�C���̃f�B���N�g���ȉ��̃t�@�C���ꗗ
nnoremap <silent> <leader>uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" ���W�X�^�ꗗ
nnoremap <silent> <leader>ur :<C-u>Unite -buffer-name=register register<CR>
" �ŋߎg�p�����t�@�C���ꗗ
nnoremap <silent> <leader>um :<C-u>Unite file_mru<CR>
" �J�����g�f�B���N�g�����̍ŋߎg�p�����t�@�C���ꗗ
nnoremap <silent> <leader>uc :<C-u>UniteWithCurrentDir file_mru<CR>
" �ŋߊJ�����t�@�C��
nnoremap <silent> <leader>uu :<C-u>Unite buffer file_mru<CR>
" �S���悹
nnoremap <silent> <leader>ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" unite.vim��ł̃L�[�}�b�s���O
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
	" �P��P�ʂ���p�X�P�ʂō폜����悤�ɕύX
	imap <buffer> <C-w> <Plug>(unite_delete_backward_path)

	" �E�B���h�E�𕪊����ĊJ��
	nnoremap <silent> <buffer> <expr> <C-h> unite#do_action('split')
	inoremap <silent> <buffer> <expr> <C-h> unite#do_action('split')

	" �E�B���h�E���c�ɕ������ĊJ��
	nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
	inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')

	" ESC�L�[��2�񉟂��ƏI������
	nmap <silent><buffer> <ESC><ESC> q
	imap <silent><buffer> <ESC><ESC> <ESC>q
endfunction



" vim-ref
nmap <leader>ra :<C-u>Ref alc<Space>

let g:ref_alc_start_linenumber = 39 " �\������s��
if has("win32") || has("win64")
	let g:ref_alc_encoding = 'Shift-JIS' " Windows���������΍�
endif

