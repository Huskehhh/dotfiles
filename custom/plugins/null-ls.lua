local null_ls = require "null-ls"

local sources = {
  null_ls.builtins.formatting.rustfmt.with { extra_args = { "--edition=2021" } },
  null_ls.builtins.formatting.prettierd,
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.diagnostics.xo,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
