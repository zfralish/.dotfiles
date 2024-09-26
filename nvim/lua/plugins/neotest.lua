return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-neotest/neotest-python",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-python")({
                    python = "./env/bin/python",
                    env = { PYTHONPATH = vim.fn.getcwd() },
                    runner = "pytest",
                })
            }
        })

    end
}
