
"Window position and size
let g:save_window_file = expand('~/.vimwinpos')
augroup SaveWindow
  autocmd!
  autocmd VimLeavePre * call s:save_window()
  function! s:save_window()
	let options = [
	  \ 'set columns=' . &columns,
	  \ 'set lines=' . &lines,
	  \ 'winpos ' . getwinposx() . ' ' . getwinposy(),
	  \ ]
	call writefile(options, g:save_window_file)
  endfunction
augroup END

if filereadable(g:save_window_file)
  execute 'source' g:save_window_file
endif


"----------------------------------------
" Display configuration
"----------------------------------------
"横スクロールバー表示
set guioptions+=b
"ツールバー非表示
set guioptions-=T
"メニュー非表示
set guioptions-=m
"gVimでテキストベースタブ使用
set guioptions-=e

"全角スペース強調表示
augroup highlightIdegraphicSpace
	autocmd!
	autocmd ColorScheme * highlight IdeographicSpace term=underline ctermbg=DarkCyan guibg=DarkCyan
	autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END

"color scheme
NeoBundleSource vim-hybrid
colorscheme hybrid


if has('multi_byte_ime') || has('xim')
  "起動直後の挿入モードでは日本語入力を有効にしない
  set iminsert=0 imsearch=0
  if has('xim') && has('GUI_GTK')
    "XIMの入力開始キー
    "set imactivatekey=C-space
  endif
  "IMEの状態をカラー表示
  highlight CursorIM guifg=NONE guibg=Green
  "挿入モード終了時に日本語入力をオフ
  inoremap <ESC> <ESC>:set iminsert=0<CR>
endif


" font
if has('xfontset')
"  set guifontset=a14,r14,k14
elseif has('mac')
    set guifont=Inconsolata_for_Powerline:h14
    set guifontwide=Ricty:h14
elseif has('win32') || has('win64')
    set guifont=Consolas_for_Powerline_FixedD:h13
    set guifontwide=Consolas:h13:cSHIFTJIS
elseif has('unix')
endif


augroup SetTransparency
    autocmd!
    if has('mac')
        autocmd GuiEnter * set transparency=7
        autocmd FocusGained * set transparency=7
        autocmd FocusLost * set transparency=40
    else
        autocmd FocusGained * set transparency=225
        autocmd FocusLost * set transparency=157
    endif
augroup END
