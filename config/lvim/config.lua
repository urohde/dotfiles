--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.autoread = true
vim.opt.shell = "/bin/zsh"

vim.g.tpipeline_autoembed = 0

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"

lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"
lvim.keys.normal_mode["<C-u>"] = "<C-u>zz"
lvim.keys.normal_mode["<leader>lF"] = ":EslintFixAll<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- -- Change theme settings
-- lvim.colorscheme = "lunar"

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>
lvim.builtin.cmp.sources = vim.tbl_filter(function(source)
  return source.name ~= "buffer"
end, lvim.builtin.cmp.sources)

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "eslint"
end, lvim.lsp.automatic_configuration.skipped_servers)

-- lvim.lsp.automatic_configuration.skipped_filetypes = vim.tbl_filter(function(filetype)
--   return filetype ~= "proto"
-- end, lvim.lsp.automatic_configuration.skipped_filetypes)

-- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
  {
    'vimpostor/vim-tpipeline'
  },
  {
    "tpope/vim-surround",
    -- make sure to change the value of `timeoutlen` if it's not triggering correctly, see https://github.com/tpope/vim-surround/issues/117
    -- setup = function()
    --  vim.o.timeoutlen = 500
    -- end
  },
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   event = "InsertEnter",
  --   dependencies = { "zbirenbaum/copilot.lua" },
  --   config = function()
  --     vim.defer_fn(function()
  --       require("copilot").setup()     -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
  --       require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
  --     end, 100)
  --   end,
  -- },
  {
    'nvim-treesitter/nvim-treesitter-context'
  },
  --   {
  --     "tpope/vim-fugitive",
  --     cmd = {
  --       "G",
  --       "Git",
  --       "Gdiffsplit",
  --       "Gread",
  --       "Gwrite",
  --       "Ggrep",
  --       "GMove",
  --       "GDelete",
  --       "GBrowse",
  --       "GRemove",
  --       "GRename",
  --       "Glgrep",
  --       "Gedit"
  --     },
  --     ft = { "fugitive" }
  --   },
}
