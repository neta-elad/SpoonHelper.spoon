local workflowFile = io.open(hs.spoons.resourcePath("assets/github-zip-release-action.yml"), "r")
local workflow = workflowFile:read("*a")
workflowFile:close()

return function(directory)

    hs.fs.mkdir(directory .. "/.github")
    hs.fs.mkdir(directory .. "/.github/workflows")
    io.open(directory .. "/.github/workflows/main.yml", "w"):write(workflow):close()
    hs.notify.show(
        "Spoon Helper",
        "GitHub workflow",
        "In your repository on GitHub, " .. 
            "go to Settings -> Actions -> general " ..
            "and set Workflow permissions to `read and write`."
    )
end