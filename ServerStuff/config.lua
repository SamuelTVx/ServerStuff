Config = {}

-- Dance Positions for Stripters --

--[[Config['PoleDance'] = { 
    ['Enabled'] = true,
    ['Locations'] = {
        {['Position'] = vector3(108.83602905273, -1289.0072021484, 29.249711990356), ['Number'] = '3'},
        {['Position'] = vector3(102.04642486572, -1289.9429931641, 29.249713897705), ['Number'] = '1'},
        {['Position'] = vector3(104.71472930908, -1294.1346435547, 29.249708175659), ['Number'] = '2'} --      --  {['Position'] = vector3(104.18, -1293.94, 29.26), ['Number'] = '1'},
        --   {['Position'] = vector3(102.24, -1290.54, 29.26), ['Number'] = '2'}
    }
}

Strings = {
    ['Pole_Dance'] = '[E] Dance',
}--]]

-- Vehicle Durability --

--[[cfg = {
	deformationMultiplier = -1,					-- How much should the vehicle visually deform from a collision. Range 0.0 to 10.0 Where 0.0 is no deformation and 10.0 is 10x deformation. -1 = Don't touch. Visual damage does not sync well to other players.
	deformationExponent = 0.4,					-- How much should the handling file deformation setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.
	collisionDamageExponent = 0.5,				-- How much should the handling file deformation setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.

	damageFactorEngine = 5.0,					-- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 10
	damageFactorBody = 5.0,					-- Sane values are 1 to 100. Higher values means more damage to vehicle. A good starting point is 10
	damageFactorPetrolTank = 64.0,				-- Sane values are 1 to 200. Higher values means more damage to vehicle. A good starting point is 64
	engineDamageExponent = 0.7,					-- How much should the handling file engine damage setting be compressed toward 1.0. (Make cars more similar). A value of 1=no change. Lower values will compress more, values above 1 it will expand. Dont set to zero or negative.
	weaponsDamageMultiplier = 0.01,				-- How much damage should the vehicle get from weapons fire. Range 0.0 to 10.0, where 0.0 is no damage and 10.0 is 10x damage. -1 = don't touch
	degradingHealthSpeedFactor = 10,			-- Speed of slowly degrading health, but not failure. Value of 10 means that it will take about 0.25 second per health point, so degradation from 800 to 305 will take about 2 minutes of clean driving. Higher values means faster degradation
	cascadingFailureSpeedFactor = 8.0,			-- Sane values are 1 to 100. When vehicle health drops below a certain point, cascading failure sets in, and the health drops rapidly until the vehicle dies. Higher values means faster failure. A good starting point is 8

	degradingFailureThreshold = 800.0,			-- Below this value, slow health degradation will set in
	cascadingFailureThreshold = 360.0,			-- Below this value, health cascading failure will set in
	engineSafeGuard = 100.0,					-- Final failure value. Set it too high, and the vehicle won't smoke when disabled. Set too low, and the car will catch fire from a single bullet to the engine. At health 100 a typical car can take 3-4 bullets to the engine before catching fire.

	torqueMultiplierEnabled = true,				-- Decrease engine torque as engine gets more and more damaged

	limpMode = true,							-- If true, the engine never fails completely, so you will always be able to get to a mechanic unless you flip your vehicle and preventVehicleFlip is set to true
	limpModeMultiplier = 0.15,					-- The torque multiplier to use when vehicle is limping. Sane values are 0.05 to 0.25

	preventVehicleFlip = true,					-- If true, you can't turn over an upside down vehicle

	sundayDriver = true,						-- If true, the accelerator response is scaled to enable easy slow driving. Will not prevent full throttle. Does not work with binary accelerators like a keyboard. Set to false to disable. The included stop-without-reversing and brake-light-hold feature does also work for keyboards.
	sundayDriverAcceleratorCurve = 7.5,			-- The response curve to apply to the accelerator. Range 0.0 to 10.0. Higher values enables easier slow driving, meaning more pressure on the throttle is required to accelerate forward. Does nothing for keyboard drivers
	sundayDriverBrakeCurve = 5.0,				-- The response curve to apply to the Brake. Range 0.0 to 10.0. Higher values enables easier braking, meaning more pressure on the throttle is required to brake hard. Does nothing for keyboard drivers

	displayBlips = true,						-- Show blips for mechanics locations

	compatibilityMode = false,					-- prevents other scripts from modifying the fuel tank health to avoid random engine failure with BVA 2.01 (Downside is it disabled explosion prevention)

	randomTireBurstInterval = 0,				-- Number of minutes (statistically, not precisely) to drive above 22 mph before you get a tire puncture. 0=feature is disabled


	-- Class Damagefactor Multiplier
	-- The damageFactor for engine, body and Petroltank will be multiplied by this value, depending on vehicle class
	-- Use it to increase or decrease damage for each class

	classDamageMultiplier = {
		[0] = 	0.5,		--	0: Compacts
				0.5,		--	1: Sedans
				0.5,		--	2: SUVs
				0.5,		--	3: Coupes
				0.5,		--	4: Muscle
				0.5,		--	5: Sports Classics
				0.5,		--	6: Sports
				0.5,		--	7: Super
				0.25,		--	8: Motorcycles
				0.7,		--	9: Off-road
				0.25,		--	10: Industrial
				0.5,		--	11: Utility
				0.5,		--	12: Vans
				0.5,		--	13: Cycles
				0.5,		--	14: Boats
				0.5,		--	15: Helicopters
				0.5,		--	16: Planes
				0.5,		--	17: Service
				0.75,		--	18: Emergency
				0.75,		--	19: Military
				0.5,		--	20: Commercial
				0.5			--	21: Trains
	}
}

Config.Invincible = true -- Is the ped going to be invincible?
Config.Frozen = true -- Is the ped frozen in place?
Config.Stoic = true -- Will the ped react to events around them?
Config.FadeIn = true -- Will the ped fade in and out based on the distance. (Looks a lot better.)
Config.DistanceSpawn = 20.0 -- Distance before spawning/despawning the ped. (GTA Units.)

Config.MinusOne = true -- Leave this enabled if your coordinates grabber does not -1 from the player coords.

Config.GenderNumbers = { -- No reason to touch these.
	['male'] = 4,
	['female'] = 5
}--]]

