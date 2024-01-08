function! myspacevim#before() abort
  "other configs
  let s:remstring = '^\s*:\S'
  let g:github_dashboard = {'username': 'ckarren', 'password': $GITHUB_TOKEN}
  let g:NERDTreeShowHidden = 0
  let g:NERDTreeWinSize = 50
  let g:NERDTreeQuitOnOpen = 1
  let g:NERDTreeSortOrder = ['\/$', '[[extension]]', '[[-timestamp]]']
  let g:python3_host_prog = 'python'
  let g:sqlite_clib_path = "C:/Program Files/SQLite/sqlite3.dll"
  let g:spacevim_enable_ycm = 0
  let g:agenda_files = split(glob("~/OneDrive - North Carolina State University/org_files/*.org"),"\n")
  let g:vimtex_view_method = 'sioyek'
  let g:jedi#completions_enabled = 0
  " let g:everforest_background = 'soft'
  " Use deoplete.
  let g:deoplete#enable_at_startup = 0
  " Find files using Telescope command-line sugar.
  nnoremap <leader>ff <cmd>Telescope find_files <cr>
  nnoremap <leader>fg <cmd>Telescope live_grep<cr>
  nnoremap <leader>fb <cmd>Telescope buffers<cr>
  nnoremap <leader>fh <cmd>Telescope help_tags<cr>
  nnoremap <leader>fw <cmd>Telescope file_browser hidden=true<cr>
  nnoremap <leader>fx <cmd>Telescope bibtex<cr>
  inoremap kj <Esc>
  vnoremap kj <Esc>
  nmap <BS> :noh<CR>
lua << EOF
  vim.keymap.set(
    { "n", "o", "x" },
    "w",
    "<cmd>lua require('spider').motion('w')<CR>",
    { desc = "Spider-w" }
  )
  vim.keymap.set(
    { "n", "o", "x" },
    "e",
    "<cmd>lua require('spider').motion('e')<CR>",
    { desc = "Spider-e" }
  )
  vim.keymap.set(
    { "n", "o", "x" },
    "b",
    "<cmd>lua require('spider').motion('b')<CR>",
    { desc = "Spider-b" }
  )
EOF
  " set columns=80
  " autocmd VimResized * if (&columns > 80) | set columns=80 | endif
  " set wrap
  " set linebreak
  " set showbreak=+++
  set wrap linebreak nolist
  " set textwidth=80
  set signcolumn=yes
  autocmd filetype tex set wrap linebreak list
  autocmd filetype tex nnoremap j gj
  autocmd filetype tex nnoremap k gk
  autocmd filetype python set textwidth=80
  autocmd BufNewFile *.tex 0r ~/.SpaceVim.d/autoload/templates/skeleton.tex
  autocmd User TelescopePreviewerLoaded setlocal wrap
  autocmd BufReadPost,FileReadPost * normal zR
  lua << EOF
  package.path = package.path .. ";C:/Users/USER/.SpaceVim/bundle"
  package.path = package.path .. ";C:/Users/USER/.SpaceVim/lua"
  package.path = package.path .. ";C:/Users/USER/.SpaceVim/bundle/telescope.nvim/lua/telescope/_extensions"
  package.path = package.path .. ";C:/Users/USER/.cache/vimfiles/repos/github.com/nvim-telescope/telescope-bibtex.nvim/lua"
  package.path = package.path .. ";C:/Users/USER/.cache/vimfiles/repos/github.com/quangnguyen30192/cmp-nvim-ultisnips/lua"
  package.path = package.path .. ";C:/Users/USER/.cache/vimfiles/repos/github.com/L3MON4D3/LuaSnip/lua"
  package.path = package.path .. ";C:/Users/USER/.cache/vimfiles/repos/github.com/molleweide/LuaSnip_snippets.nvim/lua"
EOF
endfunction

function! myspacevim#after() abort
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
  " press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <S-Space> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-snippet' : '<S-Space>'
" -1 for jumping backwards.
inoremap <silent> <Tab> <cmd>lua require'luasnip'.jump(1)<Cr>
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
  let s:remstring = '^\s*:S'
  " vim.diagnostic.config(
    " {update_in_insert = false})
