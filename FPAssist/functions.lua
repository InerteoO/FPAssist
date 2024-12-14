-- Addon pour simplifier la vie du FP


local tauntIfPossible = false


function castSpell(spellname)
CastSpellByName(spellname)
end

function FPAPrint(msg)
DEFAULT_CHAT_FRAME:AddMessage(msg)
end


function doTauntOrMockingBlow()
	local cdTaunt = FPAssistSpellOnCoolDown("Taunt")
	local cdMockingBlow = FPAssistSpellOnCoolDown("Mocking Blow")
	if not cdTaunt then
	castSpell("Defensive Stance")
	castSpell("Taunt")
	else
	if not cdMockingBlow then
	castSpell("Battle Stance")
	castSpell("Mocking Blow")
		end
	end
end




function attackIfSymbol()
symbol = GetRaidTargetIndex("target")
	if symbol == 1
    then
	FPAPrint("Symbole OK")
     castSpell("Bloodthirst(Rank 4)")
end
end



function tauntIfTargetChange()
    local target = GetUnitName("targettarget")
    local playerName = UnitName("player")
	local tar = GetUnitName("target")
	tauntIfPossible = false
	
	for k, v in ipairs(FPAssist.config.mobNotTauntable) do
	if tar == v then
	FPAPrint("Pas Tauntable")
	return
	end
end

    if target ~= playerName then
	tauntIfPossible = true
	FPAPrint("Taunt ok")
	else tauntIfPossible = false
    end
 end



 
function testTaunt()
	if tauntIfPossible == true then
		doTauntOrMockingBlow()
		castSpell("Defensive Stance")
	end
end
 
 
 
function FPAssistFindSpellNumber(sp)
	local BOOKTYPE_SPELL = "spell"
	for i = 1, 190 do 
	local s,r=GetSpellName(i, BOOKTYPE_SPELL) 
	if s == sp then 
	return i
		end 
	end 
	return nil
end 



function FPAssistSpellOnCoolDown(spellName)
    local spellIndex = FPAssistFindSpellNumber(spellName)
    if not spellIndex then
        return false
    end

    local start, duration = GetSpellCooldown(spellIndex, "spell") 
    if start == 0 then
        return false
    end

    local remaining = duration - (GetTime() - start)

    if remaining > 0 then
        return true 
    end

    return false
end






