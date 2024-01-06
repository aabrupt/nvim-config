return {
    'neovim/nvim-lspconfig',
    dependencies = {
        { 'williamboman/mason.nvim', config = true },
        'williamboman/mason-lspconfig.nvim',
        {
            'j-hui/fidget.nvim',
            config = function()
                require("fidget").setup(
                    {
                        notification = { window = { winblend = 0, x_padding = 1 } },
                        progress = { display = { done_icon = ' ' } }
                    })
            end
        },
        'folke/neodev.nvim',
        {
            -- Autocompletion
            'hrsh7th/nvim-cmp',
            dependencies = {
                -- Snippet Engine & its associated nvim-cmp source
                'L3MON4D3/LuaSnip',
                'saadparwaiz1/cmp_luasnip',

                -- Adds LSP completion capabilities
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-path',

                -- Adds a number of user-friendly snippets
                'rafamadriz/friendly-snippets',
            },
        },
    },
    config = function()
        require('mason').setup()
        require('mason-lspconfig').setup()
        require("neodev").setup()

        local servers = {
            -- clangd = {},
            -- gopls = {},
            -- pyright = {},
            -- html = { filetypes = { 'html', 'twig', 'hbs'} },

            ['ocamllsp'] = {},
            tsserver = {},
            rust_analyzer = {},
            lua_ls = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        }

        -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        -- Ensure the servers above are installed
        local mason_lspconfig = require 'mason-lspconfig'

        mason_lspconfig.setup {
            ensure_installed = vim.tbl_keys(servers),
        }

        local on_attach = function(_, bufnr)
            vim.api.nvim_buf_create_user_command(bufnr, 'LspFormat', function(_)
                vim.lsp.buf.format()
            end, { desc = "Format current buffer" })
            vim.keymap.set('n', '<leader>f', vim.lsp.buf.format,
                { buffer = bufnr, desc = "Format current buffer" })
        end

        mason_lspconfig.setup_handlers {
            function(server_name)
                require('lspconfig')[server_name].setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                    filetypes = (servers[server_name] or {}).filetypes,
                }
            end,
        }
    end
}
