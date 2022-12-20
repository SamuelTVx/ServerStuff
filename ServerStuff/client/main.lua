
-- THIS LOOKS GOOD -- (Dont Forget to change the "Template")

RegisterCommand("job", function(source, raw, arg1)
    local id = ESX.PlayerData.job.label 
    local id2 = ESX.PlayerData.job.grade_label
    TriggerEvent('chat:addMessage', {
        template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.4); border-radius: 3px; border-right: 0px solid rgb(255, 0, 0);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(0, 194, 26); border-radius: 5px; font-size: 15px;"> <b>TEMPLATE</b></font>   <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;"> <b> Tvoje zamestnanie­ je |</b></font>  <font style=" font-weight: 800; font-size: 15px; margin-left: 5px; padding-bottom: 3px; border-radius: 0px;"><b></b></font><font style=" font-weight: 200; font-size: 14px; border-radius: 0px;">{0} {1}</font></div>',
        args = { id, id2 }
    })	
end, false)

RegisterCommand("id", function(source, raw, arg1)
    local id = GetPlayerServerId(NetworkGetEntityOwner(PlayerPedId()))
    TriggerEvent('chat:addMessage', {
        template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(24, 26, 32, 0.4); border-radius: 3px; border-right: 0px solid rgb(255, 0, 0);"><font style="padding: 0.22vw; margin: 0.22vw; background-color: rgb(0, 194, 26); border-radius: 5px; font-size: 15px;"> <b>TEMPLATE</b></font>   <font style="background-color:rgba(0, 0, 0, 0); font-size: 17px; margin-left: 0px; padding-bottom: 2.5px; padding-left: 3.5px; padding-top: 2.5px; padding-right: 3.5px;border-radius: 0px;"> <b> Tvoje ID je |</b></font>  <font style=" font-weight: 800; font-size: 15px; margin-left: 5px; padding-bottom: 3px; border-radius: 0px;"><b></b></font><font style=" font-weight: 200; font-size: 14px; border-radius: 0px;">{0}</font></div>',
        args = { id }
    })	
end, false)

-- IGNORE THIS --

local inBedDict = "anim@gangops@morgue@table@"
local inBedAnim = "ko_front"
local getOutDict = 'switch@franklin@bed'
local getOutAnim = 'sleep_getup_rubeyes'
local inbed = false

-- QTARGET BED --

RegisterNetEvent('sm:bed')
AddEventHandler('sm:bed', function()
    local player = PlayerPedId()
    local pedCoords = GetEntityCoords(player)
    local bedObject = GetClosestObjectOfType(pedCoords, 2.00, 1631638868, false, false, false) 
    local bedcoords = GetEntityCoords(bedObject)
    local bedheading = GetEntityHeading(bedObject)
    local wantedheading = 180 + bedheading
    FreezeEntityPosition(bedObject, true)
    SetEntityCoords(player, bedcoords, false, false, false, false)

    RequestAnimDict(inBedDict)
    while not HasAnimDictLoaded(inBedDict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), inBedDict , inBedAnim ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(PlayerPedId(), wantedheading)
    ESX.ShowNotification('Klikni [E] pre odchod')
    inbed = true
end)

RegisterNetEvent('sm:bedleave')
AddEventHandler('sm:bedleave', function()
    RequestAnimDict(getOutDict)
    while not HasAnimDictLoaded(getOutDict) do
        Citizen.Wait(0)
    end

    SetEntityInvincible(PlayerPedId(), false)
    
    TaskPlayAnim(PlayerPedId(), getOutDict , getOutAnim ,8.0, -8.0, -1, 0, 0, false, false, false )
    Citizen.Wait(5000)
    ClearPedTasks(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    
    FreezeEntityPosition(bedObject, false)
    inbed = false
end)

Citizen.CreateThread(function()
    while true do
   local sleep = 500
       if inbed then
        sleep = 0
        if IsControlJustReleased(0, 38) then
            TriggerEvent('sm:bedleave')
       end
    end
       Citizen.Wait(sleep)
    end
end)

exports['qtarget']:AddTargetModel({1631638868}, {
        options = {
            {
                event = "sm:bed",
                icon = "fas fa-briefcase",
                label = "Lahnúť si na posteľ",
            },
        },
        distance = 4.0
})

















ESX = nil

--[[
Add this to your databse under items 

greenchair

classicchair

bluechair

officechair
]]
Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "esx:getSharedObject",
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(0)
        end
    end
)

local ListaObjekata = {
	`prop_off_chair_05`, --Classic one 
    `prop_skid_chair_01`, --green one 
    `prop_skid_chair_02`, -- blue one I guess lol
    `ex_prop_offchair_exec_03` --Office chair
}



AddEventHandler("chair:spawn")
RegisterNetEvent("chair:spawn", function()
    x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    local heading = GetEntityHeading(PlayerPedId())

    chair = `prop_skid_chair_01`

    RequestModel(chair)
    while not HasModelLoaded(chair) do
      Citizen.Wait(1)
    end

    local object = CreateObject(chair, x, y, z-2, true, true, false) -- x+1
    PlaceObjectOnGroundProperly(object)
    SetEntityHeading(object, heading + 180)
    FreezeEntityPosition(object, true)
  
    SetModelAsNoLongerNeeded(object)
    local ped = PlayerPedId()
    SetEntityCoords(ped, x, y, z- 1.0, false, false, false, true)
     --   TaskStartScenarioInPlace(ped, "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", 0, true)
    
end)

