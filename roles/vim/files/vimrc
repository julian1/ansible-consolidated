" deployed by ansible!

" :inoremap <C-i>   <ESC>

" *********** TOGGLE INSERT/MODE ****************
" Must use the Ctrl otherwise it will screw up copy and paste into buffer,
" i to insert, ii to escape
" inoremap ii <Esc>   " ii key is <Esc> setting

"ctrl-i is a lot easier than ctrl-c since uses two hands and is symetrical with i for insert mode


" *********** MISC ****************
" start in number mode
set number

" don't blink
set novisualbell

" ruler at lower rhs, reporting position in file
set ruler

" tell us when anything is changed via :...
set report=0

" this is really nice for fast navigating, duplicates existing keys
:noremap <C-L> 4l
:noremap <C-H> 4h
:noremap <C-K> 4k
:noremap <C-J> 4j


" enable syntax highlyging
syntax enable
"set background=light

" shortcut to fix all trailing space
:nmap <C-X> :%s/\s\+$//<CR>

" provide buffer menu, to select buffer
:nnoremap <C-M> :buffers<CR>:buffer<Space>

" Toggle numbers in lhs margin
:nmap J :set number!<CR>

" toggle display of formatting characters
:nmap K :set list!<CR>

" bash script formatting

" to reload vimrc - vimrc needs to be open
" :so %


" *********** TABS ****************
" tab navigation like firefox
" works very well - use ctrl-n and ctrl-p since pg-up/down doesnt
" just use ctrl-t to create new tab then :e file to open file
" likewise ctrl-w to close the tab
" but note
" # CTRL+T is used for jumping to previous tags [exuberant ctags].
" # CTRL+W is used for jumping to next split window in multiple windows
""""" tabnext and tab previous defalts are gt and gT
"" not sure if shouldnt use defaults instead
" note that tabf is best way to open tab
:nmap <C-p>     :tabprevious<cr>
:nmap <C-n>     :tabnext<cr>
:map <C-p>      :tabprevious<cr>
:map <C-n>      :tabnext<cr>
:imap <C-p>     <ESC>:tabprevious<cr>i
:imap <C-n>     <ESC>:tabnext<cr>i

"If you are working with tags/cscope, <Ctrl-T> is used for popping the stack.
" note there is tabf <filename>
:nmap <C-t>     :tabnew<cr>
:imap <C-t>     <ESC>:tabnew<cr>
" C-W interferes with split navigation
":nmap <C-w> :tabclose<cr>
":imap <C-w> <ESC>:tabclose<cr>


" ********** FOLDING **************

set foldmethod=syntax

" set to unfold 5 levels, so a newly opened file is mostly unfolded
" see, http://vim.wikia.com/wiki/All_folds_open_when_opening_a_file
set foldlevelstart=5

" ************** TAB/SPACE HANDLING ****************

" defaults
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab


function TabToggle()
  if &tabstop==2
    set tabstop=4
    set shiftwidth=4
    set sts=4
    set expandtab
    echo "tabstop=4, expand tab"
  elseif &tabstop==4 && &expandtab
    set tabstop=4
    set shiftwidth=4
    set sts=4
    set noexpandtab
    echo "tabstop=4, no expand tab"
  else
    set tabstop=2
    set shiftwidth=2
    set sts=2
    set expandtab
    echo "tabstop=2, expand tab"
  endif
endfunction
nmap <C-o> mz:execute TabToggle()<CR>

" *************** SYNTAX HIGHLIGHTING *******

" shouldn't need this, as autodetect should work
" au BufNewFile,BufRead *.why3 setf why3
" au BufNewFile,BufRead *.why setf why3
" au BufNewFile,BufRead *.mlw setf why3


" *************** LOCALIZE TMP FILE HANDLING *******
" ie keep *.swp, *.swo, files out of edit directories
" http://stackoverflow.com/questions/743150/how-to-prevent-vim-from-creating-and-leaving-temporary-files
" note swp file is useful, for telling us when the file is already open in another vim session

set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//


" *************** PATHOGEN *******

execute pathogen#infect()


