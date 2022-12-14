{ ... }: {

  imports = [ <home-manager/nixos> ];

  home-manager.users.adityag = { config, pkgs, ... }: {
    # xclip required for zsh's copyfile, and nvim's clipboard+=unnamed functionality
    home.packages = [ pkgs.xclip ];

    programs.neovim = {
      enable = true;

      coc = {
        enable = true;

        # fixing build error when coc.enable and neovim.withNodeJs both set
        # @ref: https://github.com/nix-community/home-manager/issues/2966#issuecomment-1133667918
        package = pkgs.vimUtils.buildVimPluginFrom2Nix {
          pname = "coc.nvim";
          version = "2022-05-21";
          src = pkgs.fetchFromGitHub {
            owner = "neoclide";
            repo = "coc.nvim";
            rev = "791c9f673b882768486450e73d8bda10e391401d";
            sha256 = "sha256-MobgwhFQ1Ld7pFknsurSFAsN5v+vGbEFojTAYD/kI9c=";
          };
          meta.homepage = "https://github.com/neoclide/coc.nvim/";
        };

        settings = {
          "coc.preferences.rootPatterns" = [ ".git" ];
          "explorer.keyMappings.global" = {
            "<cr>" = [
              "expandable?"
              [ "expanded?" "collapse" "expand" ]
              "open"
            ];
          };
  
          "explorer.file.showHiddenFiles" = true;
          "explorer.file.reveal.auto" = true;
          "explorer.git.icon.status.added" = "✚";
          "explorer.git.icon.status.copied" = "➜";
          "explorer.git.icon.status.deleted" = "✖";
          "explorer.git.icon.status.ignored" = "☒";
          "explorer.git.icon.status.mixed" = "✹";
          "explorer.git.icon.status.modified" = "✹";
          "explorer.git.icon.status.renamed" = "➜";
          "explorer.git.icon.status.unmerged" = "═";
          "explorer.git.icon.status.untracked" = "?";
          "explorer.git.showIgnored" = true;
          "explorer.icon.enableNerdfont" = true;

          "suggest.noselect" = true;

          "languageserver" = {
            "nix" = {
              "command" = "rnix-lsp";
              "filetypes" = [ "nix" ];
            };
          };
        };

        pluginConfig = ''
          " CoC Extensions
          let g:coc_global_extensions=[
              \ 'coc-cmake',
              \ 'coc-clangd',
              \ 'coc-dictionary',
              \ 'coc-rust-analyzer',
              \ 'coc-tsserver',
              \ ]
          set updatetime=300
          set shortmess+=c
          " Use tab for trigger completion with characters ahead and navigate.
          inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1) :
            \ CheckBackspace() ? "\<Tab>" :
            \ coc#refresh()
          inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
          
          function! CheckBackspace() abort
            let col = col('.') - 1
            return !col || getline('.')[col - 1]  =~# '\s'
          endfunction
          " Remap keys for gotos
          nmap <silent> gd <Plug>(coc-definition)
          nmap <silent> gy <Plug>(coc-type-definition)
          nmap <silent> gi <Plug>(coc-implementation)
          nmap <silent> gr <Plug>(coc-references)
          " Formatting
          vmap <C-F> <Plug>(coc-format-selected)
          xmap <C-F> :call CocAction('format')<CR>
          nmap <C-F> :call CocAction('format')<CR>
          " Hover and rename
          nmap <silent> <F6> <Plug>(coc-rename)
          nnoremap <silent> K :call CocAction('doHover')<CR>
          " Go to symbol in (document|project)
          nmap <silent> S :CocList symbols<CR>
          " CoC Explorer
          function! CocExploreCwd()
              let cwd = substitute(execute(":pwd"), '\n', "", "")
              exe 'CocCommand explorer ' . cwd
          endfunction
          map <S-T> :call CocExploreCwd()<CR>
          " Open the diagnostics when diagnostics change
          autocmd BufWritePost * call timer_start(500, { tid -> execute('execute "CocDiagnostics" | execute "botright lwindow" | execute "wincmd p"') })
        '';
      };

      plugins = with pkgs.vimPlugins; [
        # @brief Provides linting support, can autofix using :ALEFix also
        # Other useful commands are :ALEGoToDefinition, :ALESymbolSearch,
        # :ALEFindReferences and :ALEHover
        ale

        # @brief: To auto create matching closing bracket, and add space to both sides
        # whenever space pressed
        auto-pairs

        # @note: currently in coc.pluginConfig. But not coc-python
        #coc-cmake
        #coc-python
        #coc-clangd
        #coc-tsserver
        #coc-rust-analyzer

        # @brief: Nerdtree filetree explorer
        # First do :NERDTree then press '?', or directly :help NERDTree
        nerdtree
        # @brief: Ranger file manager
        # @uses: default shortcut for opening Ranger is  <leader>f
        # To disable the default key mapping, add this line in your .vimrc or init.vim:  let g:ranger_map_keys = 0
        # then you can add a new mapping with this line:  map <leader>f :Ranger<CR> .
        # :Ranger or :RangerNewTab
        # ranger-vim

        # @brief Polyglot, language pack
        vim-polyglot

        # @brief Statusbar/Tabline
        # Read the README to setup
        vim-airline
        vim-airline-themes

        vim-nix
      ];

      vimdiffAlias = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = false;

/*
      extraConfig = ''
        syntax on
        filetype plugin on

        set clipboard+=unnamedplus      " Use system's clipboard
        set cursorline
        set relativenumber
        set textwidth=80
        set shiftwidth=4
        set autoindent
        set expandtab
        set mouse=                  " ignore mouse
        set title

	" https://stackoverflow.com/a/159066
	autocmd FileType nix setlocal shiftwidth=2 tabstop=2

        " Mapped nerd to Ctrl+o
        map <C-o> :NERDTreeToggle<CR>

        " Map tab correctly
        " https://libreddit.tiekoetter.com/r/neovim/comments/l42t5w/cocnvim_vimpoyglot_supertab_ultisnips_is_this/
        " Use tab for trigger completion with characters ahead and navigate.

        " [BEGIN] Changes suggested by COC
        set updatetime=300
        " set signcolumn=yes  " Enable this if wanting the sign column to always show,
        "   nhi to har error pe automatically aa jata h aur text shift hota h
        " Some servers have issues with backup files, see #649.

        " Use tab for trigger completion with characters ahead and navigate.
        " NOTE: There's always complete item selected by default, you may want to enable
        " no select by `"suggest.noselect": true` in your configuration file.
        " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
        " other plugin before putting this into your config.
        inoremap <silent><expr> <TAB>
              \ coc#pum#visible() ? coc#pum#next(1) :
              \ CheckBackspace() ? "\<Tab>" :
              \ coc#refresh()
        inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

        " Make <CR> to accept selected completion item or notify coc.nvim to format
        " <C-g>u breaks current undo, please make your own choice.
        inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

        function! CheckBackspace() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        " Use <c-space> to trigger completion.
        if has('nvim')
          inoremap <silent><expr> <c-space> coc#refresh()
        else
          inoremap <silent><expr> <c-@> coc#refresh()
        endif

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
        nnoremap <silent> K :call ShowDocumentation()<CR>

        function! ShowDocumentation()
          if CocAction('hasProvider', 'hover')
            call CocActionAsync('doHover')
          else
            call feedkeys('K', 'in')
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

        " Run the Code Lens action on the current line.
        nmap <leader>cl  <Plug>(coc-codelens-action)

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
        if has('nvim-0.4.0') || has('patch-8.2.0750')
          nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
          nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
          inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
          inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
          vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
          vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
        endif

        " Use CTRL-S for selections ranges.
        " Requires 'textDocument/selectionRange' support of language server.
        nmap <silent> <C-s> <Plug>(coc-range-select)
        xmap <silent> <C-s> <Plug>(coc-range-select)

        " Add `:Format` command to format current buffer.
        command! -nargs=0 Format :call CocActionAsync('format')

        " Add `:Fold` command to fold current buffer.
        command! -nargs=? Fold :call     CocAction('fold', <f-args>)

        " Add `:OR` command for organize imports of the current buffer.
        command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

        " Add (Neo)Vim's native statusline support.
        " NOTE: Please see `:h coc-status` for integrations with external plugins that
        " provide custom statusline: lightline.vim, vim-airline.
        " @ref: Escaping \'\': https://discourse.nixos.org/t/need-help-understanding-how-to-escape-special-characters-in-the-list-of-str-type/11389/2 
        set statusline^=%{coc#status()}%{get(b:,'coc_current_function',''')}

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

        " [END] Changes suggested by COC
      '';
    */
    };

    xdg.configFile."nvim/pack/github/start/copilot.vim".source = pkgs.fetchFromGitHub {
      owner = "github";
      repo = "copilot.vim";
      rev = "2f4f9259a5c0f927b31c4256cd3e4d7c6df87662";
      sha256 = "hUQhdIVIzHQKICYhSOjbG+GObxvpkub94fD4ESGwhmo=";
    };
  };
}

# ex: shiftwidth=2 expandtab: 
