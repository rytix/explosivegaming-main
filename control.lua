--[[
Explosive Gaming

This file can be used with permission but this and the credit below must remain in the file.
Contact a member of management on our discord to seek permission to use our code.
Any changes that you may make to the code are yours but that does not make the script yours.
Discord: https://discord.gg/r6dC2uK
]]
--Please Only Edit Below This Line-----------------------------------------------------------

-- replaces the base error function
_error = error
error = function(err)
    if _G.discord_emit and game then
        local color = _G.Color and Color.to_hex(defines.text_color.bg) or '0x0'
        discord_emit{title='SCRIPT ERROR',color=color,description='There was an error in the script @Developers ',Error=err}
    elseif _G.Game and game then
        if Game.print_all(err) == 0 then
            _error(err)
        end
    else
        _error(err)
    end
end

require("mod-gui")
-- loads the stdlib and allows Core Game and Event
Color, Game, Event = require('/StdLib/load'){'Color','Game','Event'}

-- loads the ExpLib, functions are plased into the lua global
local ExpLib = require 'ExpLib'
ExpLib._unpack_to_G(ExpLib)
--_G.discord_emit = nil -- un-comment this line if you are not using the json.data

-- loads the ExpCore files these are need in order to run the other addons
Ranking, Server, Gui = require('/ExpCore/load'){'Ranking','Server','Gui'}
local success,err = pcall(require,'/ExpCore/GuiParts/test')
if success then Gui.test = err end
if Gui.popup then Gui.popup._load() end
-- this loads the ranks that Ranking uses
require('/ExpCore/ranks')
-- this loads any edits that are not need in core pcall as file may not be preset
pcall(require,'/Addons/playerRanks')
-- this makes sure that all the little details are cleaned up
Ranking._auto_edit_ranks()
-- this loads all the addons
local success,err = pcall(require,'Addons/load')
if not success then error(err) end
-- this loads anything that does not use ExpCore (sourse given in the file)
local success,err = pcall(require,'StandAlone/load')
if not success then error(err) end