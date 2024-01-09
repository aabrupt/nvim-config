return {
    "VonHeikemen/fine-cmdline.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    config = function()
        vim.keymap.set("n", "<leader>mc", function()
            require("fine-cmdline").open({ default_value = "" })
        end, { noremap = true, desc="CmdLine Util" })
    end
}
