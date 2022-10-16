local opt = vim.opt

local M = {}

M.options = {
  nvChad = {
    update_url = "https://github.com/NvChad/NvChad",
    update_branch = "main",
  },
}

M.ui = {
  hl_add = {},
  hl_override = {},
  changed_themes = {},
  theme_toggle = { "onedark", "one_light" },
  theme = "onedark",
  transparency = false,
}

M.mappings = require "custom.mappings"

M.plugins = {
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
},
 ["jose-elias-alvarez/null-ls.nvim"] = {
      after = "nvim-lspconfig",
      config = function()
         require "custom.plugins.null-ls"
      end,
 },
    ["williamboman/mason.nvim"] = {
      ensure_installed = { "html-lsp", "clangd", "rust-analyzer", "typescript-language-server", "yamllint", "prettier", "markdownlint", "cpplint", "css-lsp" },
    },
}

opt.relativenumber = true

return M
