local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

frame:SetScript("OnEvent", function(self, event)
        DEFAULT_CHAT_FRAME:AddMessage("FPAssist chargé")
end)

