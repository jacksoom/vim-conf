set nocompatible              
filetype off                 
execute pathogen#infect()
syntax on
filetype plugin indent on
set switchbuf=usetab,newtab
set guioptions-=r 
set guioptions-=L 

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'w0rp/ale'
Plugin 'tyru/open-browser.vim'
Plugin 'luochen1990/rainbow'
Plugin 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'liuchengxu/space-vim-dark'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'jodosha/vim-godebug'
Plugin 'liuchengxu/space-vim-theme'
Plugin 'preservim/nerdtree'
Plugin 'fatih/vim-go'
Plugin 'rust-lang/rust.vim'
Plugin 'nikvdp/ejs-syntax'
Plugin 'racer-rust/vim-racer'
Plugin 'jremmen/vim-ripgrep'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'tomlion/vim-solidity'
Plugin 'preservim/tagbar'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'tpope/vim-fugitive'
Plugin 'KeitaNakamura/neodark.vim'
Plugin 'joshdick/onedark.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Bundle 'junkblocker/patchreview-vim'
Bundle 'codegram/vim-codereview'
Plugin 'liuchengxu/vim-clap'
Plugin 'iden3/vim-circom-syntax'
Plugin 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plugin 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }
call vundle#end()
set rnu
" defaults for vim only.
filetype plugin indent on
if !has('nvim')
    syntax enable
    syntax on
    set laststatus=2
    set fileencodings=utf-8,gbk
    set hlsearch
    set incsearch
endif
if has("gui_macvim")
    set macmeta
endif

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
 
let mapleader = ","
set sw=4 ts=4 et
set splitbelow
set splitright
set rtp+=/usr/local/opt/fzf
nnoremap <leader><CR> :noh\|hi Cursor guibg=red<CR>
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>
nnoremap <Leader>l :setlocal number!<CR>
nnoremap <Leader>o :set paste!<CR>
nnoremap j gj
nnoremap k gk
" clipboard
nnoremap <leader>y "*y
vnoremap <leader>y "*y
nnoremap <leader>d "*d
vnoremap <leader>d "*d
nnoremap <leader>p "*p
vnoremap <leader>p "*p

" swap :tag and :tselect
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>
nnoremap g<c-]> <c-]>
vnoremap g<c-]> <c-]>


if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m

endif

let Tlist_Show_One_File = 1                  
let Tlist_Exit_OnlyWindow = 1               
let Tlist_Use_Left_Window = 1              

set laststatus=2 
let g:airline_powerline_fonts = 1 
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme="bubblegum"
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" airline setting
let g:airline_left_sep = '->'
let g:airline_left_alt_sep = '->'
let g:airline_right_sep = '->'
let g:airline_right_alt_sep = '->'
let g:airline_symbols.branch = '->'
let g:airline_symbols.readonly = '->'
let g:airline_symbols.linenr = '->'
let g:airline#extensions#tabline#enabled = 1
" show absolute file path in status line
let g:airline_section_c = '%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
" show tab number in tab line
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline_section_b = '%{strftime("%H:%M")}'


let g:python3_host_prog = '/usr/bin/python3'
set fdm=marker
" colorschema
set termguicolors
syntax enable
set guifont=Monaco:h11
" terminal
tnoremap <C-w> <C-\><C-n><C-w>
if has('nvim')
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
endif
augroup term
  au!
  if has('nvim')
    au BufWinEnter,WinEnter term://* startinsert
    au BufLeave term://* stopinsert
    au TermClose * bd!|q
  else
    au BufWinEnter,WinEnter term://* exec 'normal! i'
  endif
augroup END

" languages
augroup langs
  au!
  au FileType python,lua set foldmethod=indent foldnestmax=2
  au FileType vim set foldmethod=indent foldnestmax=2 sw=2
au BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
au BufWrite *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&"
  " Source the vimrc file after saving it
  au BufWritePost .vimrc source $MYVIMRC
  au BufWritePost *.hs,*.hsc silent !update-tags %
  au FileType haskell set formatprg=stylish-haskell
augroup END

" ale
au FileType haskell let g:ale_linters.haskell = ['hlint']
nnoremap <silent> <leader>aj :ALENext<cr>
nnoremap <silent> <leader>ak :ALEPrevious<cr>
" let g:ale_linters = {'go': ['golangci-lint']}
let g:go_fmt_fail_silently = 1  " https://github.com/w0rp/ale/issues/609
let g:ale_echo_msg_format = '%linter% says %s'
let g:go_fmt_command = "goimports"
let g:go_def_command = "godef"

let go_def_reuse_buffer = 1
au FileType go nmap <Leader>s <Plug>(go-def-split)
au FileType go nmap <Leader>v <Plug>(go-def-vertical)
au FileType go nmap <Leader>t <Plug>(go-def-tab)
" LanguageClient-neovim
let g:LanguageClient_rootMarkers = ['.git']

" bufexplorer
nnoremap <C-L> :BufExplorer<CR>

" ctrlp
nn <C-s> :CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
imap <F4> <C-x><C-o>

" vim-grepper
nnoremap <leader>g :Grepper -tool git -highlight<cr>
nnoremap <leader>G :Grepper -tool rg -highlight<cr>
nnoremap gs <plug>(GrepperOperator)
xnoremap gs <plug>(GrepperOperator)

