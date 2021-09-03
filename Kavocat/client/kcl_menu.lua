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
local mainMenu8 = RageUI.CreateMenu('Avocat', 'Interraction')
local subMenu8 = RageUI.CreateSubMenu(mainMenu8, "Annonces", "Interraction")
mainMenu8.Display.Header = true 
mainMenu8.Closed = function()
  open = false
end

function OpenMenu8()
	if open then 
		open = false
		RageUI.Visible(mainMenu8, false)
		return
	else
		open = true 
		RageUI.Visible(mainMenu8, true)
		CreateThread(function()
		while open do 
		   RageUI.IsVisible(mainMenu8,function() 

			RageUI.Button("Annonces", nil, {RightLabel = "→→"}, true , {
				onSelected = function()

				end
			}, subMenu8)

			RageUI.Button("Faire une Facture", nil, {RightLabel = "→→"}, true , {
				onSelected = function()
					OpenBillingMenu2()
                    RageUI.CloseAll()
				end
			})



			end)

			RageUI.IsVisible(subMenu8,function() 

			 RageUI.Button("Annonce ~g~Ouvertures", nil, {RightLabel = "→"}, true , {
				onSelected = function()
					TriggerServerEvent('Ouvre:avocat')
				end
			})

			 RageUI.Button("Annonce ~y~Recrutement", nil, {RightLabel = "→"}, true , {
				onSelected = function()
					TriggerServerEvent('Recrutement:avocat')
				end
			})


			RageUI.Button("Annonce ~r~Fermetures", nil, {RightLabel = "→"}, true , {
				onSelected = function()
					TriggerServerEvent('Ferme:avocat')
				end
			})

		   end)
		 Wait(0)
		end
	 end)
  end
end

-- [Facture]

function OpenBillingMenu2()

	ESX.UI.Menu.Open(
	  'dialog', GetCurrentResourceName(), 'billing',
	  {
		title = "Facture"
	  },
	  function(data, menu)
	  
		local amount = tonumber(data.value)
		local player, distance = ESX.Game.GetClosestPlayer()
  
		if player ~= -1 and distance <= 3.0 then
  
		  menu.close()
		  if amount == nil then
			  ESX.ShowNotification("~r~Problèmes~s~: Montant invalide")
		  else
			local playerPed        = GetPlayerPed(-1)
			TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
			Citizen.Wait(5000)
			  TriggerServerEvent('esx_billing:sendBill1', GetPlayerServerId(player), 'society_avocatnation', ('avocatnation'), amount)
			  Citizen.Wait(100)
			  ESX.ShowNotification("~r~Vous avez bien envoyer la facture")
		  end
  
		else
		  ESX.ShowNotification("~r~Problèmes~s~: Aucun joueur à proximitée")
		end
  
	  end,
	  function(data, menu)
		  menu.close()
	  end
	)
  end

-- [Ouverture du menu]

Keys.Register('F6', 'avocat', 'Ouvrir le menu avocat', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'avocat' then
    	OpenMenu8()
	end
end)