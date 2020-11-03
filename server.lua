VorpInv = exports.vorp_inventory:vorp_inventoryApi()
VorpCore = {}
data = {}

TriggerEvent("getCore", function(core) VorpCore = core end)

Citizen.CreateThread(function()
    Citizen.Wait(2000) 
    VorpInv.RegisterUsableItem("lockpick", function(data)
        TriggerClientEvent('gorp:saferobbery', data.source)
    end)
end)

local Items = {
	{item = "goldnugget", name = "gold nuggets", amountToGive = math.random(1,4)},
    {item = "watch_old", name = "old watch", amountToGive = math.random(1,2)},
    {item = "goldteeth", name = "Gold teeth", amountToGive = math.random(1,4)},
    {item = "rubyring", name = "Ruby rings", amountToGive = math.random(1,4)},
    --{item = "ammo_bullet_repeater", name = "Repeater Ammo", amountToGive = math.random(1,3)},
    --{item = "ammo_bullet_revolver", name = "Revolver Ammo", amountToGive = math.random(1,3)},
    --{item = "ammo_bullet_rifle", name = "munições de rifle", amountToGive = math.random(1,3)},
    --{item = "stim", name = "Horse Stimulants", amountToGive = math.random(1,3)},
    {item = "oldcoin", name = "old coins", amountToGive = math.random(2,5)},
    {item = "stolenmerch", name = "Stolen Goods", amountToGive = math.random(2,5)},
    {item = "moonshineTropical", name = "Tropical Moonshine", amountToGive = math.random(1,3)},
    {item = "moonshineApple", name = "Apple Pie Moonshine", amountToGive = math.random(1,3)},
    {item = "moonshine", name = "Moonshine", amountToGive = math.random(1,3)},
    --{item = "consumable_candy_bag", name = "Bag of candy", amountToGive = math.random(2,4)},
    --{item = "horsebrush", name = "horsebrush", amountToGive = 1},
    --{item = "infusaorv", name = "infusão revigorante", amountToGive = 1},
    --{item = "tonicobal", name = "tônico balsâmico", amountToGive = 1}
}

function payLoot(source)
    local Loot = {}
    for k, v in pairs(items) do 
        table.insert(Loot,v.item)
    end
    if Loot[1] ~= nil then
        local value = math.random(1,#Loot)
        local picked = Loot[value]
        return picked
    end
end


RegisterServerEvent('gorp:robberycomplete')
AddEventHandler('gorp:robberycomplete', function()
	local FinalLoot = LootToGive(source)
    local User = VorpCore.getUser(source).getUsedCharacter
    local chance = math.random(1,100)
    if chance <= 50 then
        for k,v in pairs(Items) do
                if v.item == FinalLoot then
                    VorpInv.subItem(source, "lockpick", 1)
                    VorpInv.addItem(source, FinalLoot, v.amountToGive)
                    LootsToGive = {}
                    TriggerClientEvent("vorp:TipRight", source, 'You found '..v.amountToGive..' ' ..v.name, 3000)
                end
            end
        else
        TriggerClientEvent("vorp:TipRight", source, 'Your lockpick broke!', 3000)
        VorpInv.subItem(source, "lockpick", 1)
    end
end)

function LootToGive(source)
	local LootsToGive = {}
	for k,v in pairs(Items) do
		table.insert(LootsToGive,v.item)
	end

	if LootsToGive[1] ~= nil then
		local value = math.random(1,#LootsToGive)
		local picked = LootsToGive[value]
		return picked
	end
end