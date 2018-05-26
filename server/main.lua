-----------------------------------------
-- Criado por iKaoticx
-- Para o Infinty Roleplay
-----------------------------------------
ESX = nil
local PlayersTransforming  = {}
local PlayersSelling       = {}
local PlayersHarvesting = {}
local vinho = 1
local suco = 1
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'mineradora', Config.MaxInService)
end

--TriggerEvent('esx_phone:registerNumber', 'mineradora', _U('minerador_client'), true, true)
--TriggerEvent('esx_society:registerSociety', 'mineradora', 'Minerador', 'society_mineradora', 'society_mineradora', 'society_mineradora', {type = 'private'})
local function Harvest(source, zone)
	if PlayersHarvesting[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
		if zone == "Mina" then
			local itemQuantity = xPlayer.getInventoryItem('pedra').count
			if itemQuantity >= 50 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_place'))
				return
			else
				SetTimeout(5000, function()
					xPlayer.addInventoryItem('pedra', 1)
					Harvest(source, zone)
				end)
			end
		end
	end
end

RegisterServerEvent('esx_mineradorjob:startHarvest')
AddEventHandler('esx_mineradorjob:startHarvest', function(zone)
	local _source = source
  	
	if PlayersHarvesting[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersHarvesting[_source]=false
	else
		PlayersHarvesting[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('uva_taken'))  
		Harvest(_source,zone)
	end
end)


RegisterServerEvent('esx_mineradorjob:stopHarvest')
AddEventHandler('esx_mineradorjob:stopHarvest', function()
	local _source = source
	
	if PlayersHarvesting[_source] == true then
		PlayersHarvesting[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~récolter')
		PlayersHarvesting[_source]=true
	end
end)


local function Transform(source, zone)

	if PlayersTransforming[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
		if zone == "TratamentoFerro" then
			local itemQuantity = xPlayer.getInventoryItem('pedra').count			
			if itemQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_pedra'))
				return
			else
				SetTimeout(10000, function()
						xPlayer.removeInventoryItem('pedra', 1)
						xPlayer.addInventoryItem('ferro', 1)
				
						Transform(source, zone)
						end)
					end
			
		elseif zone == "TratamentoAluminio" then
			local itemQuantity = xPlayer.getInventoryItem('pedra').count
			if itemQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_pedra'))
				return
			else
				SetTimeout(18000, function()
					xPlayer.removeInventoryItem('pedra', 2)
					xPlayer.addInventoryItem('aluminio', 1)
		  
					Transform(source, zone)	  
					end)
				end
				
		elseif zone == "TratamentoCobre" then
			local itemQuantity = xPlayer.getInventoryItem('pedra').count
			if itemQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_pedra'))
				return
			else
				SetTimeout(25000, function()
					xPlayer.removeInventoryItem('pedra', 3)
					xPlayer.addInventoryItem('cobre', 1)
		  
					Transform(source, zone)	  
					end)
				end

		elseif zone == "TratamentoPrata" then
			local itemQuantity = xPlayer.getInventoryItem('pedra').count
			if itemQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_pedra'))
				return
			else
				SetTimeout(30000, function()
					xPlayer.removeInventoryItem('pedra', 5)
					xPlayer.addInventoryItem('prata', 1)
		  
					Transform(source, zone)	  
					end)
				end
			
		elseif zone == "TratamentoOuro" then
			local itemQuantity = xPlayer.getInventoryItem('pedra').count
			if itemQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_pedra'))
				return
			else
				SetTimeout(50000, function()
					xPlayer.removeInventoryItem('pedra', 7)
					xPlayer.addInventoryItem('ouro', 1)
		  
					Transform(source, zone)	  
				end)
			end
		end
	end	
end

RegisterServerEvent('esx_mineradorjob:startTransform')
AddEventHandler('esx_mineradorjob:startTransform', function(zone)
	local _source = source
  	
	if PlayersTransforming[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersTransforming[_source]=false
	else
		PlayersTransforming[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('transforming_in_progress')) 
		Transform(_source,zone)
	end
end)

RegisterServerEvent('esx_mineradorjob:stopTransform')
AddEventHandler('esx_mineradorjob:stopTransform', function()

	local _source = source
	
	if PlayersTransforming[_source] == true then
		PlayersTransforming[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
		
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~transformer votre pedra')
		PlayersTransforming[_source]=true
		
	end
end)

local function Sell(source, zone)

	if PlayersSelling[source] == true then
		local xPlayer  = ESX.GetPlayerFromId(source)
		
		if zone == 'Venda' then
			if xPlayer.getInventoryItem('ferro').count <= 0 then
				ferro = 0
			else
				ferro = 1
			end			
			if xPlayer.getInventoryItem('aluminio').count <= 0 then
				aluminio = 0
			else
				aluminio = 1
			end			
			if xPlayer.getInventoryItem('cobre').count <= 0 then
				cobre = 0
			else
				cobre = 1
			end			
			if xPlayer.getInventoryItem('prata').count <= 0 then
				prata = 0
			else
				prata = 1
			end			
			if xPlayer.getInventoryItem('ouro').count <= 0 then
				ouro = 0
			else
				ouro = 1
			end
					
			if ferro == 0 and aluminio == 0 and cobre == 0 and prata == 0 and ouro == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_product_sale'))
				return
			elseif xPlayer.getInventoryItem('ferro').count <= 0 and aluminio == 0 and cobre == 0 and prata == 0 and ouro == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_ferro_sale'))
				ferro = 0
				return
			elseif xPlayer.getInventoryItem('aluminio').count <= 0 and ferro == 0 and cobre == 0 and prata == 0 and ouro == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_aluminio_sale'))
				aluminio = 0
				return
			elseif xPlayer.getInventoryItem('cobre').count <= 0 and aluminio == 0 and ferro == 0 and prata == 0 and ouro == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_cobre_sale'))
				cobre = 0
				return
			elseif xPlayer.getInventoryItem('prata').count <= 0 and aluminio == 0 and cobre == 0 and ferro == 0 and ouro == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_prata_sale'))
				prata = 0
				return
			elseif xPlayer.getInventoryItem('ouro').count <= 0 and aluminio == 0 and cobre == 0 and prata == 0 and ferro == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_ouro_sale'))
				ouro = 0
				return	
			else
				if (ferro == 1) then
					SetTimeout(2500, function()
						local money = math.random(48,96)
						xPlayer.removeInventoryItem('ferro', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mineradora', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							societyAccount.addMoney(money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
				elseif (aluminio == 1) then
					SetTimeout(2500, function()
						local money = math.random(96,192)
						xPlayer.removeInventoryItem('aluminio', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mineradora', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							societyAccount.addMoney(money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
				elseif (cobre == 1) then
					SetTimeout(3000, function()
						local money = math.random(176,315)
						xPlayer.removeInventoryItem('cobre', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mineradora', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							societyAccount.addMoney(money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
				elseif (prata == 1) then
					SetTimeout(4000, function()
						local money = math.random(230,420)
						xPlayer.removeInventoryItem('prata', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mineradora', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							societyAccount.addMoney(money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
					end)
				elseif (ouro == 1) then
					SetTimeout(5000, function()
						local money = math.random(620,820)
						xPlayer.removeInventoryItem('ouro', 1)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mineradora', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							societyAccount.addMoney(money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						end
						Sell(source,zone)
							end)
						end
					end
				end
			end
		end

RegisterServerEvent('esx_mineradorjob:startSell')
AddEventHandler('esx_mineradorjob:startSell', function(zone)

	local _source = source
	
	if PlayersSelling[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersSelling[_source]=false
	else
		PlayersSelling[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
		Sell(_source, zone)
	end

end)

RegisterServerEvent('esx_mineradorjob:stopSell')
AddEventHandler('esx_mineradorjob:stopSell', function()

	local _source = source
	
	if PlayersSelling[_source] == true then
		PlayersSelling[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
		
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~vendre')
		PlayersSelling[_source]=true
	end

end)

RegisterServerEvent('esx_mineradorjob:getStockItem')
AddEventHandler('esx_mineradorjob:getStockItem', function(itemName, count)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mineradora', function(inventory)

		local item = inventory.getItem(itemName)

		if item.count >= count then
			inventory.removeItem(itemName, count)
			xPlayer.addInventoryItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn') .. count .. ' ' .. item.label)

	end)

end)

ESX.RegisterServerCallback('esx_mineradorjob:getStockItems', function(source, cb)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mineradora', function(inventory)
		cb(inventory.items)
	end)

end)

RegisterServerEvent('esx_mineradorjob:putStockItems')
AddEventHandler('esx_mineradorjob:putStockItems', function(itemName, count)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mineradora', function(inventory)

		local item = inventory.getItem(itemName)

		if item.count >= 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('added') .. count .. ' ' .. item.label)

	end)
end)

ESX.RegisterServerCallback('esx_mineradorjob:getPlayerInventory', function(source, cb)

	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({
		items      = items
	})

end)