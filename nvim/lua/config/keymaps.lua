-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Move current line up and down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- Navigate buffers with leader -> direction
vim.keymap.set("n", "<leader>h", "<C-w>h")
vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("n", "<leader>k", "<C-w>k")
vim.keymap.set("n", "<leader>l", "<C-w>l")

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

-- Save on <leader>w
vim.keymap.set("n", "<leader>w", vim.cmd.write)

-- Write all on <leader>wa
vim.keymap.set("n", "<leader>wa", function()
  vim.cmd("wa")
end)

-- Write close on <leader>wq
vim.keymap.set("n", "<leader>wq", function()
  vim.cmd("wq")
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

-- Find in .git files if in git repo or all files if not
vim.keymap.set("n", "<leader>fs", function()
  if is_inside_work_tree[cwd] then
    builtin.git_files(find_files_opts)
  else
    builtin.find_files(find_files_opts)
  end
end)

-- Search all files. Useful for when a file isn't in git yet
vim.keymap.set("n", "<leader>fsa", function()
  builtin.find_files(find_files_opts)
end)

-- Search text in all files
vim.keymap.set("n", "<leader>fg", function()
  find_grep_opts.search = vim.fn.input("Grep > ")
  builtin.grep_string(find_grep_opts)
end)

vim.keymap.set("n", "<leader>fe", function()
  vim.cmd("Neotree toggle reveal_force_cwd")
end)
