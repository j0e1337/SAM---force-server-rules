
net.Receive("SAM.ForceRules", function()
    local duration = net.ReadInt(32)
    local endTime = CurTime() + duration

    local frame = vgui.Create("DFrame")
    frame:SetTitle("Server-Rules")
    frame:SetSize(ScrW() * 0.8, ScrH() * 0.8)
    frame:Center()
    frame:MakePopup()
    frame:SetDraggable(false)
    frame:ShowCloseButton(false)

    local container = vgui.Create("DPanel", frame)
    container:Dock(FILL)
    container:DockPadding(5, 5, 5, 5)

    local html = vgui.Create("DHTML", container)
    html:Dock(FILL)
    html:OpenURL("https://example.com/")

    ----> do not remove the disconnect button, your server can get blacklisted for that - read the gmod server operator rules!
    local btnDisconnect = vgui.Create("DButton", container)
    btnDisconnect:Dock(BOTTOM)
    btnDisconnect:SetTall(40)
    btnDisconnect:SetText("Disconnect")
    btnDisconnect:SetFont("DermaLarge")
    btnDisconnect:SetTextColor(Color(255, 255, 255))
    btnDisconnect.Paint = function(self, w, h)
        surface.SetDrawColor(180, 50, 50)
        surface.DrawRect(0, 0, w, h)
    end
    btnDisconnect.DoClick = function()
        RunConsoleCommand("disconnect")
    end
    ---->

    frame.Think = function(self)
        local remaining = math.ceil(endTime - CurTime())

        if remaining > 0 then
            self:SetTitle(string.format("Please read the rules! (%ds remaining)", remaining))
        else
            self:Close()
        end
    end

    net.Receive("SAM.ForceRulesEnd", function()
        if IsValid(frame) then
            frame:Close()
        end
    end)
end)




