return function(directory)
    local workflowFile = io.open(hs.spoons.resourcePath("assets/github-zip-release-action.yml"), "r")
    local workflow = workflowFile:read("*a")
    workflowFile:close()

    hs.fs.mkdir(directory .. "/.github")
    hs.fs.mkdir(directory .. "/.github/workflows")
    io.open(directory .. "/.github/workflows/main.yml", "w"):write(workflow):close()
end