AddEventHandler("chair:spawn2")
RegisterNetEvent("chair:spawn2", function()
    x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    local heading = GetEntityHeading(PlayerPedId())

    chair2 = `prop_off_chair_05`

    RequestModel(chair2)
    while not HasModelLoaded(chair2) do
      Citizen.Wait(1)
    end

    local object = CreateObject(chair2, x+1, y, z-2, true, true, false) -- x+1
    PlaceObjectOnGroundProperly(object)
    SetEntityHeading(object, heading + 180)
    FreezeEntityPosition(object, true)
    SetModelAsNoLongerNeeded(object)
end)

AddEventHandler("chair:spawn3")
RegisterNetEvent("chair:spawn3", function()
    x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    local heading = GetEntityHeading(PlayerPedId())

    chair3 = `prop_skid_chair_02`

    RequestModel(chair3)
    while not HasModelLoaded(chair3) do
      Citizen.Wait(1)
    end

    local object = CreateObject(chair3, x+1, y, z-2, true, true, false) -- x+1
    PlaceObjectOnGroundProperly(object)
    SetEntityHeading(object, heading + 180)
    FreezeEntityPosition(object, true)
    SetModelAsNoLongerNeeded(object)
end)

AddEventHandler("chair:spawn3")
RegisterNetEvent("chair:spawn3", function()
    x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    local heading = GetEntityHeading(PlayerPedId())

    chair3 = `prop_skid_chair_02`

    RequestModel(chair3)
    while not HasModelLoaded(chair3) do
      Citizen.Wait(1)
    end

    local object = CreateObject(chair3, x+1, y, z-2, true, true, false) -- x+1
    PlaceObjectOnGroundProperly(object)
    SetEntityHeading(object, heading + 180)
    FreezeEntityPosition(object, true)
    SetModelAsNoLongerNeeded(object)
end)

AddEventHandler("chair:spawn4")
RegisterNetEvent("chair:spawn4", function()
    x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    local heading = GetEntityHeading(PlayerPedId())

    chair4 = `ex_prop_offchair_exec_03`

    RequestModel(chair4)
    while not HasModelLoaded(chair4) do
      Citizen.Wait(1)
    end

    local object = CreateObject(chair4, x+1, y, z-2, true, true, false) -- x+1
    PlaceObjectOnGroundProperly(object)
    SetEntityHeading(object, heading + 180)
    FreezeEntityPosition(object, true)
    SetModelAsNoLongerNeeded(object)
end)


RegisterCommand(
    "takechair",
    function()
        for i = 1, #ListaObjekata do
            local obb = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 5.0, ListaObjekata[i], false, true, true)
            if DoesEntityExist(obb) then
                NetworkRequestControlOfEntity(obb)
                while not NetworkHasControlOfEntity(obb) do
                    Wait(100)
                end
                DeleteEntity(obb)
                DeleteObject(obb)
                break
            end
        end
        ESX.ShowNotification('You took your ~b~5$~w~ chair!')
    end
)

RegisterCommand("newdance1",function(source, args)

	local ad = "anim@amb@nightclub@dancers@black_madonna_entourage@"
	local anim = "li_dance_facedj_11_v1_male^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance2",function(source, args)

	local ad = "anim@amb@nightclub@dancers@black_madonna_entourage@"
	local anim = "hi_dance_facedj_09_v2_male^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance3",function(source, args)

	local ad = "anim@amb@nightclub@dancers@black_madonna_entourage@"
	local anim = "li_dance_facedj_15_v2_male^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance4",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local anim = "mi_dance_prop_15_v1_male^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance5",function(source, args)

	local ad = "anim@amb@nightclub@djs@dixon@"
	local anim = "dixn_dance_a_dixon"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance6",function(source, args)

	local ad = "anim@amb@nightclub@djs@solomun@"
	local anim = "sol_trans_out_to_rt_a_sol"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance7",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v1_female^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance8",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v1_female^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance9",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v1_female^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance10",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v1_female^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance11",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v1_female^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance12",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v1_female^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance13",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v1_male^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance14",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v1_male^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance15",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v1_male^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance16",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v1_male^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance17",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v1_male^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance18",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v1_male^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance19",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v2_female^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance20",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v2_female^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance21",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v2_female^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance22",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v2_female^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance23",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v2_female^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance24",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v2_female^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance25",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v2_male^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance26",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v2_male^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance27",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v2_male^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance28",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v2_male^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance29",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v2_male^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance30",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v2_male^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance31",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v1_female^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance32",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v1_female^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance33",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v1_female^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance34",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v1_female^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance35",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v1_female^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance36",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v1_female^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance37",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v1_male^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance38",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v1_male^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance39",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v1_male^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance40",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v1_male^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance41",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v1_male^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance42",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v1_male^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance43",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v2_female^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance44",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v2_female^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance45",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v2_female^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance46",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v2_female^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance47",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v2_female^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance48",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v2_female^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance49",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v2_male^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance50",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v2_male^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance51",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v2_male^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance52",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v2_male^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance53",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v2_male^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance54",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v2_male^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance55",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v1_female^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance56",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v1_female^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance57",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v1_female^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance58",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v1_female^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance59",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v1_female^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance60",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v1_female^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)



