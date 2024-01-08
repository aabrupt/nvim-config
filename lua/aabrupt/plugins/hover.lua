return {
    "lewis6991/hover.nvim",
    config = function()
        local hover = require("hover")
        hover.setup({
            init = function()
                require("hover.providers.lsp")
            end,
            preview_opts = {
                border = "single",
            },
            preview_window = false,
            title = false,
            mouse_providers = {
                "LSP",
            },
            mouse_delay = 1000,
        })

        vim.keymap.set("n", "K", hover.hover, {desc="Hover Symbol"})
        vim.keymap.set("n", "gK", hover.hover_select, {desc="Select Information Provider And Hover"})

        vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = "hover.nvim (mouse)" })
        vim.o.mousemoveevent = true
    end
}
