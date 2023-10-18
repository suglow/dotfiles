return {
  {
    "neovim/nvim-lspconfig",
    init = function ()
      vim.g.autoformat = false
    end,
    opts = {
      -- autoformat = false,
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = false,
        severity_sort = true,
      },
      servers = {
        -- rust_analyzer = {
        --   tools = {
        --     on_initialized = function()
        --       vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
        --         pattern = { "*.rs" },
        --         callback = function()
        --           vim.lsp.codelens.refresh()
        --         end,
        --       })
        --       vim.cmd([[
        --         augroup RUSTLSP
        --           autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
        --           autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
        --           autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
        --           autocmd BufWritePre                     *.rs silent! lua vim.lsp.buf.formatting_sync()
        --         augroup END
        --       ]])
        --     end,
        --     inlay_hints = {
        --       auto = true,
        --       only_current_line = false,
        --       only_current_line_autocmd = "CursorHold",
        --       show_parameter_hints = true,
        --       show_variable_name = false,
        --       parameter_hints_prefix = " ",
        --       other_hints_prefix = " ",
        --       max_len_align = false,
        --       max_len_align_padding = 1,
        --       right_align = false,
        --       right_align_padding = 7,
        --       highlight = "Comment",
        --     },
        --     hover_actions = {
        --       auto_focus = false,
        --       border = "rounded",
        --       width = 60,
        --       -- height = 30,
        --     },
        --   },
        --   server = {
        --     settings = {
        --       ["rust-analyzer"] = {
        --         lens = {
        --           enable = true,
        --         },
        --         checkOnSave = {
        --           command = "clippy",
        --         },
        --       },
        --     },
        --   },
        -- },
        clangd = {},
        gopls = {},
      },
      setup = {
        -- rust_analyzer = function(_, opts)
        --   local mason_registry = require("mason-registry")
        --   -- rust tools configuration for debugging support
        --   local codelldb = mason_registry.get_package("codelldb")
        --   local extension_path = codelldb:get_install_path() .. "/extension/"
        --   local codelldb_path = extension_path .. "adapter/codelldb"
        --   local liblldb_path = vim.fn.has("mac") == 1 and extension_path .. "lldb/lib/liblldb.dylib"
        --     or extension_path .. "lldb/lib/liblldb.so"
        --
        --   local rust_tools_opts = vim.tbl_deep_extend("force", opts, {
        --     dap = {
        --       adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
        --     },
        --   })
        --   require("rust-tools").setup(rust_tools_opts)
        --   return true
        -- end,
        clangd = function(_, opts)
          opts.capabilities.offsetEncoding = { "utf-16" }
        end,
        gopls = function(_, opts)
          local go_opts = {
            lsp_cfg = opts,
            luasnip = true,
          }
          require("go").setup(go_opts)
          return true
        end,
      },
    },
    keys = {
      {
        "<leader>lD",
        function()
          if vim.diagnostic.is_disabled() then
            vim.diagnostic.enable()
          else
            vim.diagnostic.disable()
          end
        end,
        desc = "trogger lsp",
      },
    },
  },
  -- {
  --   "simrat39/rust-tools.nvim",
  --   dependencies = {
  --     "nvim-lspconfig",
  --     "nvim-dap",
  --   },
  -- },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    -- event = { "CmdlineEnter" },
    -- ft = { "go", "gomod" },
    -- build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
}
