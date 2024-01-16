-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Move current line up and down when in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Navigate buffers with leader -> direction
vim.keymap.set("n", "<leader>h", "<C-w>h")
vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("n", "<leader>k", "<C-w>k")
vim.keymap.set("n", "<leader>l", "<C-w>l")

-- save with jk
vim.keymap.set("n", "<leader>jk", vim.cmd.w)
-- save and quit with jkl
vim.keymap.set("n", "<leader>jkl", vim.cmd.wq)
-- quit with jkl;
vim.keymap.set("n", "<leader>jkl;", vim.cmd.q)

-- Go to start of line
vim.keymap.set("n", "L", "$")
-- Go to end of line
vim.keymap.set("n", "H", "^")

-- Split buffer vertically
vim.keymap.set("n", "<leader>bsv", vim.cmd.vsplit)
-- Split buffer horizontally
vim.keymap.set("n", "<leader>bsh", vim.cmd.split)

-- Start lazygit
vim.keymap.set("n", "<leader>lg", vim.cmd.LazyGit)

-- Open file explorer in the current directory of the file your're editing
vim.keymap.set("n", "<leader>fe", function()
  vim.cmd("Neotree reveal_force_cwd")
end)

local builtin = require("telescope.builtin")

local function is_git_repo()
  vim.fn.system("git rev-parse --is-inside-work-tree")
  return vim.v.shell_error == 0
end

local function get_git_root()
  local dot_git_path = vim.fn.finddir(".git", ".;")
  return vim.fn.fnamemodify(dot_git_path, ":h")
end

local find_files_opts = {}
local find_grep_opts = {}

if is_git_repo() then
  find_files_opts.cwd = get_git_root()
  find_grep_opts.cwd = get_git_root()
end

-- We cache the results of "git rev-parse"
-- Process creation is expensive in Windows, so this reduces latency
local is_inside_work_tree = {}
local cwd = vim.fn.getcwd()

if is_inside_work_tree[cwd] == nil then
  vim.fn.system("git rev-parse --is-inside-work-tree")
  is_inside_work_tree[cwd] = vim.v.shell_error == 0
end

-- Find all files in current directory, respects gitignore
vim.keymap.set("n", "<leader>fs", function()
  local opts = {
    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
  }
  builtin.find_files(opts)
end)

local telescope_config = require("telescope.config")
local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

-- Search text in all files, respects gitignore
vim.keymap.set("n", "<leader>fg", function()
  vimgrep_arguments.search = vim.fn.input("Grep > ")
  builtin.grep_string(vimgrep_arguments)
end)

local harpoon = require("harpoon")

vim.keymap.set("n", "<leader>hm", function()
  harpoon:list():append()
end)

vim.keymap.set("n", "<leader>hl", function()
  harpoon:list():next()
end)

vim.keymap.set("n", "<leader>hh", function()
  harpoon:list():prev()
end)

vim.keymap.set("n", "<leader>hs", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Open harpoon window" })
