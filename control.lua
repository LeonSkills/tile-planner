local tile_patterns = require("scripts/tile-patterns.lua")
local planner_name = "tile-planner"

local function on_player_selected_area(event)
  local item = event.item
  if item == planner_name then
    local min_x = math.huge
    local min_y = math.huge
    local max_x = -math.huge
    local max_y = -math.huge
    for _, tile in pairs(event.tiles) do
      min_x = math.min(tile.position.x, min_x)
      min_y = math.min(tile.position.y, min_y)
      max_x = math.max(tile.position.x, max_x)
      max_y = math.max(tile.position.y, max_y)
    end
    local tiles = {}
    for _, tile in pairs(event.tiles) do
      local new_position = {x = tile.position.x - min_x, y = tile.position.y - min_y}
      table.insert(tiles, {name = tile.name, position = new_position})
    end
    storage.tile_templates[event.player_index] = {tiles = tiles, width = max_x - min_x + 1, height = max_y - min_y + 1}
  end
end

local function on_player_reverse_selected_area(event)
  local item = event.item
  local instant_build = false
  if not storage.tile_templates[event.player_index] then return end
  if item == planner_name then
    local player = game.players[event.player_index]
    local template = storage.tile_templates[event.player_index]
    local new_tiles = tile_patterns.repeat_pattern(template.tiles, template.width, template.height, event.area)
    if instant_build then
      event.surface.set_tiles(new_tiles, true, true, true, true, player)
    else
      for _, tile in pairs(new_tiles) do
        event.surface.create_entity {name = "tile-ghost", inner_name = tile.name, position = tile.position, force = player.force, player = player, raise_built = true}
      end
    end
  end
end

script.on_configuration_changed(function()
  if not storage.tile_templates then
    storage.tile_templates = {}
  end
end)

script.on_event(defines.events.on_player_selected_area, on_player_selected_area)
script.on_event(defines.events.on_player_alt_selected_area, on_player_selected_area)

script.on_event(defines.events.on_player_reverse_selected_area, on_player_reverse_selected_area)
script.on_event(defines.events.on_player_alt_reverse_selected_area, on_player_reverse_selected_area)