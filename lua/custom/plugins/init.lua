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
    'simrat39/symbols-outline.nvim',
    cmd = 'SymbolsOutline',
    keys = {
      { '<leader>so', '<cmd>SymbolsOutline<CR>', desc = 'Toggle Symbols Outline' },
    },
    opts = {
      position = 'right', -- 显示在右侧（可选left）
      width = 25, -- 侧边栏宽度
      show_numbers = false,
      show_relative_numbers = false,
      show_symbol_details = true,
      keymaps = {
        close = '<Esc>',
        goto_location = '<Cr>',
        focus_location = 'o',
        hover_symbol = '<C-space>',
        toggle_preview = 'K',
        rename_symbol = 'r',
        code_actions = 'a',
        fold = 'h',
        unfold = 'l',
        fold_all = 'W',
        unfold_all = 'E',
        fold_reset = 'R',
      },
      symbols = {
        File = { icon = '', hl = 'TSURI' },
        Module = { icon = '', hl = 'TSNamespace' },
        Namespace = { icon = '', hl = 'TSNamespace' },
        Package = { icon = '', hl = 'TSNamespace' },
        Class = { icon = '', hl = 'TSType' },
        Method = { icon = '', hl = 'TSMethod' },
        Property = { icon = '', hl = 'TSMethod' },
        Field = { icon = '', hl = 'TSField' },
        Constructor = { icon = '', hl = 'TSConstructor' },
        Enum = { icon = '', hl = 'TSType' },
        Interface = { icon = '', hl = 'TSType' },
        Function = { icon = '', hl = 'TSFunction' },
        Variable = { icon = '', hl = 'TSConstant' },
        Constant = { icon = '', hl = 'TSConstant' },
        String = { icon = '', hl = 'TSString' },
        Number = { icon = '', hl = 'TSNumber' },
        Boolean = { icon = '', hl = 'TSBoolean' },
        Array = { icon = '', hl = 'TSArray' },
        Object = { icon = '', hl = 'TSObject' },
        Key = { icon = '', hl = 'TSKeyword' },
        Null = { icon = '', hl = 'TSBoolean' },
        EnumMember = { icon = '', hl = 'TSField' },
        Struct = { icon = '', hl = 'TSType' },
        Event = { icon = '', hl = 'TSType' },
        Operator = { icon = '', hl = 'TSOperator' },
        TypeParameter = { icon = '', hl = 'TSParameter' },
      },
    },
  },
}