RegisterCommand("newdance61",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v1_male^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance62",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v1_male^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance63",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v1_male^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance64",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v1_male^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance65",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v1_male^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance66",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v1_male^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance67",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v2_female^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance68",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v2_female^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance69",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v2_female^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance70",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v2_female^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance71",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v2_female^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance72",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v2_female^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance73",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity"
	local anim = "hi_dance_facedj_09_v1_female^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance74",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity"
	local anim = "hi_dance_facedj_09_v1_female^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance75",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity"
	local anim = "hi_dance_facedj_09_v1_female^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance74",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity"
	local anim = "hi_dance_facedj_09_v1_female^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance75",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity"
	local anim = "hi_dance_facedj_09_v1_female^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance76",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity"
	local anim = "hi_dance_facedj_09_v1_female^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance77",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity"
	local anim = "trans_dance_crowd_li_to_hi_09_v1_male^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance78",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity"
	local anim = "trans_dance_crowd_li_to_hi_09_v1_male^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance79",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity"
	local anim = "trans_dance_crowd_li_to_hi_09_v1_male^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance80",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity"
	local anim = "trans_dance_crowd_li_to_hi_09_v1_male^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance81",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity"
	local anim = "trans_dance_crowd_li_to_hi_09_v1_male^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance82",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity"
	local anim = "trans_dance_crowd_li_to_hi_09_v1_male^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance83",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity"
	local anim = "trans_dance_crowd_mi_to_hi_09_v1_male^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance84",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity"
	local anim = "trans_dance_crowd_mi_to_hi_09_v1_male^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance85",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity"
	local anim = "trans_dance_crowd_mi_to_hi_09_v1_male^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance86",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity"
	local anim = "trans_dance_crowd_mi_to_hi_09_v1_male^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance87",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity"
	local anim = "trans_dance_crowd_mi_to_hi_09_v1_male^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance88",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity"
	local anim = "trans_dance_crowd_mi_to_hi_09_v1_male^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance89",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local anim = "hi_dance_prop_09_v1_female^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance90",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local anim = "hi_dance_prop_09_v1_female^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance91",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local anim = "hi_dance_prop_09_v1_female^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance92",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local anim = "hi_dance_prop_09_v1_female^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance93",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local anim = "hi_dance_prop_09_v1_female^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance94",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local anim = "hi_dance_prop_09_v1_female^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance95",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local anim = "hi_dance_prop_09_v1_male^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance96",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local anim = "hi_dance_prop_09_v1_male^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance97",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local anim = "hi_dance_prop_09_v1_male^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance98",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local anim = "hi_dance_prop_09_v1_male^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

RegisterCommand("newdance99",function(source, args)

	local ad = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local anim = "hi_dance_prop_09_v1_male^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE ----------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand("dance100",function(source, args)

	local ad = ""
	local anim = ""
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE ----------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local validWeapons = {
	-- Pistols
	'WEAPON_PISTOL',
	'WEAPON_PISTOL_MK2',
	'WEAPON_COMBATPISTOL',
	'WEAPON_APPISTOL',
	'WEAPON_PISTOL50',
	'WEAPON_SNSPISTOL',
	'WEAPON_SNSPISTOL_MK2',
	'WEAPON_REVOLVER',
	'WEAPON_REVOLVER_MK2',
	'WEAPON_HEAVYPISTOL',
	'WEAPON_VINTAGEPISTOL',
	'WEAPON_MARKSMANPISTOL',
	-- SMGs
	'WEAPON_MICROSMG',
	'WEAPON_MACHINEPISTOL',
}

function KillYourself()
	Citizen.CreateThread(function()
		local playerPed = GetPlayerPed(-1)

		local canSuicide = false
		local foundWeapon = nil

		for i=1, #validWeapons do
			if HasPedGotWeapon(playerPed, GetHashKey(validWeapons[i]), false) then
				if GetAmmoInPedWeapon(playerPed, GetHashKey(validWeapons[i])) > 0 then
					canSuicide = true
					foundWeapon = GetHashKey(validWeapons[i])

					break
				end
			end
		end

		if canSuicide then
			if not HasAnimDictLoaded('mp_suicide') then
				RequestAnimDict('mp_suicide')
				
				while not HasAnimDictLoaded('mp_suicide') do
					Wait(1)
				end
			end

			SetCurrentPedWeapon(playerPed, foundWeapon, true)

			TaskPlayAnim(playerPed, "mp_suicide", "pistol", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
            ExecuteCommand('911ems Miestny okolojedĂşci: ZdravĂ­ÄŤko prĂˇve som niekoho videl ako si tu prestrelil hlavu mĂ´Ĺľte prosĂ­m prĂ­sĹĄ?')
            ExecuteCommand('me PrikladĂˇ si k hlave zbraĹ a striela')
            ExecuteCommand('do Prestrelil si hlavu, vytiekol mu mozog, nemĂˇ tep ani dech, je mrtev.')
			Wait(750)

			SetPedShootsAtCoord(playerPed, 0.0, 0.0, 0.0, 0)
			SetEntityHealth(playerPed, 0)
		end
	end)
end

RegisterCommand('kys', function()
	KillYourself()  
end, false)

RegisterNetEvent('drc_core:DonutesesUnPack')
AddEventHandler('drc_core:DonutesesUnPack', function(source)
	local playerPed = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(playerPed))
    TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8.0, 5500, 33, 0, false, false, false)
    pack = CreateObject(GetHashKey('prop_food_cb_donuts'), x, y, z+0.9,  true,  true, true)
	AttachEntityToEntity(pack, playerPed, GetPedBoneIndex(playerPed, 64016), 0.020, -0.05, -0.010, 100.0, 0.0, 0.0, true, true, false, true, 1, true)
	Citizen.Wait(3000)
    DeleteObject(pack)

end)

RegisterNetEvent('drc_core:PlzensUnPack')
AddEventHandler('drc_core:PlzensUnPack', function(source)
	local playerPed = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(playerPed))
    TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8.0, 5500, 33, 0, false, false, false)
    pack = CreateObject(GetHashKey('prop_beer_box_01'), x, y, z+0.9,  true,  true, true)
	AttachEntityToEntity(pack, playerPed, GetPedBoneIndex(playerPed, 64016), 0.020, -0.05, -0.010, 100.0, 0.0, 0.0, true, true, false, true, 1, true)
	Citizen.Wait(3000)
    DeleteObject(pack)

