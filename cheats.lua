-- Cheat script for Widelands Build 19 by Thomas Ascher
-- Works on debug builds only, see: https://wl.widelands.org/wiki/BuildingWidelands
--
-- Installation:
--   -> Place script into the Widelands directory
--
-- Usage:
--   -> During a game open the script console by pressing F6
--   -> Type the following text and press enter: dofile('cheats.lua')
--   -> Type the following text and press enter: cheat()
--
-- Effect:
--   -> Sets all wares in all buildings that are warehouses to 999
--   -> Sets all workers in all buildings that are warehouses to 100
--
function cheat()
	local MAX_UNDEFINED_WARES = 999
	local MAX_UNDEFINED_WORKERS = 100
	local SOLDIER_STATS_NOVICE = { 0, 0, 0, 0 }

	local player = wl.Game().players[1]
	local tribe = player.tribe
	
	-- retrieve best soldier stats
	local soldier_stats = SOLDIER_STATS_NOVICE
	for i, worker in ipairs(tribe.workers) do
		if worker.type_name == "soldier" then
			soldier_stats = { worker.max_health_level, worker.max_attack_level, worker.max_defense_level, worker.max_evade_level }		
		end
	end
	
	for i, building in ipairs(tribe.buildings) do
		-- restock and restaff warehouses
		if building.type_name == "warehouse" then
			for i, building in ipairs(player:get_buildings(building.name)) do				
				for i, ware in ipairs(tribe.wares) do
					building:set_wares(ware.name, MAX_UNDEFINED_WARES)
				end
				
				for i, worker in ipairs(tribe.workers) do
					if worker.type_name == "soldier" then
						building:set_soldiers(soldier_stats, MAX_UNDEFINED_WORKERS)	
					else
						building:set_workers(worker.name, MAX_UNDEFINED_WORKERS)
					end
				end				
			end
		end
	end
	
	player:message_box("Cheat", "Now you're playing with power!")
end
