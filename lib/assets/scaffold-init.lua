--- === $PROJECT ===
---
--- $DESCRIPTION
---

local module = {}
setmetatable(module, module)

-- Metadata
module.name = "$PROJECT"
module.version = "0.0.1"
module.author = "$AUTHOR <$EMAIL>"
module.homepage = "https://github.com/$GITHUB/$PROJECT.spoon"
module.license = "MIT - https://opensource.org/licenses/MIT"

-- Public
function module:init()
end

return module
