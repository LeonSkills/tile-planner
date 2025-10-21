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

    storage[event.player_index] = {tiles = tiles, width = max_x - min_x + 1, height = max_y - min_y + 1}
  end
end

local function on_player_reverse_selected_area(event)
  local item = event.item
  if not storage then return end
  if not storage[event.player_index] then return end
  if item == planner_name then
    local template = storage[event.player_index]
    local new_tiles = tile_patterns.repeat_pattern(template.tiles, template.width, template.height, event.area)
    event.surface.set_tiles(new_tiles, true, true, true, true, game.players[event.player_index])

  end
end

script.on_event(defines.events.on_player_selected_area, on_player_selected_area)
script.on_event(defines.events.on_player_alt_selected_area, on_player_selected_area)

script.on_event(defines.events.on_player_reverse_selected_area, on_player_reverse_selected_area)
script.on_event(defines.events.on_player_alt_reverse_selected_area, on_player_reverse_selected_area)