-- Requires
local githubWorkflow = dofile(hs.spoons.resourcePath("github.lua"))

-- Form
local KEY_PREFIX = "SpoonHelper:"

function _save(key, value)
    hs.settings.set(KEY_PREFIX .. key, value)
end

function _load(key)
    return hs.settings.get(KEY_PREFIX .. key)
end

function _onPost(message)
    message.webView:hide()

    local project = message.body.project
    local description = message.body.description
    local author = message.body.author
    local email = message.body.email
    local github = message.body.github
    local workflow = message.body.workflow

    _save("author", author)
    _save("email", email)
    _save("github", github)
    _save("workflow", workflow)

    generate(project, description, author, email, github, workflow)
end

local usercontent = hs.webview.usercontent.new("SpoonHelperScaffold")
usercontent:setCallback(_onPost)

local webview = hs.webview.new(
    hs.geometry(10, 10, 700, 520),
    { javaScriptEnabled = true, developerExtrasEnabled = true },
    usercontent
)
webview:url("file://" .. hs.spoons.resourcePath("assets/scaffold-form.html"))
webview:windowTitle("Spoon Helper Scaffold Form")
webview:windowStyle({"closable", "titled"})
webview:allowTextEntry(true)
webview:closeOnEscape(true)

local scaffoldInitFile = io.open(hs.spoons.resourcePath("assets/scaffold-init.lua"), "r")
local scaffoldInit = scaffoldInitFile:read("*a")
scaffoldInitFile:close()

-- Public

function generate(project, description, author, email, github, workflow)
    hs.printf("Generating scaffold for %s, %s, %s, %s, %s, %s", 
        project, description, author, email, github, workflow)

    local spoonPath = hs.fs.pathToAbsolute("~") .. "/.hammerspoon/Spoons/" .. project .. ".spoon"

    os.execute("mkdir -p " .. spoonPath)

    local init = scaffoldInit
    init = init:gsub("$PROJECT", project)
    init = init:gsub("$DESCRIPTION", description)
    init = init:gsub("$AUTHOR", author)
    init = init:gsub("$EMAIL", email)
    init = init:gsub("$GITHUB", github)

    io.open(spoonPath .. "/init.lua", "w"):write(init):close()

    if (workflow) then
        githubWorkflow(spoonPath)
    end
end

function form()
    local author = _load("author")
    if (author ~= nil) then
        webview:evaluateJavaScript("setAuthor('" .. author .. "')")
    end

    local email = _load("email")
    if (email ~= nil) then
        webview:evaluateJavaScript("setEmail('" .. email .. "')")
    end

    local github = _load("github")
    if (github ~= nil) then
        webview:evaluateJavaScript("setGitHub('" .. github .. "')")
    end

    local workflow = _load("workflow")
    if (workflow ~= nil) then
        if (workflow) then
            webview:evaluateJavaScript("setWorkflow(true)")
        else
            webview:evaluateJavaScript("setWorkflow(false)")
        end
    end

    webview:show()
    webview:hswindow():focus()
end

return { generate = generate, form = form }