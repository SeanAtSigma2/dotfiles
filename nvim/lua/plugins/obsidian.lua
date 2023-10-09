return {
  "epwalsh/obsidian.nvim",
  lazy = true,
  keys = {
    {
      "<leader>ns",
      function()
        vim.cmd.ObsidianSearch(vim.fn.input(""))
      end,
      desc = "Search notes",
    },
    {
      "<leader>nn",
      function()
        vim.cmd.ObsidianNew(vim.fn.input(""))
      end,
      desc = "Create new note",
    },
    { "<leader>nd", "<cmd>ObsidianToday<cr>", desc = "Create new daily note" },
    { "<leader>nt", "<cmd>ObsidianTemplate<cr>", desc = "Insert note template" },
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  opts = {
    dir = "/home/sean/workplace/notes",
    daily_notes = {
      folder = "daily-notes",
      template = "daily-note.md",
    },
    templates = {
      subdir = "templates",
    },
    mappings = {
      -- Ignores gf mapping override so it doesn't clash with the LSP plugin.
      ["gf"] = nil,
    },
    disable_frontmatter = true,
    note_id_func = function(title)
      return title
    end,
  },
}
