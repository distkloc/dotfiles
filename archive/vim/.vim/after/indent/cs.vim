" Only load this indent file when no other was loaded.
if exists("b:did_local_indent")
	finish
endif

setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=-1 "same as shiftwidth

let b:did_local_indent = 1
