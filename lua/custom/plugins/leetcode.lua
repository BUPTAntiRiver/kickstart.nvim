-- LeetCode inside Neovim: https://github.com/kawre/leetcode.nvim
--
-- Entry point:  :Leet
--   :Leet            dashboard (daily / random / search)
--   :Leet list       browse all problems (filter by status/difficulty)
--   :Leet daily      today's problem
--   :Leet run        run against the testcases
--   :Leet submit     submit the solution
--   :Leet lang       switch language for the current question
--   :Leet exit       leave the leetcode UI
--
-- Notes:
--   * Targets leetcode.cn, because leetcode.com is unreachable here (403).
--   * `:Leet` needs a "clean" session: no other listed buffers open.
--   * Solutions live in ~/.local/share/nvim/leetcode (per-question dirs, git-friendly).

---@module 'lazy'
---@type LazySpec
return {
  'kawre/leetcode.nvim',
  -- load at startup so both entry points work:
  --   nvim leetcode.nvim   -> straight into the dashboard
  --   :Leet                -> from a clean session
  lazy = false,
  -- no `build` step needed: the `html` parser (used to format descriptions)
  -- is already installed by the treesitter `parsers` list in init.lua
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    -- a picker is required; you already have telescope from kickstart
    'nvim-telescope/telescope.nvim',
  },
  opts = {
    lang = 'python3',

    cn = {
      enabled = true, ---@type boolean use leetcode.cn instead of leetcode.com
      translator = true, ---@type boolean Chinese UI labels
      translate_problems = true, ---@type boolean translate descriptions to Chinese
    },

    picker = { provider = 'telescope' },

    -- where your solutions are saved
    storage = {
      home = vim.fn.stdpath 'data' .. '/leetcode',
    },
  },
}