end)

RegisterNetEvent('drc_core:KozelsUnPack')
AddEventHandler('drc_core:KozelsUnPack', function(source)
	local playerPed = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(playerPed))
    TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8.0, 5500, 33, 0, false, false, false)
    pack = CreateObject(GetHashKey('prop_beer_box_01'), x, y, z+0.9,  true,  true, true)
	AttachEntityToEntity(pack, playerPed, GetPedBoneIndex(playerPed, 64016), 0.020, -0.05, -0.010, 100.0, 0.0, 0.0, true, true, false, true, 1, true)
	Citizen.Wait(3000)
    DeleteObject(pack)

end)

RegisterNetEvent('drc_core:CoronsUnPack')
AddEventHandler('drc_core:CoronsUnPack', function(source)
	local playerPed = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(playerPed))
    TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8.0, 5500, 33, 0, false, false, false)
    pack = CreateObject(GetHashKey('prop_beer_box_01'), x, y, z+0.9,  true,  true, true)
	AttachEntityToEntity(pack, playerPed, GetPedBoneIndex(playerPed, 64016), 0.020, -0.05, -0.010, 100.0, 0.0, 0.0, true, true, false, true, 1, true)
	Citizen.Wait(3000)
    DeleteObject(pack)

end)
-----------------------------------------------------------ĹľuvaÄŤky-----------------------------------------------------------
RegisterNetEvent('drc_core:spearmintobalUnPack')
AddEventHandler('drc_core:spearmintobalUnPack', function(source)
	local playerPed = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(playerPed))
    TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8.0, 5500, 33, 0, false, false, false)
   -- pack = CreateObject(GetHashKey('hei_heist_acc_box_trinket_02'), x, y, z+0.9,  true,  true, true)
	AttachEntityToEntity(pack, playerPed, GetPedBoneIndex(playerPed, 64016), 0.020, -0.05, -0.010, 100.0, 0.0, 0.0, true, true, false, true, 1, true)
	Citizen.Wait(3000)
    DeleteObject(pack)

end)

RegisterNetEvent('drc_core:melounobalUnPack')
AddEventHandler('drc_core:melounobalUnPack', function(source)
	local playerPed = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(playerPed))
    TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8.0, 5500, 33, 0, false, false, false)
  -- pack = CreateObject(GetHashKey('hei_heist_acc_box_trinket_02'), x, y, z+0.9,  true,  true, true)
	AttachEntityToEntity(pack, playerPed, GetPedBoneIndex(playerPed, 64016), 0.020, -0.05, -0.010, 100.0, 0.0, 0.0, true, true, false, true, 1, true)
	Citizen.Wait(3000)
    DeleteObject(pack)

end)

RegisterNetEvent('drc_core:pepperminobalUnPack')
AddEventHandler('drc_core:pepperminobalUnPack', function(source)
	local playerPed = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(playerPed))
    TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'a_uncuff', 8.0, -8.0, 5500, 33, 0, false, false, false)
    --pack = CreateObject(GetHashKey('hei_heist_acc_box_trinket_02'), x, y, z+0.9,  true,  true, true)
	AttachEntityToEntity(pack, playerPed, GetPedBoneIndex(playerPed, 64016), 0.020, -0.05, -0.010, 100.0, 0.0, 0.0, true, true, false, true, 1, true)
	Citizen.Wait(3000)
    DeleteObject(pack)

end)

local spawnedPeds = {}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		for k,v in pairs(Config.PedList) do
			local playerCoords = GetEntityCoords(PlayerPedId())
			local distance = #(playerCoords - v.coords.xyz)

			if distance < Config.DistanceSpawn and not spawnedPeds[k] then
				local spawnedPed = NearPed(v.model, v.coords, v.gender, v.animDict, v.animName, v.scenario)
				spawnedPeds[k] = { spawnedPed = spawnedPed }
			end

			if distance >= Config.DistanceSpawn and spawnedPeds[k] then
				if Config.FadeIn then
					for i = 255, 0, -51 do
						Citizen.Wait(50)
						SetEntityAlpha(spawnedPeds[k].spawnedPed, i, false)
					end
				end
				DeletePed(spawnedPeds[k].spawnedPed)
				spawnedPeds[k] = nil
			end
		end
	end
end)

function NearPed(model, coords, gender, animDict, animName, scenario)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(50)
	end

	if Config.MinusOne then
		spawnedPed = CreatePed(Config.GenderNumbers[gender], model, coords.x, coords.y, coords.z - 1.0, coords.w, false, true)
	else
		spawnedPed = CreatePed(Config.GenderNumbers[gender], model, coords.x, coords.y, coords.z, coords.w, false, true)
	end

	SetEntityAlpha(spawnedPed, 0, false)

	if Config.Frozen then
		FreezeEntityPosition(spawnedPed, true)
	end

	if Config.Invincible then
		SetEntityInvincible(spawnedPed, true)
	end

	if Config.Stoic then
		SetBlockingOfNonTemporaryEvents(spawnedPed, true)
	end

	if animDict and animName then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(50)
		end

		TaskPlayAnim(spawnedPed, animDict, animName, 8.0, 0, -1, 1, 0, 0, 0)
	end

    if scenario then
        TaskStartScenarioInPlace(spawnedPed, scenario, 0, true)
    end

	if Config.FadeIn then
		for i = 0, 255, 51 do
			Citizen.Wait(50)
			SetEntityAlpha(spawnedPed, i, false)
		end
	end

	return spawnedPed
