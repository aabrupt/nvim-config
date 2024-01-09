return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",

        "nvim-telescope/telescope.nvim",
    },
    config = function()
        local neogit = require("neogit")

        neogit.setup({})

        vim.keymap.set("n", "<leader>gv", function() neogit.open({}) end, {desc = "Open Git [V]iew"})
        vim.keymap.set("n", "<leader>gc", function() neogit.open({"commit"}) end, {desc = "Open Git [C]ommit"})
    end
}
