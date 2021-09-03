Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

-- [MENU]

local open = false 
local mainMenu6 = RageUI.CreateMenu('Garage', 'avocat')
mainMenu6.Display.Header = true 
mainMenu6.Closed = function()
  open = false
end

function OpenMenu6()
     if open then 
         open = false
         RageUI.Visible(mainMenu6, false)
         return
     else
         open = true 
         RageUI.Visible(mainMenu6, true)
         CreateThread(function()
         while open do 
            RageUI.IsVisible(mainMenu6,function() 
                RageUI.Separator("↓ ~m~Véhicules ~w~↓")

                RageUI.Button("Oracle", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                      local model = GetHashKey("oracle")
                      RequestModel(model)
                      while not HasModelLoaded(model) do Citizen.Wait(10) end
                      local pos = GetEntityCoords(PlayerPedId())
                      local vehicle = CreateVehicle(model, -227.84, -892.94, 29.70, 253.44, true, true)
                      RageUI.CloseAll()
                    end
                })

                 RageUI.Button("4x4", nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                      local model = GetHashKey("fq2")
                      RequestModel(model)
                      while not HasModelLoaded(model) do Citizen.Wait(10) end
                      local pos = GetEntityCoords(PlayerPedId())
                     local vehicle = CreateVehicle(model, -227.84, -892.94, 29.70, 253.44, true, true)
                      RageUI.CloseAll()
                    end
                })

            end)
          Wait(0)
         end
      end)
   end
end

-- [Position]

local position = {
    {x = -235.18, y = -921.47, z = 33.21}
}

Citizen.CreateThread(function()
    while true do
        NearZone = false

        for k,v in pairs(position) do

			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'avocat' then

				local interval = 1
            	local pos = GetEntityCoords(GetPlayerPed(-1), false)
            	local dest = vector3(v.x, v.y, v.z)
            	local distance = GetDistanceBetweenCoords(pos, dest, true)
            	if distance > 2 then
                	interval = 1
            	else
                	interval = 1

                	local dist = Vdist(pos.x, pos.y, pos.z, position[k].x, position[k].y, position[k].z)
                	NearZone = true 

                	if distance < 2 then
                    	if not InAction then 
						Visual.Subtitle("Appuyer sur ~m~[E]~s~ pour ouvrir le garage", 0) 
                    end
                    if IsControlJustReleased(1,51) then
                        OpenMenu6()
                    end

                end
                break
			end
            end
        end
		if not NearZone then 
            Wait(500)
        else
            Wait(1)
        end
    end
end)

-- [Ped]

Citizen.CreateThread(function()
    local hash = GetHashKey("cs_paper")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
      Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVMALE", "cs_paper", -235.63, -922.18, 31.30, 332.09,false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

-- [Blip]

Citizen.CreateThread(function()

    local blip = AddBlipForCoord(-245.53, -918.70, 47.02)

    SetBlipSprite (blip, 408) -- Model du blip
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.8) -- Taille du blip
    SetBlipColour (blip, 62) -- Couleur du blip
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Avocat') -- Nom du blip
    EndTextCommandSetBlipName(blip)
end)
