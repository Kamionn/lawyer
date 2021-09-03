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

-- Function --

function barman()

  local model = GetEntityModel(GetPlayerPed(-1))

  TriggerEvent('skinchanger:getSkin', function(skin)

      if model == GetHashKey("mp_m_freemode_01") then

-- Homme
          clothesSkin = {
            ['bags_1'] = 0, ['bags_2'] = 0,
            ['tshirt_1'] = 0, ['tshirt_2'] = 0,
            ['torso_1'] = 0, ['torso_2'] = 0,
            ['arms'] = 0,
            ['pants_1'] = 0, ['pants_2'] = 0,
            ['shoes_1'] = 0, ['shoes_2'] = 0,

          }
    else

-- Femme
          clothesSkin = {
            ['bags_1'] = 0, ['bags_2'] = 0,
            ['tshirt_1'] = 0,['tshirt_2'] = 0,
            ['torso_1'] = 0, ['torso_2'] = 0,
            ['arms'] = 0, ['arms_2'] = 0,
            ['pants_1'] = 0, ['pants_2'] = 0,
            ['shoes_1'] = 0, ['shoes_2'] = 0,

          }

      end

      TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

  end)

end

function vcivil()

ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)

TriggerEvent('skinchanger:loadSkin', skin)

end)

end

-- MENU FUNCTION --

local open = false 
local mainMenu6 = RageUI.CreateMenu('Vestiaire', "Avocat")
mainMenu6.Display.Header = true 
mainMenu6.Closed = function()
  open = false
end

function OpenVestiaire()
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

              RageUI.Separator("↓ ~b~   Vestiaire  ~s~↓")

              RageUI.Button("Civile", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                    vcivil()
                  end
                })	

                RageUI.Button("Avocat", nil, {RightLabel = "→→"}, true , {
                  onSelected = function()
                    barman()
                    end
                  })	
            
            end)
          Wait(0)
         end
      end)
   end
end

----OUVRIR LE MENU------------

local position = {
	{x = -252.77, y = -919.25, z = 32.31}
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'avocat' then 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
       if dist <= 1.0 then
               wait = 0
                Visual.Subtitle("Appuyer sur ~b~[E]~s~ pour ouvrir le casier", 1) 
                if IsControlJustPressed(1,51) then
                  OpenVestiaire()
            end
        end
      end
    Citizen.Wait(wait)
    end
  end
end)


