local players = game:GetService("Players")
local camera = workspace.CurrentCamera
local espcolor = Color3.fromRGB(59, 153, 253)
local boxesp = false
local nameesp = false
local BoxFilled = false
local gs = game:GetService("GuiService"):GetGuiInset()
local ESPMain = {}
local tracers = false
local teamcheck = false

createline = function()
    local line = Drawing.new("Line")
    line.Thickness = 1.5
    line.Transparency = 1
    line.Visible = true
    line.Color = espcolor
    line.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2 + 400)
    return line
end

createlabel = function(text)
    local label = Drawing.new("Text")
    label.Transparency = 1
    label.Visible = true
    label.Color = espcolor
    label.Text = text
    label.Size = 15
    return label
end

createbox = function()
    local box = Drawing.new("Square")
    box.Transparency = 1
    box.Thickness = 1.5
    box.Visible = true
    box.Color = espcolor
    box.Filled = BoxFilled
    return box
end

local player = players.LocalPlayer
function isInTeam(char)
    if teamcheck == true then
        if player and players:GetPlayerFromCharacter(char) and players:GetPlayerFromCharacter(char).Team and player.Team then
            if players:GetPlayerFromCharacter(char).Team ~= player.Team then
                return false
            else
                return (player.Team == players:GetPlayerFromCharacter(char).Team)
            end
        end
    else
        return false
    end
end

game:GetService("RunService").Stepped:Connect(
    function()
        spawn(
            function()
                for i, v in pairs((game:GetService("Players")):GetChildren()) do
                    if
                        v.Name ~= game:GetService("Players").LocalPlayer.Name and
                            v.Name ~= game.Players.LocalPlayer.Name and
                            v.Character and
                            v.Character:FindFirstChild("Head") and
                            v.Character
                     then
                        if not ESPMain[v.Name] then
                            ESPMain[v.Name] = {
                                v.Character
                            }
                        end
                        local vector, onScreen = camera:WorldToScreenPoint(v.Character["Head"].Position)
                        if nameesp then
                            if ESPMain[v.Name][4] then
                                ESPMain[v.Name][4].Visible = (onScreen and nameesp)
                                ESPMain[v.Name][4].Position = Vector2.new(vector.X, vector.Y + (gs.Y / 2))
                                ESPMain[v.Name][4].Color = espcolor
                            else
                                ESPMain[v.Name][4] = createlabel(v.Name)
                                ESPMain[v.Name][4].Visible = (onScreen and nameesp)
                                ESPMain[v.Name][4].Position = Vector2.new(vector.X, vector.Y + (gs.Y / 2))
                                ESPMain[v.Name][4].Color = espcolor
                            end
                        else
                            if ESPMain[v.Name] then
                                if ESPMain[v.Name][4] then
                                    ESPMain[v.Name][4]:Remove()
                                    ESPMain[v.Name][4] = nil
                                end
                            end
                        end
                        if tracers then
                            if ESPMain[v.Name][2] then
                                ESPMain[v.Name][2].Visible = (onScreen and tracers)
                                ESPMain[v.Name][2].Color = espcolor
                                ESPMain[v.Name][2].To = Vector2.new(vector.X, vector.Y + gs.Y)
                                ESPMain[v.Name][2].From =
                                    Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2 + 400)
                            else
                                ESPMain[v.Name][2] = createline()
                                ESPMain[v.Name][2].Visible = (onScreen and tracers)
                                ESPMain[v.Name][2].To = Vector2.new(vector.X, vector.Y + gs.Y)
                                ESPMain[v.Name][2].From =
                                    Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2 + 400)
                                ESPMain[v.Name][2].Color = espcolor
                            end
                        else
                            if ESPMain[v.Name][2] then
                                ESPMain[v.Name][2]:Remove()
                                ESPMain[v.Name][2] = nil
                            end
                        end
                        if boxesp then
                            if ESPMain[v.Name][3] then
                                ESPMain[v.Name][3].Visible = (onScreen and boxesp)
                                ESPMain[v.Name][3].Size = Vector2.new(1400 / vector.Z, 2000 / vector.Z)
                                ESPMain[v.Name][3].Color = espcolor
                                ESPMain[v.Name][3].Position =
                                    Vector2.new(
                                    vector.X - ESPMain[v.Name][3].Size.X / 2,
                                    vector.Y + game:GetService("GuiService"):GetGuiInset().Y -
                                        ESPMain[v.Name][3].Size.Y / 2
                                )
                            else
                                ESPMain[v.Name][3] = createbox()
                                ESPMain[v.Name][3].Visible = (onScreen and boxesp)
                                ESPMain[v.Name][3].Size = Vector2.new(1400 / vector.Z, 2000 / vector.Z)
                                ESPMain[v.Name][3].Color = espcolor
                                ESPMain[v.Name][3].Position =
                                    Vector2.new(
                                    vector.X - ESPMain[v.Name][3].Size.X / 2,
                                    vector.Y + game:GetService("GuiService"):GetGuiInset().Y -
                                        ESPMain[v.Name][3].Size.Y / 2
                                )
                            end
                        else
                            if ESPMain[v.Name][3] then
                                ESPMain[v.Name][3]:Remove()
                                ESPMain[v.Name][3] = nil
                            end
                        end
                    else
                        if ESPMain[v.Name] then
                            if ESPMain[v.Name][2] then
                                ESPMain[v.Name][2]:Remove()
                                ESPMain[v.Name][2] = nil
                            end
                            if ESPMain[v.Name][3] then
                                ESPMain[v.Name][3]:Remove()
                                ESPMain[v.Name][3] = nil
                            end
                            if ESPMain[v.Name][4] then
                                ESPMain[v.Name][4]:Remove()
                                ESPMain[v.Name][4] = nil
                            end
                        end
                    end
                end
            end
        )
    end
)

players.PlayerRemoving:Connect(
    function(plr)
        if ESPMain[plr.Name] then
            if ESPMain[plr.Name][2] then
                ESPMain[plr.Name][2]:Remove()
                ESPMain[plr.Name][2] = nil
            end
            if ESPMain[plr.Name][3] then
                ESPMain[plr.Name][3]:Remove()
                ESPMain[plr.Name][3] = nil
            end
            if ESPMain[plr.Name][4] then
                ESPMain[plr.Name][4]:Remove()
                ESPMain[plr.Name][4] = nil
            end
            ESPMain[plr.Name] = nil
        end
    end
)

local HeliosESP = {}

function HeliosESP:BoxESPToggle(status)
    boxesp = status
end
function HeliosESP:TracersToggle(status)
    tracers = status
end
function HeliosESP:NameESPToggle(status)
    nameesp = status
end
function HeliosESP:TeamcheckToggle(status)
    teamcheck = status
end
function HeliosESP:SetESPColor(color)
    espcolor = color
end
return HeliosESP
