" Only load this indent file when no other was loaded.
if exists("b:did_local_indent")
	finish
endif
let b:did_local_indent = 1

setlocal softtabstop=2
setlocal shiftwidth=2
