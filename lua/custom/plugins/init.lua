-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

---@module 'lazy'
---@type LazySpec
return {
  {
    'f-person/git-blame.nvim',
    event = 'VeryLazy',
  },
  {
    'hedyhli/outline.nvim',
    cmd = { 'Outline', 'OutlineOpen' },
    keys = {
      { '<leader>o', '<cmd>Outline<CR>', desc = 'Toggle Outline' },
    },
    opts = {},
  },
  {
    'mrcjkb/rustaceanvim', -- Need to run `rustup component add rust-analyzer` first
    version = '^5', -- Recommended to use a stable version
    lazy = false, -- This plugin is already lazy-loaded by default
  },
}
