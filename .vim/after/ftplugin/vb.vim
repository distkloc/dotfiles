if exists("b:did_local_ftplugin")
	finish
endif
let b:did_local_ftplugin = 1

execute "NeoSnippetSource " . $MYVIM . "/bundle/snippet_vb/snippet/vb.snip"
