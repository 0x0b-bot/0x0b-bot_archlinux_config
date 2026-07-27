return {
    "nvim-tree/nvim-tree.lua",
    name = "nvim-tree", 

    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        require("nvim-tree").setup({
            hijack_directories = {enable = true,},
            view = {
              side = "right",
              width = 40,
            },
    })

    -- nvim-tree open by default  
    vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
            require("nvim-tree.api").tree.open()
        end,
    })
    
    vim.keymap.set("n", "C-0", ":NvimTreeToggle<CR>", { desc = "toggle file tree" })
  end,
}