end

---------------------------------------------------------------------------------------
-- misc functions --
---------------------------------------------------------------------------------------

function drawRct(x,y,width,height,r,g,b,a)
	DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end

function Breaking(text)
		SetTextColour(255, 255, 255, 255)
		SetTextFont(8)
		SetTextScale(1.2, 1.2)
		SetTextWrap(0.0, 1.0)
		SetTextCentre(false)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 205)
		SetTextEntry("STRING")
		AddTextComponentString(text)
		DrawText(0.2, 0.85)
end

function Notification(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0, 1)
end

function DisplayNotification(string)
	SetTextComponentFormat("STRING")
	AddTextComponentString(string)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


--stit

local shieldActive = false
local shieldEntity = nil

local animDict = "combat@gestures@gang@pistol_1h@beckon"
local animName = "0"

local prop = "prop_ballistic_shield"


RegisterNetEvent('stit:pouzit')
AddEventHandler('stit:pouzit', function()
    if shieldActive then
        DisableShield()
    else
        EnableShield()
    end
end)

function EnableShield()
    shieldActive = true
    local ped = PlayerPedId()
    local pedPos = GetEntityCoords(ped, false)
    
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(100)
    end

    TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, (2 + 16 + 32), 0.0, 0, 0, 0)

    RequestModel(GetHashKey(prop))
    while not HasModelLoaded(GetHashKey(prop)) do
        Wait(100)
    end

    local shield = CreateObject(GetHashKey(prop), pedPos.x, pedPos.y, pedPos.z, 1, 1, 1)
    shieldEntity = shield
    AttachEntityToEntity(shieldEntity, ped, GetEntityBoneIndexByName(ped, "IK_L_Hand"), 0.0, -0.05, -0.10, -30.0, 180.0, 40.0, 0, 0, 1, 0, 0, 1)

    SetEnableHandcuffs(ped, true)
end

function DisableShield()
    local ped = PlayerPedId()
    DeleteEntity(shieldEntity)
    ClearPedTasksImmediately(ped)

    SetEnableHandcuffs(ped, false)
    shieldActive = false
end

CreateThread(function()
    while true do
        if shieldActive then
            local ped = PlayerPedId()
            if not IsEntityPlayingAnim(ped, animDict, animName, 1) then
                RequestAnimDict(animDict)
                while not HasAnimDictLoaded(animDict) do
                    Wait(100)
                end
            
                TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, (2 + 16 + 32), 0.0, 0, 0, 0)
            end
        end
        Wait(500)
    end
end)




-- Nightclub Bartender
CreateThread(function()
    RequestModel(GetHashKey("s_m_m_linecook"))
	
    while not HasModelLoaded(GetHashKey("s_m_m_linecook")) do
        Wait(1)
    end
	
	if Config.EnableNightclubs then
		for _, item in pairs(Config.Locations10) do
			kuchar = CreatePed(4, 0xDB9C0997, item.x, item.y, item.z, item.heading, false, true)
			
			FreezeEntityPosition(kuchar, true)	
			SetEntityHeading(kuchar, item.heading)
			SetEntityInvincible(kuchar, true)
			SetBlockingOfNonTemporaryEvents(kuchar, true)
			SetPedCanPlayAmbientAnims(kuchar, true)
		end
	end
end)




local Keys = {["E"] = 38, ["SPACE"] = 22, ["K"] = 311}
local canExercise = false
local exercising = false
local procent = 0
local motionProcent = 0
local doingMotion = false
local motionTimesDone = 0
local training = false
local resting = false


CreateThread(function()
    local alreadyEnteredZone = false
    while true do
        local sleep = 500
        local inZone = false
        local coords = GetEntityCoords(PlayerPedId())
            for i, v in pairs(Config.Locations) do
                local pos = Config.Locations[i]
                local dist = GetDistanceBetweenCoords(pos["x"], pos["y"], pos["z"] + 0.98, coords, true)
                if dist <= 1.5 and not exercising then
                    inZone = true
                    sleep = 5
                   -- DrawText3D(pos["x"], pos["y"], pos["z"] + 0.98, "[E] " .. pos["exercise"])
                    exports['interaction-menu']:ShowInteraction('show', 'orange',  "[E] " .. pos["exercise"])
                    if IsControlJustPressed(0, Keys["E"])  then
                      
                        if training == false then
                            startExercise(Config.Exercises[pos["exercise"]], pos)
                        elseif training == true then
                            ESX.ShowNotification('Chvilku si odpočiň...')
                           -- exports['mythic_notify']:DoHudText('inform', 'Chvilku si odpočiň...')
                        end
                    end
                    else if dist <= 3.0 and not exercising then
                      
                        sleep = 8
                       -- DrawText3D(pos["x"], pos["y"], pos["z"] + 0.98, pos["exercise"])
                    end
                end
            end

            if inZone and not alreadyEnteredZone then
                alreadyEnteredZone = true
                
            
            end
            if not inZone and alreadyEnteredZone then
                alreadyEnteredZone = false
                exports['interaction-menu']:HideInteraction()
            end


        Wait(sleep)
    end
end)


