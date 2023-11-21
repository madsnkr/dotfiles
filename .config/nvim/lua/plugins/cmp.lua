return {
  "hrsh7th/nvim-cmp",
  version = false,
  event = "InsertEnter",
  dependencies = {
    'hrsh7th/cmp-nvim-lsp', -- nvim-cmp source for neovim's built-in language server client.
    "hrsh7th/cmp-buffer",   -- nvim-cmp source for buffer words
    "hrsh7th/cmp-path",     -- nvim-cmp source for file system paths
    "hrsh7th/cmp-cmdline",  -- nvim-cmp source for vim's cmdline
    "hrsh7th/cmp-nvim-lua", -- nvim-cmp source for neovim Lua API
    "hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for neovim's built-in language server client
    "hrsh7th/cmp-calc",     -- nvim-cmp source for math calculation.
    {
      'L3MON4D3/LuaSnip',
      build = "make install_jsregexp",
      dependencies = {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end
      }
    },                          -- Snippet engine for neovim
    'saadparwaiz1/cmp_luasnip', -- luasnip completion source for nvim-cmp
    "rafamadriz/friendly-snippets",
  },
  opts = function()
    local cmp = require "cmp"
    local luasnip = require "luasnip"

    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    return {
      completion = { completeopt = "menu,menuone,noinsert", keyword_length = 1 },
      experimental = { native_menu = false, ghost_text = true },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }), -- Move up in completion menu (should be active in both "insert" and "command" mode)
        ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }), -- Move down in completion menu
        ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }), -- Invoke completion menu
        ['<CR>'] = cmp.mapping {
          i = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false },
          c = function(fallback)
            if cmp.visible() then
              cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
            else
              fallback()
            end
          end,
        },
        ['<Tab>'] = cmp.mapping(
          function(fallback)                         -- Enable tab completion
            if cmp.visible() then                    -- If completion menu is visible
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then -- If a snippet is jumpable or expandable then do that
              luasnip.expand_or_jump()
            elseif has_words_before() then           -- If there are words before cursor and we press tab it will invoke the complete menu
              cmp.complete()
            else
              fallback()
            end
          end, {
            "i",
            "s",
            "c"
          }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {
          "i",
          "s",
          "c"
        }),
      }),
      sources = cmp.config.sources {
        { name = "nvim_lsp",   group_index = 1, },
        { name = "calc",       group_index = 1 },
        { name = "luasnip",    group_index = 1 },
        { name = "buffer",     group_index = 2 },
        { name = "nvim_lua",   group_index = 2 },
        { name = "treesitter", group_index = 2 },
        { name = "path",       group_index = 2 },
      },
    }
  end,
  config = function(_, opts)
    local cmp = require "cmp"
    for _, source in ipairs(opts.sources) do
      source.group_index = source.group_index or 1
    end
    cmp.setup(opts)

    -- Use buffer source for `/`
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      }
    })

    -- Use cmdline & path source for ':'
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
    })

    -- Auto-pairs
    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
  end
}