let g:go_bin_path = "/Users/leefong/programer/go/bin"
""let g:ycm_use_clangd = 0
let Tlist_Show_One_File=1    
let Tlist_Exit_OnlyWindow=1    
" go vim
let $GOPATH = "/Users/leefong/programer/go"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_gopls_complete_unimported = v:false
let g:go_gopls_deep_completion = v:false
let g:go_gopls_matcher = v:false
let g:go_gopls_enabled = 1
"ale setting 
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
nmap <Leader>s :ALEToggle<CR>
map <Leader>d :ALEDetail<CR>
function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>


" Return to last edit position when opening files (You want this!)
augroup last_edit
  autocmd!
  autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal! g`\"" |
       \ endif
augroup END
" Remember info about open buffers on close
set viminfo^=%

function! InsertGates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . gatename
  execute "normal! o#define " . gatename . " "
  execute "normal! Go#endif /* " . gatename . " */"
  normal! kk
endfunction
autocmd BufNewFile *.{h,hpp} call InsertGates()
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let Tlist_Ctags_Cmd="/usr/local/bin/ctags"
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1

" auto
set autoindent
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab

" cscope
nmap <leader><Space>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <leader><Space>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <leader><Space>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <leader><Space>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <leader><Space>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <leader><Space>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <leader><Space>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <leader><Space>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <leader><Space>a :cs find a <C-R>=expand("<cword>")<CR><CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"" quick 
map <C-n> :NERDTreeToggle<CR>
map <C-p> :FZF <CR>
map <F6> :silent! NERDTreeToggle<CR>
map <C-k> :Tagbar<CR>
map <F11>:bp <CR>
map <F12>:bn <CR>

colorscheme space-vim-dark
"colorscheme onedark

" setting rust source path and racer cmd url
let g:racer_cmd = "/Users/leefong/.cargo/bin/racer"
let g:racer_experimental_completer = 1
let g:racer_insert_paren = 1
let g:rustfmt_uommand = 'rustfmt'
augroup Racer
    autocmd!
    autocmd FileType rust nmap <buffer> gd         <Plug>(rust-def)
    autocmd FileType rust nmap <buffer> gs         <Plug>(rust-def-split)
    autocmd FileType rust nmap <buffer> gx         <Plug>(rust-def-vertical)
    autocmd FileType rust nmap <buffer> gt         <Plug>(rust-def-tab)
    autocmd FileType rust nmap <buffer> <leader>gd <Plug>(rust-doc)
    autocmd FileType rust nmap <buffer> <leader>gD <Plug>(rust-doc-tab)
augroup END

	
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

let g:rust_use_custom_ctags_defs = 1  " if using rust.vim
let g:tagbar_type_rust = {
  \ 'ctagsbin' : '/usr/local/Cellar/universal-ctags/HEAD-6222334/bin/ctags',
  \ 'ctagstype' : 'rust',
  \ 'kinds' : [
      \ 'n:modules',
      \ 's:structures:1',
      \ 'i:interfaces',
      \ 'c:implementations',
      \ 'f:functions:1',
      \ 'g:enumerations:1',
      \ 't:type aliases:1:0',
      \ 'v:constants:1:0',
      \ 'M:macros:1',
      \ 'm:fields:1:0',
      \ 'e:enum variants:1:0',
      \ 'P:methods:1',
  \ ],
  \ 'sro': '::',
  \ 'kind2scope' : {
      \ 'n': 'module',
      \ 's': 'struct',
      \ 'i': 'interface',
      \ 'c': 'implementation',
      \ 'f': 'function',
      \ 'g': 'enum',
      \ 't': 'typedef',
      \ 'v': 'variable',
      \ 'M': 'macro',
      \ 'm': 'field',
      \ 'e': 'enumerator',
      \ 'P': 'method',
  \ },
\ }

let g:tarbar_ctags_bin= '/usr/local/Cellar/universal-ctags/HEAD-6222334/bin/ctags'

function! GoToDef()
    if &ft == 'go'
        execute 'GoDef'
    elseif &ft == 'javascript'
        execute 'TernDef'
    else
        execute 'YcmCompleter GoTo'
    endif
endfunction
nnoremap <leader>] :call GoToDef()<CR>




""coc

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.0 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" NeoVim-only mapping for visual mode scroll
" Useful on signatureHelp after jump placeholder of snippet expansion
if has('nvim')
  vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" air line clock
let g:airline#extensions#clock#format = '%H:%M:%S'


inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i

" airline setting
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_section_Z = '6% ☰ 10/100 ln : 20'

"buffer switch
nnoremap <M-1> 1gt <CR>
nnoremap <M-2> 2gt <CR>
nnoremap <M-3> 3gt <CR>
nnoremap <M-4> 4gt <CR>
nnoremap <M-5> 5gt <CR>
nnoremap <M-6> 6gt <CR>
nnoremap <M-7> 7gt <CR>
nnoremap <M-8> 8gt <CR>
nnoremap <M-9> 9gt <CR>
nnoremap <M-0> :tablast<CR>

nnoremap <F2> :GoDebugBreakpoint<CR>
nnoremap <F10> :GoDebugNext<CR>
nnoremap <F11> :GoDebugStep<CR>

