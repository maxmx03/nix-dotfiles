return {
  {
    'maxmx03/roseline',
    config = function()
      require('roseline').setup {
        icons = {
          vim = '',
          git = {
            head = '',
            added = '',
            changed = '',
            removed = '',
          },
          diagnostic = {
            Error = '',
            Warning = '',
            Information = '',
            Question = '',
            Hint = '󰌶',
            Debug = '',
            Ok = '󰧱',
          },
          default = { left = '', right = '' },
          block = { left = '█', right = '█' },
          round = { left = '', right = '' },
          os = {
            Linux = '󱄅',
            microsoft = '',
            Darwin = '',
          },
        },
      }
    end,
  },
}