" try to disable signcolumn for cmp
" require('cmp').View.winopts.signcolumn = 'no'
lua << EOF
  require"telescope".setup {
    pickers = {
      files_browser = {
        hidden = true
      }
    },
    extensions = {
      bibtex = {
        -- Depth for the *.bib file
        depth = 1,
        -- Custom format for citation label
        custom_formats = {},
        -- Format to use for citation label.
        -- Try to match the filetype by default, or use 'plain'
        format = '',
        -- Path to global bibliographies (placed outside of the project)
        global_files = {"C:/Users/USER/OneDrive - North Carolina State University/Documents/userfiles/Karrenberg-dissertation.bib"},
        -- Define the search keys to use in the picker
        search_keys = { 'author', 'year', 'title' },
        -- Template for the formatted citation
        citation_format = '{{author}} ({{year}}), {{title}}.',
        -- Only use initials for the authors first name
        citation_trim_firstname = false,
        -- Max number of authors to write in the formatted citation
        -- following authors will be replaced by "et al."
        citation_max_auth = 2,
        -- Context awareness disabled by default
        context = false,
        -- Fallback to global/directory .bib files if context not found
        -- This setting has no effect if context = false
        context_fallback = true,
        -- Wrapping in the preview window is disabled by default
        wrap = true,
      },
    }
  }
  require"telescope".load_extension("bibtex")
  require"telescope".load_extension("file_browser")

  --require("cmp_nvim_ultisnips").setup{}
  local luasnip = require("luasnip")

  --luasnip.snippets = require("luasnip_snippets").load_snippets()
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_lua").load({ paths = "~/.SpaceVim.d/snippets/" })

  luasnip.config.set_config({
    history = true,
    enabled_autosnippets = true, 
  })

  local kind_icons = {
    Text = "󰊄",
    Method = "",
    Function = "󰊕",
    Field = "", 
    Variable = "󰫧", 
    Class = "", 
    Interface = "", 
    Module = "󱒌", 
    Property = "", 
    Enum = "", 
    Keyword = "", 
    Snippet = "", 
    File = "", 
    Reference = "", 
    Folder = "", 
    EnumMember = "", 
    Constant = "", 
    Struct = "", 
    Event = "", 
    Operator = "", 
  }
  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local cmp = require("cmp")
  cmp.setup({
    snippet = {
      expand = function(args)
        -- vim.fn["UltiSnips#Anon"](args.body)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-j>'] = cmp.mapping.select_next_item({ count = 1 }),
      ['<C-k>'] = cmp.mapping.select_prev_item({ count = 1 }),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
      -- kind icons
        vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
        vim_item.menu = ({
          nvim_lsp = "[lsp]",
          nvim_lua = "[nvim_lua]",
          luasnip = "[luasnip]",
          buffer = "[Buffer]",
          path = "[Path]",
        })[entry.source.name]
        return vim_item
      end,
      },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'neorg' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
   cmp.setup.cmdline({ '/', '?' }, {
     mapping = cmp.mapping.preset.cmdline(),
     sources = {
       { name = 'buffer' }
     }
   })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['pylsp'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['texlab'].setup{
    capabilities = capabilities
  }

-- Papis
  require("papis").setup({
    enable_keymaps = true,
    db_path = vim.fn.stdpath("data") .. "/papis_db/papis-nvim.sqlite3",
    -- yq_bin = "C:/Program Files/yq_windows_amd64/yq.exe",
    yq_bin = "yq",
    papis_python = {
      dir = "~/Documents/papers",
      info_name = "info.yaml",
      -- notes_name = [['notes.norg']]
    },
    enable_modules = {
      ["search"] = true, 
      ["completion"] = false,
      ["cursor-actions"] = true, 
      ["formatter"] = true,
      ["colors"] = true, 
      ["base"] = true, 
      ["debug"] = false
    },
    enable_commands = true, 
    enable_fs_watcher = false, 
    data_tbl_schema = {
      id = { "integer", pk = true },
      papis_id = {"text", unique = true}, -- { "text", required = true, unique = true },
      ref = {"text", unique = true}, -- { "text", required = true, unique = true },
      author = "text",
      editor = "text",
      year = "text",
      title = "text",
      type = "text",
      abstract = "text",
      time_added = "text",
      notes = "luatable",
      journal = "text",
      author_list = "luatable",
      tags = "luatable",
      files = "luatable",
    },
    ["papis-storage"] = {

      -- As lua doesn't deal well with '-', we define conversions between the format
      -- in the `info.yaml` and the format in papis.nvim's internal database.
      key_name_conversions = {
        time_added = "time-added",
        author_list = "author-list",
        papis_id = "papis-id",
      },

      -- The format used for tags. Will be determined automatically if left empty.
      -- Can be set to `tbl` (if a lua table), `,` (if comma-separated), `:` (if
      -- semi-colon separated), ` ` (if space separated).
      tag_format = ' ',

      -- The keys which `.yaml` files are expected to always define. Files that are
      -- missing these keys will cause an error message and will not be added to
      -- the database.
      required_keys = { }
    },
    init_filenames = {"%info_name%", "*.md"} --, "*.tex"},
  })
require('neorg').setup {
    load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        },
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.keybinds"] = { -- Manages keybindings with Neorg mode support
          config = {
            default_keybinds = true,
            neorg_leader = "\\",
          },
        },         -- ["core.tempus"] = {},
        ["core.ui"] = {},
        -- ["core.ui.calendar"] = {},
        ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
                workspaces = {
                    notes = "~/notes",
                    meetings = "~/meetings",
                },
                default_workspace = "meetings",
            },
        },
    },
}
require('kanban').setup({
  markdown = {
    description_folder = "./tasks/",
    list_head = '## ',
  }
})
EOF
endfunction

