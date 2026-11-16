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

-- leetcode.nvim's leetcode.cn support swaps in a Chinese-tuned normalizer that
-- (a) only recognises 示例/输入/输出/提示 tags and (b) rewrites ASCII ':' to '：'.
-- With translate_problems = false we render the English fields, so that normalizer
-- mangles them. Keep the English one: capture it before the cn plugin patches the
-- class, and restore it after each start (the patch re-applies on every `:Leet`).
-- Everything is pcall'ed, so a change in plugin internals just turns this into a no-op.
local base_normalizer = {}

local function restore_english_normalizer()
  local ok_cfg, config = pcall(require, 'leetcode.config')
  if not ok_cfg then
    return
  end
  local cn = config.user.cn or {}
  if not cn.enabled or cn.translate_problems then
    return -- Chinese descriptions were requested; leave the cn normalizer alone
  end

  local ok_mod, normalizer = pcall(require, 'leetcode.parser.normalizer')
  if ok_mod and base_normalizer.cleanup then
    normalizer.cleanup = base_normalizer.cleanup
    normalizer.tags = base_normalizer.tags
  end
end

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
  config = function(_, opts)
    require('leetcode').setup(opts)

    -- runs before the cn plugin loads, so these are the English implementations
    local ok, normalizer = pcall(require, 'leetcode.parser.normalizer')
    if ok then
      base_normalizer.cleanup, base_normalizer.tags = normalizer.cleanup, normalizer.tags
    end
  end,
  opts = {
    lang = 'python3',

    cn = {
      enabled = true, ---@type boolean use leetcode.cn instead of leetcode.com
      translator = false, ---@type boolean false = English UI chrome, true = Chinese
      -- false -> English: uses the `content` / `title` fields
      -- true  -> Chinese: uses `translatedContent` / `translatedTitle`
      -- Affects the description, the title header and the problem-list picker.
      translate_problems = false, ---@type boolean
    },

    picker = { provider = 'telescope' },

    -- runs after `config.setup()`, i.e. after the cn plugin patched the normalizer
    hooks = {
      enter = { restore_english_normalizer },
    },

    -- where your solutions are saved
    storage = {
      home = vim.fn.stdpath 'data' .. '/leetcode',
    },
  },
}
