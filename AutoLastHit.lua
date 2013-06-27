local toggleKey = "L"
local isRunning = false
local isKeyPressed = false
local delay = 0.0
local attacking = false
local playerMoveSpeed = 345
local creepDps = 8
local enabled = true
local function AutoAttackCreep()
    if not enabled then
        return false
    end
    if d2i.me == nil then
        return false
    end
 
    if not isKeyPressed and not d2i.KeyDown(string.byte(toggleKey)) then
        isKeyPressed = true
        isRunning = not isRunning
        elseif isKeyPressed and d2i.KeyDown(string.byte(toggleKey)) then
        isKeyPressed = false
    end
 
    d2i.DrawText(d2i.me.screenx, d2i.me.screeny, (isRunning and toggleKey .. ": AutoAttack On" or toggleKey .. ": AutoAttack"))
    if not isRunning then
        return false
    end
 
    damage = d2i.me.damagemin+d2i.me.damagebonus+(d2i.me.baseattacktime*creepDps)
    newTarget = false
    if d2i.creeps ~= nil and damage ~= nil then
        for i=1, #d2i.creeps do
            if d2i.creeps[i] ~= nil and d2i.creeps[i].hp ~= 0 then
                distanceToCreep = d2i.DistanceTo(d2i.creeps[i].x,d2i.creeps[i].y,d2i.creeps[i].z)-d2i.me.attackrange
                creephp = d2i.creeps[i].hp
                if not newTarget and creephp < (damage+((distanceToCreep)/playerMoveSpeed)*creepDps) and distanceToCreep < d2i.me.attackrange+600 then
                    newTarget = true
                    if d2i.creeps[i].team ~= d2i.me.team then
                        d2i.DrawText(d2i.creeps[i].screenx, d2i.creeps[i].screeny, "Last Hitting")
                    end
                    if d2i.creeps[i].team == d2i.me.team then
                        d2i.DrawText(d2i.creeps[i].screenx, d2i.creeps[i].screeny, "Denying")
                    end
                 
                    if delay > d2i.game.time then
                        return
                    end
                    d2i.Attack(d2i.creeps[i].entity)
                    attacking = true
                    delay = d2i.game.time +  0.4
                    return
                end
            end
        end
    end
 
    if not newTarget and attacking then
        d2i.Stop()
        d2i.Hold()
        attacking = false
    end
end
 
d2i.AddCallback(AutoAttackCreep)