function startExercise(animInfo, pos)
    local playerPed = PlayerPedId()

    LoadDict(animInfo["idleDict"])
    LoadDict(animInfo["enterDict"])
    LoadDict(animInfo["exitDict"])
    LoadDict(animInfo["actionDict"])

    if pos["h"] ~= nil then
        SetEntityCoords(playerPed, pos["x"], pos["y"], pos["z"])
        SetEntityHeading(playerPed, pos["h"])
    end

    TaskPlayAnim(playerPed, animInfo["enterDict"], animInfo["enterAnim"], 8.0, -8.0, animInfo["enterTime"], 0, 0.0, 0, 0, 0)
    Wait(animInfo["enterTime"])

    canExercise = true
    exercising = true

    CreateThread(function()
        while exercising do
            Wait(8)
            if procent <= 24.99 then
                color = "~r~"
            elseif procent <= 49.99 then
                color = "~o~"
            elseif procent <= 74.99 then
                color = "~b~"
            elseif procent <= 100 then
                color = "~g~"
            end
            DrawText2D(0.505, 0.925, 1.0,1.0,0.33, "Postup: " .. color..procent .. "%", 255, 255, 255, 255)
            DrawText2D(0.505, 0.95, 1.0,1.0,0.33, "Zmáčkni ~g~[MEZERNÍK]~w~ pro trénink", 255, 255, 255, 255)
            DrawText2D(0.505, 0.975, 1.0,1.0,0.33, "Zmáčkni ~r~[K]~w~ přerušení tréninku", 255, 255, 255, 255)
        end
    end)

    CreateThread(function()
        while canExercise do
            Wait(8)
            local playerCoords = GetEntityCoords(playerPed)
            if procent <= 99 then
                TaskPlayAnim(playerPed, animInfo["idleDict"], animInfo["idleAnim"], 8.0, -8.0, -1, 0, 0.0, 0, 0, 0)
                if IsControlJustPressed(0, Keys["SPACE"]) then -- press space to train
                    canExercise = false
                    TaskPlayAnim(playerPed, animInfo["actionDict"], animInfo["actionAnim"], 8.0, -8.0, animInfo["actionTime"], 0, 0.0, 0, 0, 0)
                    AddProcent(animInfo["actionProcent"], animInfo["actionProcentTimes"], animInfo["actionTime"] - 70)
                    canExercise = true
                end
                if IsControlJustPressed(0, Keys["K"]) then -- press delete to exit training
                    ExitTraining(animInfo["exitDict"], animInfo["exitAnim"], animInfo["exitTime"])
                   
                end
            else
                ExitTraining(animInfo["exitDict"], animInfo["exitAnim"], animInfo["exitTime"])
              
                --exports["gamz-skillsystem"]:UpdateSkill("Výdrž", 0.3)
                exports["gamz-skillsystem"]:UpdateSkill("Strength", 0.3)
              
                training = true
                resting = true
                            
                CheckTraining()
                -- Here u can put a event to update some sort of skill or something.
               
                -- this is when u finished your exercise
            end
        end
    end)
end

-----------SPRINT-----------
RegisterCommand("sprint", function()
    if training == false then
        motionProcent = 0
        doingMotion = not doingMotion  

    CreateThread(function()
        while doingMotion do
            Wait(7) 
            if IsPedSprinting(PlayerPedId()) then
                motionProcent = motionProcent + 9
            elseif IsPedRunning(PlayerPedId()) then
                motionProcent = motionProcent + 6
            elseif IsPedWalking(PlayerPedId()) then
                motionProcent = motionProcent + 3
            end
            
            DrawText2D(0.505, 0.95, 1.0,1.0,0.4, "~o~Postup:~w~ " .. tonumber(string.format("%.1f", motionProcent/1000)) .. "%", 255, 255, 255, 255)
            if motionProcent >= 100000 then
                doingMotion = false
                motionProcent = 0
                Notify("Dokončil jsi trénink.")
             
                exports["gamz-skillsystem"]:UpdateSkill("Stamina", 0.3)
                --exports["gamz-skillsystem"]:UpdateSkill("Síla", 0.3)
                training = true
                resting = true
        
                CheckTraining()
            end
        end
    end)

    if doingMotion then
        motionTimesDone = motionTimesDone + 1
        if motionTimesDone <= 2 then
            Notify("Zacal jsi trénink")
            print(motionTimesDone)
        else
            Notify("Na tohle jsi moc unavený")
            doingMotion = false
        end
    else
        Notify("Ukoncil jsi trénink.")
    end
    elseif training == true then
        ESX.ShowNotification('Odpočíváš')
    end
end)

function ExitTraining(exitDict, exitAnim, exitTime)
    TaskPlayAnim(PlayerPedId(), exitDict, exitAnim, 8.0, -8.0, exitTime, 0, 0.0, 0, 0, 0)
    Wait(exitTime)
    canExercise = false
    exercising = false
    procent = 0
end

function AddProcent(amount, amountTimes, time)
    for i=1, amountTimes do
        Wait(time/amountTimes)
        procent = procent + amount
    end
end

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Wait(10)
    end
end

function DrawText3D(x, y, z, text)
	RegisterFontFile('firesans')
	fontId = RegisterFontId('Fire Sans')
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local px, py, pz = table.unpack(GetGameplayCamCoords())
	  local font = fontId
	
	if onScreen then
	  SetTextScale(0.55, 0.31)
	  RegisterFontFile('firesans') 
	fontId = RegisterFontId('Fire Sans') 
	  SetTextFont(font)
  
	  SetTextDropshadow(10, 100, 100, 100, 255)
	  SetTextProportional(1)
	  SetTextColour(255, 255, 255, 215)
	  SetTextEntry("STRING")
	  SetTextCentre(1)
	  AddTextComponentString(text)
	  DrawText(_x,_y)
		  local factor = (string.len(text)) / 370
		  DrawRect(_x,_y+0.0135, 0.025+ factor, 0.03, 0, 0, 0, 68)
	  end
  end
      
