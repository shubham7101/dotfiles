return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = "main",
  build = ':TSUpdate',
  config = function()
    local configs = require("nvim-treesitter")

    configs.setup({
      ensure_installed = {
        'go', 'lua', 'javascript', 'typescript', 'vimdoc',
        'vim', 'regex', 'sql', 'dockerfile', 'toml', 'json',
        'java', 'groovy', 'gitignore', 'graphql', 'yaml',
        'make', 'cmake', 'markdown', 'markdown_inline', 'bash',
        'tsx', 'css', 'html',
      },
      auto_install = true,
      highlight = {
        enable = true, 
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    })

    -- Automated fallback: Force-attaches highlighting on supported files automatically
    vim.api.nvim_create_autocmd({ "FileType", "BufReadPost" }, {
      group = vim.api.nvim_create_augroup("TSAutoStart", { clear = true }),
      callback = function(args)
        -- Skip special buffers and UI lists like netrw to avoid errors
        if vim.bo[args.buf].buftype == "" and vim.bo[args.buf].filetype ~= "netrw" then
          pcall(vim.treesitter.start)
        end
      end,
    })
  end,
}

