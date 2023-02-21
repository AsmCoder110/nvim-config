vim.g.mapleader = " "
vim.g.maplocalleader = " "

require "lazy".setup({
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
        config = function()
            require "lualine".setup {
                options = {
                    globalstatus  = true,
                    icons_enabled = true,
                    theme         = "auto",
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "filename" },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" }
                },
                tabline = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },
                    lualine_c = { "filename" },
                    lualine_x = { "diagnostics" },
                    lualine_y = { "progress" },
                    lualine_z = { "diff" },
                },
            }
        end,
    },
    {
        "echasnovski/mini.pairs",
        version = "*",
        event = "VeryLazy",
        config = function()
            require "mini.pairs".setup()
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
                numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
                linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
                watch_gitdir                 = {
                    interval = 1000,
                    follow_files = true,
                },
                attach_to_untracked          = true,
                current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
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
                end,
            }
        end,
    },
    {
        "tpope/vim-vinegar",
        event = "VeryLazy",
    },
    {
        "tpope/vim-surround",
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
            { "jay-babu/mason-null-ls.nvim",       event = "VeryLazy" },
            { "jose-elias-alvarez/null-ls.nvim",   event = "VeryLazy" },
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

            local lsp_capabilities = require "cmp_nvim_lsp"
                .default_capabilities()
            local lsp_attach       = function(_, _)
                vim.keymap.set("n", "gI", vim.lsp.buf.implementation,
                               { desc = "[G]oto [I]mplementation" })
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,
                               { desc = "Rename" })
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,
                               { desc = "[C]ode [A]ction" })
                vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover,
                               { desc = "[C]ode [H]over" })
                vim.keymap.set("n", "<leader>f", vim.lsp.buf.format,
                               { desc = "[F]ormat code" })

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

            local lspconfig        = require "lspconfig"
            require "mason-lspconfig".setup_handlers {
                function(server_name)
                    lspconfig[server_name].setup {
                        on_attach = lsp_attach,
                        capabilities = lsp_capabilities,
                    }
                end,
            }
            require "lspconfig".lua_ls.setup {
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
            -- lspconfig.setup()

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
                    { name = "path" },
                    { name = "nvim_lsp", keyword_length = 1 },
                    { name = "buffer",   keyword_length = 1 },
                    { name = "luasnip",  keyword_length = 1 },

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
                    ["<Tab>"] = cmp.mapping(function(fallback)
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
            local sign = function(opts)
                vim.fn.sign_define(opts.name, {
                    texthl = opts.name,
                    text = opts.text,
                    numhl = ""
                })
            end

            sign { name = "DiagnosticSignError", text = "✗" }
            sign { name = "DiagnosticSignWarn", text = "⚠" }
            sign { name = "DiagnosticSignHint", text = "⚑" }
            sign { name = "DiagnosticSignInfo", text = "ⓘ" }

            vim.diagnostic.config {
                virtual_text = true,
                signs = true,
                update_in_insert = false,
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
        "lukas-reineke/lsp-format.nvim",
        event = "VeryLazy",
        config = function()
            require "lsp-format".setup {}
            local on_attach = function(client)
                require "lsp-format".on_attach(client)
            end
            require "lspconfig".gopls.setup { on_attach = on_attach }
        end,
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
},                   {
    ui = {
        custom_keys = {
            -- open lazygit log
            ["<leader>l"] = function(plugin)
                require "lazy.util".float_term({ "lazygit", "log" }, {
                    cwd = plugin.dir,
                })
            end,

            -- open a terminal for the plugin dir
            ["<leader>t"] = function(plugin)
                require "lazy.util".float_term(nil, {
                    cwd = plugin.dir,
                })
            end,
        },
    },
})
