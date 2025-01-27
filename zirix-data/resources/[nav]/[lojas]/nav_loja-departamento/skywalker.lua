local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------

local valores = {
	{ item = "sanduiche", quantidade = 1, compra = 30 },
	{ item = "rosquinha", quantidade = 1, compra = 30 },
	{ item = "hotdog", quantidade = 1, compra = 30 },
	{ item = "xburguer", quantidade = 1, compra = 30 },
    { item = "chips", quantidade = 1, compra = 30 },
    { item = "batataf", quantidade = 1, compra = 30 },
    { item = "pizza", quantidade = 1, compra = 30 },
	{ item = "taco", quantidade = 1, compra = 30 },
	
	{ item = "agua", quantidade = 1, compra = 30 },
	{ item = "cola", quantidade = 1, compra = 30 },
	{ item = "sprunk", quantidade = 1, compra = 30 },
	{ item = "energetico", quantidade = 1, compra = 30 },
    { item = "leite", quantidade = 1, compra = 30 },
    { item = "barracho", quantidade = 1, compra = 30 },
    { item = "patriot", quantidade = 1, compra = 30 },
    { item = "pibwassen", quantidade = 1, compra = 30 }
}

--[ COMPRAR ]----------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("departamento-comprar")
AddEventHandler("departamento-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
					local preco = parseInt(v.compra)
					if preco then
        
						if vRP.hasPermission(user_id,"ultimate.permissao") then
							desconto = math.floor(preco*20/100)
							pagamento = math.floor(preco-desconto)
						elseif vRP.hasPermission(user_id,"platinum.permissao") then
							desconto = math.floor(preco*15/100)
							pagamento = math.floor(preco-desconto)
						elseif vRP.hasPermission(user_id,"gold.permissao") then
							desconto = math.floor(preco*10/100)
							pagamento = math.floor(preco-desconto)
						elseif vRP.hasPermission(user_id,"standard.permissao") then
							desconto = math.floor(preco*5/100)
							pagamento = math.floor(preco-desconto)
						else
							pagamento = math.floor(preco)
						end
				
						if vRP.tryPayment(user_id,parseInt(pagamento)) then
							TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(pagamento)).." dólares</b>.")
							vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
						else
							TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
						end
					end
				else
					TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
				end
			end
		end
	end
end)