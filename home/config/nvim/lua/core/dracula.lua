local function colors(_, color)
  return {
    base01 = '#7970A9',
    base02 = '#454158',
    base03 = '#22212C',
    base04 = '#17161D',
    cyan = '#80FFEA',
    green = '#8AFF80',
    orange = '#FFCA80',
    pink = '#FF80BF',
    purple = '#9580FF',
    red = '#FF9580',
    yellow = '#FFFF80',
    diag_error = '#FF9580',
    diag_warning = '#FFCA80',
    diag_info = '#80FFEA',
    diag_hint = '#80FFEA',
    diag_ok = '#8AFF80',
    shade_warning = color.blend('#FFCA80', '#22212C', 0.15),
    shade_error = color.blend('#FF9580', '#22212C', 0.15),
    shade_info = color.blend('#80FFEA', '#22212C', 0.15),
    shade_hint = color.blend('#80FFEA', '#22212C', 0.15),
    shade_ok = color.blend('#8AFF80', '#22212C', 0.15),
  }
end

return colors