function DrawText2D(x, y, width, height, scale, text, r, g, b, a, outline)
    RegisterFontFile('firesans') 
	fontId = RegisterFontId('Fire Sans') 
	  SetTextFont(fontId)
	--SetTextFont(0)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width/2, y - height/2 + 0.005)
end

CreateThread(function()
    for i=1, #Config.Blips, 1 do
        local Blip = Config.Blips[i]
        blip = AddBlipForCoord(Blip["x"], Blip["y"], Blip["z"])
        SetBlipSprite(blip, Blip["id"])
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, Blip["scale"])
        SetBlipColour(blip, 4)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("<FONT FACE='Fire Sans'>Muscle Sands Gym")
        EndTextCommandSetBlipName(blip)
    end
end) 

function Notify(msg)
    ESX.ShowNotification(msg)
end

--Yoga
CreateThread(function()
    local alreadyEnteredZone = false
    while true do
        local sleep = 500
        local inZone = true
        local coords = GetEntityCoords(PlayerPedId())
            for i, v in pairs(Config.LocationsYoga) do
                local pos = Config.LocationsYoga[i]
                local dist = GetDistanceBetweenCoords(pos["x"], pos["y"], pos["z"] + 0.98, coords, true)
                if dist <= 1.5 and not exercising then
                    sleep = 5
                    inZone = true
                    exports['interaction-menu']:ShowInteraction('show', 'orange',  "[E] " .. pos["exercise"])
                    if IsControlJustPressed(0, Keys["E"])  then
                 
                        if training == false then
                            local playerPed = PlayerPedId()
                            FreezeEntityPosition(playerPed, true)
                            TaskStartScenarioInPlace(playerPed, "world_human_yoga", 0, true)
                            --DisableControl()
                            Wait(30000)
                           -- EnableControl()
                            ClearPedTasksImmediately(playerPed)
                            FreezeEntityPosition(playerPed, false)
                            --exports["gamz-skillsystem"]:UpdateSkill("Výdrž", 0.3)
                            exports["gamz-skillsystem"]:UpdateSkill("Stamina", 0.3)
                         
                            if IsControlJustPressed(0, 73) then
                                ClearPedTasksImmediately(playerPed)
                            else
                               
                                training = true
                                resting = true
                            
                                CheckTraining()
                            end
                        elseif training == true then
                            ESX.ShowNotification('Chvilku si odpočiň...')
                        end
                    end
                    else if dist <= 3.0 and not exercising then
                        sleep = 8
                       -- DrawText3D(pos["x"], pos["y"], pos["z"] + 0.98, pos["exercise"])
                    end
                end
            end
            if inZone and not alreadyEnteredZone then
                alreadyEnteredZone = true
                
            
            end
            if not inZone and alreadyEnteredZone then
                alreadyEnteredZone = false
                exports['interaction-menu']:HideInteraction()
            end
        Wait(sleep)
    end
end)

--Činky
CreateThread(function()
    local alreadyEnteredZone = false
    while true do
        local sleep = 500
        local inZone = false
        local coords = GetEntityCoords(PlayerPedId())
            for i, v in pairs(Config.LocationsHands) do
                local pos = Config.LocationsHands[i]
                local dist = GetDistanceBetweenCoords(pos["x"], pos["y"], pos["z"] + 0.98, coords, true)
                if dist <= 1.5 and not exercising then
                    sleep = 5
                    inZone = true
                    exports['interaction-menu']:ShowInteraction('show', 'orange',  "[E] " .. pos["exercise"])
                    if IsControlJustPressed(0, Keys["E"]) then
                   
                        if training == false then
                            local playerPed = PlayerPedId()
                            FreezeEntityPosition(playerPed, true)
                            TaskStartScenarioInPlace(playerPed, "world_human_muscle_free_weights", 0, true)
                            --DisableControl()
                            Wait(30000)
                           -- EnableControl()
                            ClearPedTasksImmediately(playerPed)
                            FreezeEntityPosition(playerPed, false)
                            --exports["gamz-skillsystem"]:UpdateSkill("Výdrž", 0.3)
                            exports["gamz-skillsystem"]:UpdateSkill("Strength", 0.3)
                       
                            if IsControlJustPressed(0, 73) then
                                ClearPedTasksImmediately(playerPed)
                            else
                             
                                training = true
                                resting = true
                            
                                CheckTraining()
                            end
                        elseif training == true then
                            ESX.ShowNotification('Chvilku si odpočiň...')
                          --  exports['mythic_notify']:DoHudText('inform', 'Chvilku si odpočiň...')
                        end
                    end
                    else if dist <= 3.0 and not exercising then
                        sleep = 8
                       -- DrawText3D(pos["x"], pos["y"], pos["z"] + 0.98, pos["exercise"])
                    end
                end
            end
            if inZone and not alreadyEnteredZone then
                alreadyEnteredZone = true
                
            
            end
            if not inZone and alreadyEnteredZone then
                alreadyEnteredZone = false
                exports['interaction-menu']:HideInteraction()
            end
        Wait(sleep)
    end
end)

