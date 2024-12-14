" Split Bindings
imap <C-h> <C-w>h
imap <C-j> <C-w>j
imap <C-k> <C-w>k
imap <C-l> <C-w>l
" Use vim keys to move between splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Use Alt + Vim keys to resize Windows
nnoremap <silent> <C-M-j>    :resize -2<CR>
nnoremap <silent> <C-M-k>    :resize +2<CR>
nnoremap <silent> <C-M-h>    :vertical resize -2<CR>
nnoremap <silent> <C-M-l>    :vertical resize +2<CR>

map <F1> nop 

" For NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-c> :NERDTreeToggle<CR>

nnoremap <C-s> :noh<CR>

" Goyo
nnoremap <C-g> :Goyo<CR>

nnoremap <leader>s :source ~/.config/nvim/init.vim<CR>
nnoremap <leader>v :e ~/.config/nvim/init.vim<CR>

"Disable Arrow Keys
nnoremap <Up> <nop>
nnoremap <Down> <nop> 
nnoremap <Left> <nop>
nnoremap <Right> <nop>

nnoremap Q <nop>

" Tabs
nnoremap <C-l>h :tabr<cr>
nnoremap <C-l>l :tabl<cr>
nnoremap <C-l>j :tabp<cr>
nnoremap <C-n> :tabn<cr>
nnoremap <C-t> :tabnew<cr>
nnoremap <C-x> :tabc<cr>


noremap <silent> k gk
noremap <silent> j gj
noremap <silent> 0 g0
noremap <silent> $ g$

inoremap <C-h> <C-w>

"noremap <silent> <C-l> :move -2<CR>
"noremap <silent> <C-k> :move +1<CR>
