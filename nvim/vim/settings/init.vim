" Swap files are only kept for modified buffers
" Autodeleted when changes are saved
autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
  \ if !$VIMSWAP && isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif
