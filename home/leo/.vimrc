syntax on
execute pathogen#infect()
set number " Show absolute line numbers on the left.
set wrap " Wrap overflowing lines
autocmd vimenter * ++nested colorscheme dogrun
set background=dark    " Setting dark mode
filetype plugin on
filetype indent on

# For Julia, taken from Turing style
set tabstop=4                             " Sets tabstops to a width of four columns.
set softtabstop=4                         " Determines the behaviour of TAB and BACKSPACE keys with expandtab.
set shiftwidth=4                          " Determines the results of >>, <<, and ==.

au FileType julia setlocal expandtab      " Replaces tabs with spaces.
au FileType julia setlocal colorcolumn=93 " Highlights column 93 to help maintain the 92 character line limit.
