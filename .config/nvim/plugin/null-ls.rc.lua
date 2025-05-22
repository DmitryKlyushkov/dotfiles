local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end

null_ls.setup {
  -- debug = true,
  sources = {
    -- JS Linter/Formatter
    null_ls.builtins.formatting.prettierd,
    require("none-ls.diagnostics.eslint_d").with({
      extra_args = { "--no-ignore" }, -- Example of passing extra arguments
      condition = function(utils)
        return utils.root_has_file({ ".eslintrc.js", ".eslintrc.json", ".eslintrc.cjs" })
      end,
      eslint_disable_if_no_config = true, -- Disable eslint_d if no config file is found
    }),
    -- C++ Linter/Formatter
    null_ls.builtins.diagnostics.clang_check,
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.diagnostics.fish
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          lsp_formatting(bufnr)
        end,
      })
    end
  end
}
-- Update Renaming tags on insert
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = true,
    virtual_text = {
      spacing = 5,
      -- severity_limit = 'Warning',
      vim.diagnostic.severity.WARN
    },
    update_in_insert = true,
  }
)

vim.api.nvim_create_user_command(
  'DisableLspFormatting',
  function()
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
  end,
  { nargs = 0 }
)
