vim.g.mapleader = " "
vim.g.maplocalleader = " "

require "lazy".setup {
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        config = function()
            require "gruvbox".setup {
                invert_tabline = true,
                dim_inactive = true,
            }
            vim.cmd "colorscheme gruvbox"
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        dependencies = { "arkav/lualine-lsp-progress" },
        config = function()
            local function num()
                return vim.fn.tabpagenr()
            end
            require "lualine".setup {
                options = {
                    globalstatus  = true,
                    icons_enabled = true,
                    theme         = "auto",
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "filename",
                        {
                            require "lazy.status".updates,
                            cond = require "lazy.status".has_updates,
                            color = { fg = "ff9e64" },
                        },
                        "lsp_progress"
                    },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" }
                },
                tabline = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },
                    lualine_c = { "filename", { num } },
                    lualine_x = { "diagnostics" },
                    lualine_y = { "progress" },
                    lualine_z = { "diff" },
                },
            }
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "VeryLazy",
        config = function()
            require "nvim-autopairs".setup()
        end,
    },
    {
        "simnalamburt/vim-mundo",
        event = "VeryLazy",
    },
    {
        "tpope/vim-dispatch",
        event = "VeryLazy",
    },
    {
        "tpope/vim-commentary",
        event = "VeryLazy",
    },
    {
        "tpope/vim-eunuch",
        event = "VeryLazy",
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            require "gitsigns".setup {
                signs                        = {
                    add          = { text = "|" },
                    change       = { text = "│" },
                    delete       = { text = "_" },
                    topdelete    = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked    = { text = "┆" },
                },
                signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
                numhl                        = true, -- Toggle with `:Gitsigns toggle_numhl`
                linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
                watch_gitdir                 = {
                    interval = 1000,
                    follow_files = true,
                },
                attach_to_untracked          = true,
                current_line_blame           = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts      = {
                    virt_text = true,
                    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                    delay = 1000,
                    ignore_whitespace = false,
                },
                current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
                sign_priority                = 6,
                update_debounce              = 100,
                status_formatter             = nil, -- Use default
                max_file_length              = 40000, -- Disable if file is longer than this (in lines)
                preview_config               = {
                    -- Options passed to nvim_open_win
                    border   = "single",
                    style    = "minimal",
                    relative = "cursor",
                    row      = 0,
                    col      = 1,
                },
                yadm                         = {
                    enable = false,
                },
                on_attach                    = function(bufnr)
                    local gs = package.loaded.gitsigns
                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end
                    map("n", "]c", function()
                        if vim.wo.diff then
                            return "]c"
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true })
                    map("n", "[c", function()
                        if vim.wo.diff then
                            return "[c"
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true })
                    -- Actions
                    map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
                    map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
                    map("n", "<leader>hS", gs.stage_buffer)
                    map("n", "<leader>hu", gs.undo_stage_hunk)
                    map("n", "<leader>hR", gs.reset_buffer)
                    map("n", "<leader>hp", gs.preview_hunk)
                    map("n", "<leader>hb",
                        function() gs.blame_line { full = true } end)
                    map("n", "<leader>tb", gs.toggle_current_line_blame)
                    map("n", "<leader>hd", gs.diffthis)
                    map("n", "<leader>hD", function() gs.diffthis "~" end)
                    map("n", "<leader>td", gs.toggle_deleted)

                    -- Text object
                    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
                end,
            }
        end,
    },
    {
        "tpope/vim-vinegar",
        event = "VeryLazy",
    },
    {
        "tpope/vim-unimpaired",
        event = "VeryLazy",
    },
    {
        "tpope/vim-repeat",
        event = "VeryLazy",
    },
    {
        "goolord/alpha-nvim",
        lazy = false,
        dependencies = { { "nvim-tree/nvim-web-devicons", lazy = true } },
        config = function()
            require "alpha".setup(require "alpha.themes.dashboard".config)
        end,
    },
    {
        "folke/trouble.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require "trouble".setup()
        end
    },
    {
        "stevearc/dressing.nvim",
        lazy = false,
        config = function()
            require "dressing".setup {
                input = {
                    win_options = {
                        winblend = 10,
                    },
                },
                builtin = {
                    win_options = {
                        winblend = 10,
                    },
                },
            }
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        keys = {
            { "<C-j><C-f>", ":Telescope find_files<cr>",  desc = "Find files" },
            { "<C-j><C-p>", ":Telescope commands<cr>",    desc = "Commands" },
            { "<C-j><C-e>", ":Telescope grep_string<cr>", desc = "Grep String" },
            { "<leader>fb", ":Telescope buffers<cr>",     desc = "[F]ind [B]uffers" },
            { "<leader>fd", ":Telescope diagnostics<cr>", desc = "[F]ind [D]iagnostics" },
            { "<leader>ff", ":Telescope git_files<cr>",   desc = "[F]ind [F]iles Git Status" },
            { "<leader>fh", ":Telescope oldfiles<cr>",    desc = "[F]ind [H]istory" },
            { "<leader>fg", ":Telescope live_grep<cr>",   desc = "[F]ind [G]rep" },
            { "<leader>fr", ":Telescope registers<cr>",   desc = "[F]ind [R]egisters" },
            { "<leader>fk", ":Telescope keymaps<cr>",     desc = "[F]ind [K]eymaps" },
            { "<leader>fm", ":Telescope marks<cr>",       desc = "[F]ind [M]arks" },
        },
        dependencies = { { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzy-native.nvim", lazy = true } },
        config = function()
            local actions = require "telescope.actions"
            require "telescope".setup {
                defaults = {
                    winblend = 20,
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close,
                        },
                    },
                    file_ignore_patterns = {
                        ".git",
                    },
                },
                pickers = {
                    find_files = {
                        no_ignore = false,
                        cwd = "/home/asmcoder",
                    },
                },
                extensions = {
                    file_browser = {
                        theme = "ivy",
                        mappings = {
                            ["i"] = {},
                            ["n"] = {},
                        },
                    },
                },
            }
            require "telescope".load_extension "fzy_native"
        end,
    },
    {
        "vim-test/vim-test",
        keys = {
            { "<leader>tn", ":TestNearest<cr>" },
            { "<leader>tf", ":TestFile<cr>" },
        },
    },
    {
        "tpope/vim-fugitive",
        lazy = false,
        keys = {
            { "<leader>gs", ":Git<cr>" },
            { "<leader>gd", ":Gdiff<cr>" },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        cmd = "TSUpdate",
        event = "VeryLazy",
        config = function()
            require "nvim-treesitter.configs".setup {
                ensure_installed = {
                    "html",
                    "javascript",
                    "typescript",
                    "rust",
                    "cpp",
                    "c",
                    "lua",
                    "json",
                    "bash",
                    "markdown",
                    "python",
                    "vim",
                    "help",
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                incremental_selection = {
                    enable = true,
                },
                textobjects = {
                    enable = true,
                },
            }
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require "nvim-treesitter.configs".setup {
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["as"] = "@scope",
                        },
                        selection_modes = {
                            ["@parameter.outer"] = "v",
                            ["@function.outer"] = "V",
                            ["@class.outer"] = "<c-v>",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = "@class.outer",
                            ["]o"] = "@loop.*",
                            ["]s"] = "@scope",
                            ["it"] = "@attribute.inner",
                            ["iT"] = "@attribute.outer",
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer",
                        }
                    },
                    lsp_interop = {
                        enable = true,
                        border = "none",
                        floating_preview_opts = {},
                        peek_definition_code = {
                            ["<leader>df"] = "@function.outer",
                            ["<leader>dF"] = "@class.outer",
                        }
                    }
                }
            }
        end
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require "nvim-surround".setup()
        end
    },
    {
        "williamboman/mason.nvim",
        -- event = "VeryLazy",
        lazy = false,
        dependencies = {
            { "williamboman/mason-lspconfig.nvim", event = "VeryLazy" },
            { "neovim/nvim-lspconfig",             event = "VeryLazy" },
            { "nvim-lua/plenary.nvim",             event = "VeryLazy" },
            { "hrsh7th/nvim-cmp",                  event = "VeryLazy" },
            { "hrsh7th/cmp-buffer",                event = "VeryLazy" },
            { "hrsh7th/cmp-path",                  event = "VeryLazy" },
            { "hrsh7th/cmp-nvim-lsp",              event = "VeryLazy" },
            { "hrsh7th/cmp-nvim-lua",              event = "VeryLazy" },
            { "L3MON4D3/LuaSnip",                  event = "VeryLazy" },
            { "saadparwaiz1/cmp_luasnip",          event = "VeryLazy" },
            { "rafamadriz/friendly-snippets",      event = "VeryLazy" },
        },
        config = function()
            require "mason".setup()
            require "mason-lspconfig".setup {
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "awk_ls",
                    "asm_lsp",
                    "bashls",
                    "clangd",
                    "cmake",
                    "neocmake",
                    "cssls",
                    "dockerls",
                    "eslint",
                    "emmet_ls",
                    "html",
                    "hls",
                    "jsonls",
                    "tsserver",
                    "marksman",
                    "ocamllsp",
                    "perlnavigator",
                    "pyright",
                    "r_language_server",
                    "raku_navigator",
                    "taplo",
                    "volar",
                },
                automatic_installation = true,
            }
            local fopts = { noremap = true, silent = true }
            vim.keymap.set("n", "gl", vim.diagnostic.open_float, fopts)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, fopts)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, fopts)
            vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, fopts)

            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            local lsp_attach       = function(_, bufnr)
                -- Enable completion triggered by <c-x><c-o>
                vim.api.nvim_buf_set_option(bufnr, "omnifunc",
                                            "v:lua.vim.lsp.omnifunc")

                -- Mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
                vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
                vim.keymap.set("n", "<space>wa", vim.lsp.buf
                .add_workspace_folder, bufopts)
                vim.keymap.set("n", "<space>wr",
                               vim.lsp.buf.remove_workspace_folder, bufopts)
                vim.keymap.set("n", "<space>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end,           bufopts)
                vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition,
                               bufopts)
                vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, bufopts)
                vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
                vim.keymap.set("n", "<leader>F",
                               function() vim.lsp.buf.format { async = true } end,
                               bufopts)
                local telescope = require "telescope.builtin"
                vim.keymap.set("n", "<leader>ds", telescope.lsp_document_symbols,
                               { desc = "[D]ocument [S]ymbols" })
                vim.keymap.set(
                    "n",
                    "<leader>ws",
                    telescope.lsp_dynamic_workspace_symbols,
                    { desc = "[W]orkspace [S]ymbols" }
                )
                vim.keymap.set("n", "<leader>rf", telescope.lsp_references,
                               { desc = "lsp references" })
            end
            local lsp_capabilities = require "cmp_nvim_lsp"
                .default_capabilities()
            local lspconfig        = require "lspconfig"

            require "mason-lspconfig".setup_handlers {
                function(server_name)
                    lspconfig[server_name].setup {
                        on_attach = lsp_attach,
                        capabilities = lsp_capabilities,
                    }
                end,
            }

            lspconfig.lua_ls.setup {
                on_attach = lsp_attach,
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                            version = "LuaJIT",
                        },
                        codeLens = {
                            enable = true,
                        },
                        format = {
                            enable = true,
                            defaultConfig = {
                                indent_size                       = "4",
                                indent_style                      = "space",
                                max_line_length                   = "80",
                                align_call_args                   = "true",
                                align_function_params             = "true",
                                align_continuous_assign_statement = "true",
                                align_array_table                 = "true",
                                call_arg_parentheses              = "remove",
                                quote_style                       = "double",
                            },
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { "vim" },
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand "$VIMRUNTIME/lua"]         = true,
                                [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                            },
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            }

            lspconfig.html.setup {
                on_attach = lsp_attach,
                settings = {
                    html = {
                        format = {
                            enable = false
                        }
                    }
                }
            }

            lspconfig.clangd.setup {
                on_attach = lsp_attach,
                settings = {
                    clangd = {
                        checkUpdates = true,
                        -- arguments = [ "--clang-tidy" ],
                    },
                },
            }

            require "luasnip.loaders.from_vscode".lazy_load()
            local cmp         = require "cmp"
            local luasnip     = require "luasnip"

            local select_opts = { behavior = cmp.SelectBehavior.Select }
            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                sources = {
                    { name = "nvim_lsp", keyword_length = 1 },
                    { name = "buffer",   keyword_length = 1 },
                    { name = "luasnip",  keyword_length = 1 },
                    { name = "path",     keyword_length = 1 },
                },
                window = {
                    documentation = cmp.config.window.bordered()
                },
                formatting = {
                    fields = { "menu", "abbr", "kind" },
                    format = function(entry, item)
                        local menu_icon = {
                            nvim_lsp = "λ",
                            luasnip  = "⋗",
                            buffer   = "Ω",
                            path     = "🖫",
                            nvim_lua = "Π",
                        }
                        item.menu = menu_icon[entry.source.name]
                        return item
                    end,
                },
                mapping = {
                    ["<CR>"]  = cmp.mapping.confirm { select = true } ,
                    ["<c-p>"] = cmp.mapping.select_prev_item(select_opts),
                    ["<c-n>"] = cmp.mapping.select_next_item(select_opts),
                    ["<c-u>"] = cmp.mapping.scroll_docs( -4),
                    ["<c-f>"] = cmp.mapping.scroll_docs(4),
                    ["<c-d>"] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end,                    { "i", "s" }),
                    ["<c-b>"] = cmp.mapping(function(fallback)
                        if luasnip.jumpable( -1) then
                            luasnip.jump( -1)
                        else
                            fallback()
                        end
                    end,                    { "i", "s" }),
                    ["<c-g>"] = cmp.mapping(function(fallback)
                        local col = vim.fn.col "." - 1
                        if cmp.visible() then
                            cmp.select_next_item(select_opts)
                        elseif col == 0 or vim.fn.getline ".":sub(col, col):match "%s" then
                            fallback()
                        else
                            cmp.complete()
                        end
                    end,                    { "i", "s" }),
                    ["<C-y>"] = cmp.mapping.abort(),


                }
            }

            local cmp_autopairs = require "nvim-autopairs.completion.cmp"
            cmp.event:on(
                "confirm_done",
                cmp_autopairs.on_confirm_done()
            )

            local sign = function(opts)
                vim.fn.sign_define(opts.name, {
                    texthl = opts.name,
                    text = opts.text,
                    numhl = ""
                })
            end

            sign { name = "DiagnosticSignError", text = "🔴" }
            sign { name = "DiagnosticSignWarn", text = "🟡" }
            sign { name = "DiagnosticSignHint", text = "🔵" }
            sign { name = "DiagnosticSignInfo", text = "🟢" }

            vim.diagnostic.config {
                virtual_text = true,
                signs = true,
                update_in_insert = true,
                underline = true,
                severity_sort = true,
                float = {
                    focusable = true,
                    style     = "minimal",
                    border    = "shadow",
                    source    = "always",
                    external  = true,
                },
            }
        end,
    },
    {
        "jay-babu/null-ls.nvim",
        lazy = false,
        dependencies = {
            { "jay-babu/mason-null-ls.nvim", event = "VeryLazy" },
            { "neovim/nvim-lspconfig",       event = "VeryLazy" },
            { "nvim-lua/plenary.nvim",       event = "VeryLazy" }
        },
        config = function()
            require "mason".setup()
            local null_ls = require "null-ls"
            null_ls.setup {
                sources = {
                    null_ls.builtins.formatting.prettier,
                }
            }

            require "mason-null-ls".setup {
                ensure_installed = { "prettier" },
                automatic_installation = true,
                automatic_setup = false,
            }
        end
    },
    {
        "dnlhc/glance.nvim",
        event = "VeryLazy",
        config = true,
        keys = {
            { "gd", ":Glance definitions<cr>", desc = "Go to Definition" },
            { "gr", ":Glance references<cr>",  desc = "Go to References" },
        },
    },
    {
        "tpope/vim-rsi",
        lazy = false,
    },
}
