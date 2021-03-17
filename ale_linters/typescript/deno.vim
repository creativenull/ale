" Author: Mohammed Chelouti - https://github.com/motato1
" Description: Deno lsp linter for TypeScript files.

call ale#Set('typescript_deno_init_options', {
        \ 'enable': v:true,
        \ 'lint' : v:true,
        \ 'unstable': v:false,
    \ })

call ale#linter#Define('typescript', {
\   'name': 'deno',
\   'lsp': 'stdio',
\   'executable': function('ale#handlers#deno#GetExecutable'),
\   'command': '%e lsp',
\   'project_root': function('ale#handlers#deno#GetProjectRoot'),
\   'initialization_options': function('ale_linters#typescript#deno#GetInitializationOptions'),
\})

function! ale_linters#typescript#deno#GetInitializationOptions(buffer) abort
    let l:init_options = ale#Var(a:buffer, 'typescript_deno_init_options')

    if exists('l:init_options.importMap') == 1
        l:init_options.importMap = ale#handlers#deno#GetProjectRoot(a:buffer) . '/' . l:init_options.importMap
    endif

    return l:init_options
endfunction
