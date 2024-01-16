-- Window manager, also works with tmux
return {
  "ThePrimeagen/harpoon",
  lazy = false,
  branch = "harpoon2",
  requires = {
    "nvim-lua/plenary.nvim",
    "telescope.nvim",
  },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup({})
  end,
}
