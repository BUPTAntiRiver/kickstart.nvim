-- LeetCode inside Neovim: https://github.com/kawre/leetcode.nvim
--
-- Launch
--   nvim leetcode.nvim    opens the dashboard (must be the only argument)
--   :Leet                 opens it from a clean session (no listed buffers)
--   The first :Leet must be bare - subcommands work once the UI is up.
--
-- Commands, once open
--   :Leet daily | random | list    today's / a random / browse all problems
--   :Leet run | submit             test against testcases / submit (needs login)
--   :Leet lang                     change language for the current question
--   :Leet reset | last_submit      restore starter code / last accepted code
--   :Leet exit                     leave the UI
--
-- Default keys (change them in `keys` below)
--   q    close the focused popup/split     r    reset testcases
--   U    use the current testcase          H    focus testcases
--   L    focus the result                  <CR> confirm something in a picker
--
-- Signing in (both run and submit require it)
--   Press `s` on the dashboard, or `:Leet cookie update`, then paste the
--   `cookie:` REQUEST header from a logged-in leetcode.cn session
--   (DevTools > Network > any graphql request > Request Headers).
--   Paste the request header, never `set-cookie` from the response.
--
-- Notes
--   * leetcode.cn, not .com: leetcode.com is unreachable here (403) and its
--     old problemsetQuestionList API endpoint has been removed.
--   * Solutions are flat files in ~/.local/share/nvim/leetcode/, named like
--     `1.two-sum.py` - one file per problem, handy to keep in a git repo.
--   * Cookie and problem list live in ~/.cache/nvim/leetcode/.

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