function DisableControl()
    DisableControlAction(0, 32, true)
    DisableControlAction(0, 33, true)
    DisableControlAction(0, 34, true)
    DisableControlAction(0, 35, true)
    DisableControlAction(0, 36, true)
    DisableControlAction(0, 45, true)
    DisableControlAction(0, 46, true)
    DisableControlAction(0, 47, true)
    DisableControlAction(0, 49, true)
    DisableControlAction(0, 51, true)
    DisableControlAction(0, 52, true)
    DisableControlAction(0, 26, true)
    DisableControlAction(0, 23, true)
    DisableControlAction(0, 73, true)
end

function EnableControl()
    DisableControlAction(0, 32, false)
    DisableControlAction(0, 33, false)
    DisableControlAction(0, 34, false)
    DisableControlAction(0, 35, false)
    DisableControlAction(0, 36, false)
    DisableControlAction(0, 45, false)
    DisableControlAction(0, 46, false)
    DisableControlAction(0, 47, false)
    DisableControlAction(0, 49, false)
    DisableControlAction(0, 51, false)
    DisableControlAction(0, 52, false)
    DisableControlAction(0, 26, false)
    DisableControlAction(0, 23, false)
    DisableControlAction(0, 73, false)
end

function CheckTraining()
	if resting == true then
		
		resting = false
		Wait(60000)
		training = false
	end
	
	if resting == false then
        ESX.ShowNotification('Můžete znovu cvičit...')
		--exports['mythic_notify']:DoHudText('inform', 'Můžete znovu cvičit...')
	end
end



local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX              = nil
local PlayerData = {}
local ped = PlayerPedId()
local mainMenu = false
local animation = true
local animationtime = 1500

exports.qtarget:Player({
	options = {
        {
			event = "radialmenu:search",
			icon = "fas fa-search",
			label = "Prohledat",
			num = 1
		}
	},
	distance = 2
})

function DrawText3Ds(x,y,z, text)
		local onScreen, _x, _y = World3dToScreen2d(x, y, z)
		local px, py, pz = table.unpack(GetGameplayCamCoords())
		if onScreen then
		 SetTextScale(0.55, 0.31)
		 RegisterFontFile('firesans') 
		 fontId = RegisterFontId('Fire Sans') 
		  SetTextFont(fontId)
		  SetTextDropshadow(10, 100, 100, 100, 255)
		  SetTextProportional(1)
		  SetTextColour(255, 255, 255, 215)
		  SetTextEntry("STRING")
		  SetTextCentre(1)
		  AddTextComponentString(text)
		  DrawText(_x,_y)
			  local factor = (string.len(text)) / 370
			  DrawRect(_x,_y+0.0135, 0.025+ factor, 0.03, 0, 0, 0, 68)
		end
 end



------------------taze effect------------------
local tiempo = 4000 -- 1000 ms = 1s
local isTaz = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		
		if IsPedBeingStunned(GetPlayerPed(-1)) then
			
			SetPedToRagdoll(GetPlayerPed(-1), 5000, 5000, 0, 0, 0, 0)
			
		end
		
		if IsPedBeingStunned(GetPlayerPed(-1)) and not isTaz then
			
			isTaz = true
			SetTimecycleModifier("REDMIST_blend")
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 1.0)
			
		elseif not IsPedBeingStunned(GetPlayerPed(-1)) and isTaz then
			isTaz = false
			Wait(5000)
			
			SetTimecycleModifier("hud_def_desat_Trevor")
			
			Wait(10000)
			
      SetTimecycleModifier("")
			SetTransitionTimecycleModifier("")
			StopGameplayCamShaking()
		end
	end
end)

RegisterNetEvent('radialmenu:search')
AddEventHandler('radialmenu:search', function()
    ExecuteCommand("steal")
end)

-- https://forum.fivem.net/t/how-to-disable-aggressive-npcs-in-sandy-shores/62822/2

local relationshipTypes = {
	'GANG_1',
	'GANG_2',
	'GANG_9',
	'GANG_10',
	'AMBIENT_GANG_LOST',
	'AMBIENT_GANG_MEXICAN',
	'AMBIENT_GANG_FAMILY',
	'AMBIENT_GANG_BALLAS',
	'AMBIENT_GANG_MARABUNTE',
	'AMBIENT_GANG_CULT',
	'AMBIENT_GANG_SALVA',
	'AMBIENT_GANG_WEICHENG',
	'AMBIENT_GANG_HILLBILLY',
	'DEALER',
	'COP',
	'PRIVATE_SECURITY',
	'SECURITY_GUARD',
	'ARMY',
	'MEDIC',
	'FIREMAN',
	'HATES_PLAYER',
	'NO_RELATIONSHIP',
	'SPECIAL',
	'MISSION2',
	'MISSION3',
	'MISSION4',
	'MISSION5',
	'MISSION6',
	'MISSION7',
	'MISSION8'
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)

		for _, group in ipairs(relationshipTypes) do
			SetRelationshipBetweenGroups(1, GetHashKey('PLAYER'), GetHashKey(group)) -- could be removed
			SetRelationshipBetweenGroups(1, GetHashKey(group), GetHashKey('PLAYER'))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------
RegisterCommand("rply", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    cm = stringsplit(rawCommand, " ")
    id = args[1]
    local textmsg = ""
    for i=1, #cm do
        if i ~= 1 and i ~= 2 then
            textmsg = (textmsg .. " " .. tostring(cm[i]))
        end
    end
    if havePermission(xPlayer) then
        TriggerClientEvent('chatMessage', id, "^* ^1STAFF | " .. GetPlayerName(source) .. "^*  ^9", {30, 144, 255}, textmsg)
        TriggerClientEvent('chatMessage', source, "^* ^1Message send to ID: ".. id .." | ^*  ^9", {30, 144, 255}, textmsg)
    end
end, false)

function stringSplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end
