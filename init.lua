--[[Tables to make the abms work. This code belongs to tenplus1 and facedeer. The original code can be found here 
https://content.minetest.net/packages/FaceDeer/hopper/ .]]

local directions = {
	[0]={["src"]={x=0, y=1, z=0},["dst"]={x=-1, y=0, z=0}},
	[1]={["src"]={x=0, y=1, z=0},["dst"]={x=0, y=0, z=1}},
	[2]={["src"]={x=0, y=1, z=0},["dst"]={x=1, y=0, z=0}},
	[3]={["src"]={x=0, y=1, z=0},["dst"]={x=0, y=0, z=-1}},
	[4]={["src"]={x=0, y=0, z=1},["dst"]={x=-1, y=0, z=0}},
	[5]={["src"]={x=0, y=0, z=1},["dst"]={x=0, y=-1, z=0}},
	[6]={["src"]={x=0, y=0, z=1},["dst"]={x=1, y=0, z=0}},
	[7]={["src"]={x=0, y=0, z=1},["dst"]={x=0, y=1, z=0}},
	[8]={["src"]={x=0, y=0, z=-1},["dst"]={x=-1, y=0, z=0}},
	[9]={["src"]={x=0, y=0, z=-1},["dst"]={x=0, y=1, z=0}},
	[10]={["src"]={x=0, y=0, z=-1},["dst"]={x=1, y=0, z=0}},
	[11]={["src"]={x=0, y=0, z=-1},["dst"]={x=0, y=-1, z=0}},
	[12]={["src"]={x=1, y=0, z=0},["dst"]={x=0, y=1, z=0}},
	[13]={["src"]={x=1, y=0, z=0},["dst"]={x=0, y=0, z=1}},
	[14]={["src"]={x=1, y=0, z=0},["dst"]={x=0, y=-1, z=0}},
	[15]={["src"]={x=1, y=0, z=0},["dst"]={x=0, y=0, z=-1}},
	[16]={["src"]={x=-1, y=0, z=0},["dst"]={x=0, y=-1, z=0}},
	[17]={["src"]={x=-1, y=0, z=0},["dst"]={x=0, y=0, z=1}},
	[18]={["src"]={x=-1, y=0, z=0},["dst"]={x=0, y=1, z=0}},
	[19]={["src"]={x=-1, y=0, z=0},["dst"]={x=0, y=0, z=-1}},
	[20]={["src"]={x=0, y=-1, z=0},["dst"]={x=1, y=0, z=0}},
	[21]={["src"]={x=0, y=-1, z=0},["dst"]={x=0, y=0, z=1}},
	[22]={["src"]={x=0, y=-1, z=0},["dst"]={x=-1, y=0, z=0}},
	[23]={["src"]={x=0, y=-1, z=0},["dst"]={x=0, y=0, z=-1}},
}

local bottomdir = function(facedir)
	return ({[0]={x=0, y=-1, z=0},
		{x=0, y=0, z=-1},
		{x=0, y=0, z=1},
		{x=-1, y=0, z=0},
		{x=1, y=0, z=0},
		{x=0, y=1, z=0}})[math.floor(facedir/4)]
end

--The rest of the code is mine exept for the abm which I modified from the hoppers mod.

local different_nodes = {}

local function add_node(node, replace_with_node)
	table.insert(different_nodes, {node, replace_with_node})
end

--Function for removeing the default:chest_locked from the hoppers tables so that they don't work when the protected_chest_support is not enabled.
local function remove_hopper_support(t, sub)
    for k, _ in pairs(t) do
        if k == sub then
            t[k] = nil
        end
    end
end

if minetest.settings:get_bool("protected_chest_support") or false then
	hopper:add_container({
		{"top", "default:chest_locked_open", "main"},
		{"side", "default:chest_locked_open", "main"},
		{"bottom", "default:chest_locked_open", "main"},
	})
else
	--We need to remove the default:chest_locked node from the hopper.containers table because it is added in the hoppers mod and we don't want it to work with hoppers when the setting for that is disabled because it is a security risk for any server to have locked chests be able to be emptied by anyone with a hopper.
	remove_hopper_support(hopper.containers, "default:chest_locked")
end
	

--Make the hoppers work with a chest when it is open
if minetest.settings:get_bool("open_chest_support") or false then
	hopper:add_container({
		{"top", "default:chest_open", "main"},
		{"side", "default:chest_open", "main"},
		{"bottom", "default:chest_open", "main"},
	})
end

--Add connected chests support.
if minetest.get_modpath("connected_chests") then
	hopper:add_container({
		{"top", "default:chest_connected_left", "main"}, 
		{"bottom", "default:chest_connected_left", "main"},
		{"side", "default:chest_connected_left", "main"}, 

		{"top", "default:chest_connected_right", "main"}, 
		{"bottom", "default:chest_connected_right", "main"},
		{"side", "default:chest_connected_right", "main"},
	})

	add_node("default:chest_connected_right", "default:chest_connected_left")
	
	if minetest.settings:get_bool("open_chest_support") or false then
		hopper:add_container({
			{"top", "default:chest_connected_left_open", "main"}, 
			{"bottom", "default:chest_connected_left_open", "main"},
			{"side", "default:chest_connected_left_open", "main"}, 
		
			{"top", "default:chest_connected_right_open", "main"}, 
			{"bottom", "default:chest_connected_right_open", "main"},
			{"side", "default:chest_connected_right_open", "main"}, 
		})
		
		add_node("default:chest_connected_right_open", "default:chest_connected_left_open")
	end
		
	if minetest.settings:get_bool("protected_chest_support") or false then
		hopper:add_container({
			{"top", "default:chest_locked_connected_left", "main"}, 
			{"bottom", "default:chest_locked_connected_left", "main"},
			{"side", "default:chest_locked_connected_left", "main"}, 

			{"top", "default:chest_locked_connected_right", "main"}, 
			{"bottom", "default:chest_locked_connected_right", "main"},
			{"side", "default:chest_locked_connected_right", "main"}, 
		})
			
		add_node("default:chest_locked_connected_right", "default:chest_locked_connected_left")
			
		if minetest.settings:get_bool("open_chest_support") or false then
			hopper:add_container({
				{"top", "default:chest_locked_connected_left_open", "main"}, 
				{"bottom", "default:chest_locked_connected_left_open", "main"},
				{"side", "default:chest_locked_connected_left_open", "main"}, 

				{"top", "default:chest_locked_connected_right_open", "main"}, 
				{"bottom", "default:chest_locked_connected_right_open", "main"},
				{"side", "default:chest_locked_connected_right_open", "main"}, 
			})
			
			add_node("default:chest_locked_connected_right_open", "default:chest_locked_connected_left_open")
		end
	end
end

--This adds support for elepower stuff

if minetest.get_modpath("elepower_machines") then
	hopper:add_container({
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
	
	if minetest.settings:get_bool("protected_chest_support") or false then
		hopper:add_container({
			{"top", "technic:iron_locked_chest", "main"}, 
			{"bottom", "technic:iron_locked_chest", "main"},
			{"side", "technic:iron_locked_chest", "main"}, 

			{"top", "technic:copper_locked_chest", "main"}, 
			{"bottom", "technic:copper_locked_chest", "main"},
			{"side", "technic:copper_locked_chest", "main"}, 

			{"top", "technic:silver_locked_chest", "main"}, 
			{"bottom", "technic:silver_locked_chest", "main"},
			{"side", "technic:silver_locked_chest", "main"}, 

			{"top", "technic:gold_locked_chest", "main"}, 
			{"bottom", "technic:gold_locked_chest", "main"},
			{"side", "technic:gold_locked_chest", "main"}, 

			{"top", "technic:mithril_locked_chest", "main"}, 
			{"bottom", "technic:mithril_locked_chest", "main"},
			{"side", "technic:mithril_locked_chest", "main"}, 
		})
	end
end

if minetest.getmodpath("connected_chests") then
	local node_neighbors = {}
	for _, pair in ipairs(different_nodes) do
		table.insert(node_neighbors, pair[1])
	end

	local near_nodes = {
		{x = 0, y = 1, z = 0},
		{x = 0, y = -1, z = 0},
		{x = 0, y = 0, z = 1},
		{x = 0, y = 0, z = -1},
		{x = 1, y = 0, z = 0},
		{x = -1, y = 0, z = 0}
	}

	local function get_near_nodes(pos)
		local near_positions = {}
		for _, direction in ipairs(near_nodes) do
			table.insert(near_positions, vector.add(pos, direction))
			end
		return near_positions
	end

	function is_neighbor(a)
		for _, v in ipairs(hopper.neighbors) do
			if v == a then
				return true
			end
		end
		return false
	end

	--[[The abm code is modified by me but the original code is from the hoppers mod by tenplus1 and facedeer. The original code can be found here https://content.minetest.net/packages/FaceDeer/hopper/ .]]

	--hopper workings
	minetest.register_abm({
		label = "Hopper transfer",
		nodenames = {"hopper:hopper", "hopper:hopper_side"},
		interval = 1.0,
		chance = 1.0,
		catch_up = false,
	
		action = function(pos, node, active_object_count, active_object_count_wider)
			local near_nodes = get_near_nodes(pos)
			for _, near_pos in ipairs(near_nodes) do
				local source_pos, destination_pos, destination_dir
				if node.name == "hopper:hopper_side" then
					source_pos = vector.add(pos, directions[node.param2].src)
					destination_dir = directions[node.param2].dst
					destination_pos = vector.add(pos, destination_dir)
				else
					destination_dir = bottomdir(node.param2)
					source_pos = vector.subtract(pos, destination_dir)
					destination_pos = vector.add(pos, destination_dir)
				end
			
				local output_direction
				if destination_dir.y == 0 then
					output_direction = "horizontal"
				end
			
				local source_node = minetest.get_node(source_pos)
				local destination_node = minetest.get_node(destination_pos)
			
				local node = minetest.get_node(near_pos)
				
				local function run_hopper_transfer_logic()
					local registered_source_inventories = hopper.get_registered_inventories_for(source_node.name)
						if registered_source_inventories ~= nil then
							hopper.take_item_from(pos, source_pos, source_node, registered_source_inventories["top"])
						end

						local registered_destination_inventories = hopper.get_registered_inventories_for(destination_node.name)
						if registered_destination_inventories ~= nil then
							if output_direction == "horizontal" then
								hopper.send_item_to(pos, destination_pos, destination_node, registered_destination_inventories["side"])
							else
								hopper.send_item_to(pos, destination_pos, destination_node, registered_destination_inventories["bottom"])
							end
						else
							hopper.send_item_to(pos, destination_pos, destination_node) -- for handling ejection
						end
					end
		
					local function run_send_logic()
						local registered_destination_inventories = hopper.get_registered_inventories_for(destination_node.name)
						if registered_destination_inventories ~= nil then
							if output_direction == "horizontal" then
								hopper.send_item_to(pos, destination_pos, destination_node, registered_destination_inventories["side"])
							else
								hopper.send_item_to(pos, destination_pos, destination_node, registered_destination_inventories["bottom"])
							end
						else
							hopper.send_item_to(pos, destination_pos, destination_node) -- for handling ejection
						end
					end
		
					local function run_take_logic()
						local registered_source_inventories = hopper.get_registered_inventories_for(source_node.name)
						if registered_source_inventories ~= nil then
							hopper.take_item_from(pos, source_pos, source_node, registered_source_inventories["top"])
						end
					end
		
					for _, data in pairs(different_nodes) do
						if source_node.name == data[1] or destination_node.name == data[1] then
							if destination_node.name == data[1] and is_neighbor(source_node.name) then
								for _, direction in pairs(directions) do
									local adjacent_pos = vector.add(destination_pos, direction.dst)
									local adjacent_node = minetest.get_node(adjacent_pos)
									if adjacent_node.name == data[2] then
										destination_node = adjacent_node
										destination_pos = adjacent_pos
										break
									end
								end
				
								run_send_logic()
							end
		
						if source_node.name == data[1] and is_neighbor(destination_node.name) then
							for _, direction in pairs(directions) do
								local adjacent_pos = vector.add(source_pos, direction.dst)
								local adjacent_node = minetest.get_node(adjacent_pos)
								if adjacent_node.name == data[2] then
									source_node = adjacent_node
									source_pos = adjacent_pos
									break
								end
							end
							run_take_logic()
						end
								
						if not is_neighbor(source_node.name) and destination_node.name == data[1] then
							for _, direction in pairs(directions) do
								local adjacent_pos = vector.add(destination_pos, direction.dst)
								local adjacent_node = minetest.get_node(adjacent_pos)
								if adjacent_node.name == data[2] then
								destination_node = adjacent_node
									destination_pos = adjacent_pos
									break
								end
							end
							run_hopper_transfer_logic()
						end
				
						if not is_neighbor(destination_node.name) and source_node.name == data[1] then
							for _, direction in pairs(directions) do
								local adjacent_pos = vector.add(source_pos, direction.dst)
								local adjacent_node = minetest.get_node(adjacent_pos)
								if adjacent_node.name == data[2] then
									source_node = adjacent_node
									source_pos = adjacent_pos
									break
								end
							end
				
							run_take_logic()
						end	
					end			
				end
				break
			end
		end,
	})


	minetest.register_abm({
		label = "Hopper transfer",
		nodenames = {"hopper:hopper", "hopper:hopper_side"},
		neighbors = ndde_neighbors, neighbors,
		interval = 1.0,
		chance = 1.0,
		catch_up = false,

		action = function(pos, node, active_object_count, active_object_count_wider)
			local source_pos, destination_pos, destination_dir
			if node.name == "hopper:hopper_side" then
				source_pos = vector.add(pos, directions[node.param2].src)
				destination_dir = directions[node.param2].dst
				destination_pos = vector.add(pos, destination_dir)
			else
				destination_dir = bottomdir(node.param2)
				source_pos = vector.subtract(pos, destination_dir)
				destination_pos = vector.add(pos, destination_dir)
			end
		
			local output_direction
			if destination_dir.y == 0 then
				output_direction = "horizontal"
			end
		
			local source_node = minetest.get_node(source_pos)
			local destination_node = minetest.get_node(destination_pos)
		
			local function run_hopper_transfer_logic()
				local registered_source_inventories = hopper.get_registered_inventories_for(source_node.name)
				if registered_source_inventories ~= nil then
					hopper.take_item_from(pos, source_pos, source_node, registered_source_inventories["top"])
				end

				local registered_destination_inventories = hopper.get_registered_inventories_for(destination_node.name)
				if registered_destination_inventories ~= nil then
					if output_direction == "horizontal" then
						hopper.send_item_to(pos, destination_pos, destination_node, registered_destination_inventories["side"])
					else
						hopper.send_item_to(pos, destination_pos, destination_node, registered_destination_inventories["bottom"])
					end
				else
					hopper.send_item_to(pos, destination_pos, destination_node) -- for handling ejection
				end
			end
		
			local function run_send_logic()
				local registered_destination_inventories = hopper.get_registered_inventories_for(destination_node.name)
				if registered_destination_inventories ~= nil then
					if output_direction == "horizontal" then
						hopper.send_item_to(pos, destination_pos, destination_node, registered_destination_inventories["side"])
					else
						hopper.send_item_to(pos, destination_pos, destination_node, registered_destination_inventories["bottom"])
					end
				else
					hopper.send_item_to(pos, destination_pos, destination_node) -- for handling ejection
				end
			end
		
			local function run_take_logic()
				local registered_source_inventories = hopper.get_registered_inventories_for(source_node.name)
				if registered_source_inventories ~= nil then
					hopper.take_item_from(pos, source_pos, source_node, registered_source_inventories["top"])
				end
			end
		
			function is_neighbor(a)
				for _, v in ipairs(hopper.neighbors) do
					if v == a then
						return true
					end
				end
				return false
			end
		
			if not is_neighbor(source_node.name) and not is_neighbor(destination_node.name) then 
				run_send_logic()
			end
		end,
	})
end
