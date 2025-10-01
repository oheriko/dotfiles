-- lua/plugins/blink/appearance.lua
-- Blink.cmp appearance configuration

return {
  -- use_nvim_cmp_as_default = true,
  -- nerd_font_variant = "mono",

  -- Signature help window
  signature = {
    enabled = true,
    trigger = {
      blocked_trigger_characters = {},
      blocked_retrigger_characters = {},
      show_on_insert_on_trigger_character = true,
    },
    window = {
      min_width = 1,
      max_width = 100,
      max_height = 10,
      border = "rounded",
      winblend = 0,
      winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
      scrollbar = false,
      direction_priority = { "n", "s" },
    },
  },

  -- Completion menu configuration
  completion = {
    accept = {
      auto_brackets = {
        enabled = true,
      },
    },
    trigger = {
      show_on_insert_on_trigger_character = true,
    },
    list = {
      selection = {
        preselect = true,
        auto_insert = true,
      },
    },
    menu = {
      min_width = 15,
      max_height = 10,
      border = "rounded",
      winblend = 0,
      winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
      scrolloff = 2,
      scrollbar = true,
      direction_priority = { "s", "n" },
      draw = {
        columns = {
          { "kind_icon" },
          { "label", "label_description", gap = 1 },
          { "kind", "source_name" },
        },
        components = {
          kind_icon = {
            text = function(ctx) return ctx.kind_icon .. ctx.icon_gap end,
            highlight = function(ctx) return "BlinkCmpKind" .. ctx.kind end,
          },
          source_name = {
            width = { max = 30 },
            text = function(ctx) return "[" .. ctx.source_name .. "]" end,
            highlight = "BlinkCmpSource",
          },
          label = {
            width = { fill = true, max = 60 },
            text = function(ctx) return ctx.label .. ctx.label_detail end,
            highlight = function(ctx)
              local highlights = {
                {
                  0,
                  #ctx.label,
                  group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel",
                },
              }
              if ctx.label_detail then
                table.insert(highlights, {
                  #ctx.label,
                  #ctx.label + #ctx.label_detail,
                  group = "BlinkCmpLabelDetail",
                })
              end
              for _, idx in ipairs(ctx.label_matched_indices) do
                table.insert(highlights, {
                  idx,
                  idx + 1,
                  group = "BlinkCmpLabelMatch",
                })
              end
              return highlights
            end,
          },
          kind = {
            width = { max = 10 },
            text = function(ctx) return ctx.kind end,
            highlight = function(ctx) return "BlinkCmpKind" .. ctx.kind end,
          },
        },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      treesitter_highlighting = true,
      window = {
        min_width = 10,
        max_width = 80,
        max_height = 20,
        border = "rounded",
        winblend = 0,
        winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
        scrollbar = true,
        direction_priority = {
          menu_north = { "e", "w", "n", "s" },
          menu_south = { "e", "w", "s", "n" },
        },
      },
    },
    ghost_text = {
      enabled = true,
    },
  },
}