-- Add some Peds!! --

Config.PedList = {
	--[[ TEMPLATE
	{
		model = `PED MODEL`, 
		coords = vector4(COORDS), -- (X, Y, Z, Heading)
		gender = 'GENDER' (Female, Male)
	}--]]
}

-- DONT CHANGE THIS --

Config.Area = {

    cayo = {
        coords = vector3(4450.457, -4482.303, 4.224121),
        width = 900.0,
        height = 1300.0,
        color = 25,
        alpha = 128,
        rotation = 140
    },

    cayo2 = {
        coords = vector3(5167.279, -5370.765, 42.35535),
        width = 1330.0,
        height = 1550.0,
        color = 76,
        alpha = 128,
        rotation = 140
    },

}

-- GYM --

Config.Exercises = {
    ["Kliky"] = {
        ["idleDict"] = "amb@world_human_push_ups@male@idle_a",
        ["idleAnim"] = "idle_c",
        ["actionDict"] = "amb@world_human_push_ups@male@base",
        ["actionAnim"] = "base",
        ["actionTime"] = 1100,
        ["enterDict"] = "amb@world_human_push_ups@male@enter",
        ["enterAnim"] = "enter",
        ["enterTime"] = 3050,
        ["exitDict"] = "amb@world_human_push_ups@male@exit",
        ["exitAnim"] = "exit",
        ["exitTime"] = 3400,
        ["actionProcent"] = 1,
        ["actionProcentTimes"] = 3,
    },
    ["Sedylehy"] = {
        ["idleDict"] = "amb@world_human_sit_ups@male@idle_a",
        ["idleAnim"] = "idle_a",
        ["actionDict"] = "amb@world_human_sit_ups@male@base",
        ["actionAnim"] = "base",
        ["actionTime"] = 3400,
        ["enterDict"] = "amb@world_human_sit_ups@male@enter",
        ["enterAnim"] = "enter",
        ["enterTime"] = 4200,
        ["exitDict"] = "amb@world_human_sit_ups@male@exit",
        ["exitAnim"] = "exit", 
        ["exitTime"] = 3700,
        ["actionProcent"] = 1,
        ["actionProcentTimes"] = 10,
    },
    ["Zdvihy"] = {
        ["idleDict"] = "amb@prop_human_muscle_chin_ups@male@idle_a",
        ["idleAnim"] = "idle_a",
        ["actionDict"] = "amb@prop_human_muscle_chin_ups@male@base",
        ["actionAnim"] = "base",
        ["actionTime"] = 3000,
        ["enterDict"] = "amb@prop_human_muscle_chin_ups@male@enter",
        ["enterAnim"] = "enter",
        ["enterTime"] = 1600,
        ["exitDict"] = "amb@prop_human_muscle_chin_ups@male@exit",
        ["exitAnim"] = "exit",
        ["exitTime"] = 3700,
        ["actionProcent"] = 1,
        ["actionProcentTimes"] = 10,
    },
}

