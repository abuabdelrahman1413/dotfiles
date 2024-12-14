let mapleader = " "
set wrap
set noswapfile incsearch
set shiftwidth=4 autoindent smartindent tabstop=4 softtabstop=4 expandtab
set scrolloff=999
set nofoldenable

set number relativenumber
let g:vimwiki_list = [{'path': '~/media/Documents/vimwiki', 'path_html': '~/media/Documents/public_html/'}, 
            \ {'path': '~/media/Documents/journal', 'path_html': '~/media/Documents/public_html/journal/', 'auto_diary_index': 1, 'template_path': '~/Documents/vimwiki/'},
            \ {'path': '~/media/Documents/fd', 'path_html': '~/media/Documents/fd/'}]

"set viminfo='10,\"100,:20,%,n~/.viminfo
set viminfo='100,n$HOME/.config/.viminfo
set linebreak
set spell spelllang=en_us
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#wordcount#filetypes = '\vnotes|help|markdown|rst|org|text|asciidoc|tex|mail|vimwiki'
"let g:airline_theme='gruvbox'

"Theme specific
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1

let wiki_1 = {}
let wiki_1.path = '~/media/Documents/vimwiki'
let wiki_2 = {}
let wiki_2.path = '~/media/Documents/journal'
let wiki_3 = {}
let wiki_3.path = '~/media/Documents/fd'

"Goyo Settings
function! s:goyo_enter()
  set noshowmode
  set noshowcmd
endfunction

function! s:goyo_leave()
  set showmode
  set showcmd
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

syntax on
