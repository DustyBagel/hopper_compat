
--This adds support for elepower stuff

if minetest.get_modpath("elepower_machines") then
	hopper:add_container({
		{"top", "default:chest_open", "main"},
		{"side", "default:chest_open", "main"},
		{"bottom", "default:chest_open", "main"},

		{"top", "elepower_machines:alloy_furnace", "dst"}, 
		{"side", "elepower_machines:alloy_furnace", "dst"},
		{"bottom", "elepower_machines:alloy_furnace", "src"},

		{"top", "elepower_machines:bucketer", "dst"}, 
		{"side", "elepower_machines:bucketer", "dst"},
		{"bottom", "elepower_machines:bucketer", "src"},

		{"top", "elepower_machines:canning_machine", "dst"}, 
		{"side", "elepower_machines:canning_machine", "dst"},
		{"bottom", "elepower_machines:canning_machine", "src"},

		{"top", "elepower_machines:coal_alloy_furnace", "fuel"}, 
		{"bottom", "elepower_machines:coal_alloy_furnace", "fuel"},
		{"side", "elepower_machines:coal_alloy_furnace", "fuel"}, 

		{"top", "elepower_machines:compressor", "dst"}, 
		{"side", "elepower_machines:compressor", "dst"},
		{"bottom", "elepower_machines:compressor", "src"}, 

		{"top", "elepower_machines:furnace", "dst"}, 
		{"side", "elepower_machines:furnace", "dst"},
		{"bottom", "elepower_machines:furnace", "src"}, 

		{"top", "elepower_machines:generator", "src"}, 
		{"side", "elepower_machines:generator", "src"}, 

		{"top", "elepower_machines:generator_active", "src"}, 
		{"side", "elepower_machines:generator_active", "src"}, 

		{"top", "elepower_machines:grindstone", "dst"}, 
		{"side", "elepower_machines:grindstone", "dst"},
		{"bottom", "elepower_machines:grindstone", "src"},

		{"top", "elepower_machines:pcb_plant", "dst"}, 
		{"side", "elepower_machines:pcb_plant", "dst"},
		{"bottom", "elepower_machines:pcb_plant", "src"},

		{"top", "elepower_machines:pulverizer", "dst"}, 
		{"side", "elepower_machines:pulverizer", "dst"},
		{"bottom", "elepower_machines:pulverizer", "src"},

		{"top", "elepower_machines:pulverizer_active", "dst"}, 
		{"bottom", "elepower_machines:pulverizer_active", "src"},
		{"side", "elepower_machines:pulverizer_active", "src"},

		{"bottom", "elepower_machines:lava_cooler", "main"},

		{"top", "elepower_machines:sawmill", "dst"}, 
		{"side", "elepower_machines:sawmill", "dst"},
		{"bottom", "elepower_machines:sawmill", "src"},

		{"top", "elepower_machines:solderer", "dst"}, 
		{"side", "elepower_machines:solderer", "dst"},
		{"bottom", "elepower_machines:solderer", "src"},
	})
end

--This adds support for the technic chests like the iron chest.

if minetest.get_modpath("technic_chests") then
	hopper:add_container({
		{"top", "technic:iron_chest", "main"}, 
		{"bottom", "technic:iron_chest", "main"},
		{"side", "technic:iron_chest", "main"}, 

		{"top", "technic:copper_chest", "main"}, 
		{"bottom", "technic:copper_chest", "main"},
		{"side", "technic:copper_chest", "main"}, 

		{"top", "technic:silver_chest", "main"}, 
		{"bottom", "technic:silver_chest", "main"},
		{"side", "technic:silver_chest", "main"}, 

		{"top", "technic:gold_chest", "main"}, 
		{"bottom", "technic:gold_chest", "main"},
		{"side", "technic:gold_chest", "main"}, 

		{"top", "technic:mithril_chest", "main"}, 
		{"bottom", "technic:mithril_chest", "main"},
		{"side", "technic:mithril_chest", "main"}, 
	})
end