Config.Locations = { 
    -- Beach
    {["x"] = -1200.08, ["y"] = -1571.15, ["z"] = 4.6115 - 0.98, ["h"] = 214.37, ["exercise"] = "Zdvihy"},
    {["x"] = -1205.0118408203, ["y"] = -1560.0671386719,["z"] = 4.614236831665 - 0.98, ["h"] = nil, ["exercise"] = "Sedylehy"},
    {["x"] = -1203.3094482422, ["y"] = -1570.6759033203, ["z"] = 4.6079330444336 - 0.98, ["h"] = nil, ["exercise"] = "Kliky"},
    {["x"] = -1422.0118408203, ["y"] = -1071.0671386719,["z"] = 3.414236831665 - 1.08, ["h"] = nil, ["exercise"] = "Sedylehy"},
    -- Prison
    { ['x'] = 1665.68, ['y'] = 2577.4, ['z'] = 45.6 - 0.98, ["h"] = 271.0, ["exercise"] = "Zdvihy"},
    { ['x'] = -1424.04, ['y'] = -1059.87, ['z'] = 4.6 - 0.98, ["h"] = 37.0, ["exercise"] = "Zdvihy"},
    { ['x'] = 1671.4, ['y'] = 2580.56, ['z'] = 45.6 - 0.98, ["h"] = nil, ["exercise"] = "Sedylehy"},
    { ['x'] = 1670.84, ['y'] = 2577.2, ['z'] = 45.6  - 0.98, ["h"] = nil, ["exercise"] = "Kliky"},
}

Config.LocationsYoga = {
    { ['x'] = -1195.84, ['y'] = -1567.96, ['z'] = 4.64 - 0.98, ["h"] = nil, ["exercise"] = "Yoga"},
    { ['x'] = 482.56, ['y'] = -999.84, ['z'] = 35.92 - 0.98, ["h"] = nil, ["exercise"] = "Yoga"},
    { ['x'] = -1110.22, ['y'] = -837.7, ['z'] = 26.85 - 0.98, ["h"] = nil, ["exercise"] = "Yoga"}, 
    { ['x'] = -1108.72, ['y'] = -836.47, ['z'] = 26.85 - 0.98, ["h"] = nil, ["exercise"] = "Yoga"}, 
}

Config.LocationsHands = {
    { ['x'] = -1202.76, ['y'] = -1565.32, ['z'] = 4.6 - 0.98, ["h"] = nil, ["exercise"] = "Činky"},
    { ['x'] = 1668.28, ['y'] = 2580.12, ['z'] = 45.6 - 0.98, ["h"] = nil, ["exercise"] = "Činky"},
    { ['x'] = -1098.9, ['y'] = -840.85, ['z'] = 26.03 - 0.98, ["h"] = nil, ["exercise"] = "Činky"},
    { ['x'] = -1097.44, ['y'] = -842.4, ['z'] = 26.83 - 0.98, ["h"] = nil, ["exercise"] = "Činky"},
    { ['x'] = 487.0, ['y'] = -1012.44, ['z'] = 35.92 - 0.98, ["h"] = nil, ["exercise"] = "Činky"},
    { ['x'] = 479.36, ['y'] = -1013.76, ['z'] = 35.92 - 0.98, ["h"] = nil, ["exercise"] = "Činky"},
}

Config.Blips = {
    [1] = {["x"] = -1201.0078125, ["y"] = -1568.3903808594, ["z"] = 4.6110973358154, ["id"] = 311, ["color"] = 49, ["scale"] = 1.0, ["text"] = "GYM"},
}

-- THIS IGNORE TOO --

Config.Hospitals = {

	CentralLosSantos = {



	

		FastTravels = {
			{
				From = vector3(240.9387512207, -1379.2755126953, 33.741828918457),
				To = {coords = vector3(272.0205078125, -1358.6544189453, 23.537799835205), heading = 43.0},
				Marker = {type = -1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			},

			{
				From = vector3(274.6799621582, -1360.7120361328, 24.5378074646),
				To = {coords = vector3(239.26014709473, -1381.3767089844, 32.741828918457), heading = 150.11},
				Marker = {type = -1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			}

		
		}

		

	}
}


