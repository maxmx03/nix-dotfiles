return {
  {
    'maxmx03/roseline',
    config = function()
      require('roseline').setup {
        theme = 'rose-pine',
        icons = {
          vim = '',
          diagnostic = {
            Ok = '󰟪',
          },
          os = {
            Linux = '󱄅',
          },
        },
      }
    end,
  },
}
