data:extend(
        {
          {
            name               = "tile-planner",
            type               = "selection-tool",
            order              = "c[automated-construction]-s[tile]",
            select             = {
              border_color    = {255, 127, 0},
              cursor_box_type = "copy",
              mode            = {"any-tile", "tile-ghost"},
            },
            alt_select         = {
              border_color    = {127, 255, 0},
              cursor_box_type = "copy",
              mode            = {"any-tile", "tile-ghost"},
            },
            reverse_select     = {
              border_color    = {0, 127, 255},
              cursor_box_type = "copy",
              mode            = {"nothing"},
            },
            alt_reverse_select = {
              border_color    = {0, 255, 127},
              cursor_box_type = "copy",
              mode            = {"nothing"},
            },
            icon               = "__tile-planner__/graphics/icons/planner.png",
            icon_size          = 64,
            stack_size         = 1,
            subgroup           = "tool",
            show_in_library    = false,
            flags              = {"not-stackable", "only-in-cursor", "spawnable"},
            can_be_mod_opened  = false,
          },
          {
            name                     = "give-tile-planner",
            type                     = "shortcut",
            order                    = "b[blueprints]-s[tile--planner]",
            action                   = "spawn-item",
            item_to_spawn            = "tile-planner",
            icon                     = "__tile-planner__/graphics/icons/shortcut.png",
            icon_size                = 32,
            small_icon               = "__tile-planner__/graphics/icons/shortcut.png",
            small_icon_size          = 32,
            associated_control_input = "give-tile-planner",
          },
          {
            name          = "give-tile-planner",
            type          = "custom-input",
            key_sequence  = "ALT + P",
            action        = "spawn-item",
            item_to_spawn = "tile-planner",
            consuming     = "game-only",
            order         = "b"
          },
          {
            name         = "tile-planner-open-menu",
            type         = "custom-input",
            key_sequence = "SHIFT + P",
            consuming    = "game-only",
            order        = "a"
          },
          { -- These two are there because on_mod_item_opened and on_gui_closed fire both on right click. We are keeping track of the closed state of the menu when E and Escape are pressed
            name                = "tile-planner-close-menu-escape",
            type                = "custom-input",
            key_sequence        = "",
            linked_game_control = "toggle-menu"
          },
          {
            name                = "tile-planner-close-menu-e",
            type                = "custom-input",
            key_sequence        = "",
            linked_game_control = "confirm-gui"
          }
        }
)
