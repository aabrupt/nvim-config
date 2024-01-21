return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gv", vim.cmd.Git, {desc = "Git [V]iew"})
        vim.keymap.set("n", "<leader>gp", "Git push<CR>", {desc="Git [P]ush"})
        vim.keymap.set("n", "<leader>gp", "Git pull --rebase<CR>", {desc="Git [P]ull"})
        vim.keymap.set("n", "<leader>gt", "Git push -u origin", {desc="Push and Set Upstream"})
    end
}
