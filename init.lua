--- === SpoonHelper ===
---
--- A menubar applet to help create Hammerspoon spoons
---

local module = {}
setmetatable(module, module)

-- Metadata
module.name = "SpoonHelper"
module.version = "0.0.4"
module.author = "Neta Elad <elad.neta@gmail.com>"
module.homepage = "https://github.com/neta-elad/SpoonHelper.spoon"
module.license = "MIT - https://opensource.org/licenses/MIT"

-- Requires
local pick = dofile(hs.spoons.resourcePath("lib/pick.lua"))
local docs = dofile(hs.spoons.resourcePath("lib/docs.lua"))
local github = dofile(hs.spoons.resourcePath("lib/github.lua"))
local scaffold = dofile(hs.spoons.resourcePath("lib/scaffold.lua"))

-- Local


-- Private


-- Public
function module:init()
    self.menubar = hs.menubar.new()

    self.menubar:setIcon(hs.image.imageFromName("NSAdvanced"):setSize({ w = 16, h = 16 }))
    self.menubar:setTooltip("Hammerspoon Spoon Helper")
    self.menubar:setMenu({
        { title = "🔨 Scaffold new spoon", fn = scaffold.form },
        { title = "📃 Generate docs", fn = pick(docs) },
        { title = "💻 Generate GitHub workflow", fn = pick(github) },
    })

    return self
end

return module
