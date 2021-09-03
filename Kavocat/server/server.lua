TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'avocat', 'alerte avocat', true, true)

TriggerEvent('esx_society:registerSociety', 'avocat', 'avocat', 'society_avocat', 'society_avocat', 'society_avocat', {type = 'public'})

-- [Annonce Ouvert]
RegisterServerEvent('Ouvre:avocat')
AddEventHandler('Ouvre:avocat', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Avocat', '~m~Annonce', "Le cabinet d'avocat est désormais ~g~Ouvert~s~ !", 'CHAR_DOM')
	end
end)

-- [Annonce Recrutement]
RegisterServerEvent('Recrutement:avocat')
AddEventHandler('Recrutement:avocat', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Avocat', '~m~Annonce', "Le cabinet d'avocat ~y~recrute~w~ faites chauffés vos cv !", 'CHAR_DOM')
	end
end)

-- [Annonce Fermer]
RegisterServerEvent('Ferme:avocat')
AddEventHandler('Ferme:avocat', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Avocat', '~m~Annonce', "Le cabinet d'avocat est désormais ~r~Fermer~s~ !", 'CHAR_DOM')
	end
end)

