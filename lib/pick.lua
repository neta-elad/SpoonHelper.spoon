return function(fn)
    return function()
        local spoons = hs.dialog.chooseFileOrFolder(
            "Choose Spoon directory",
            os.getenv("HOME") .. "/.hammerspoon/Spoons"
        )
        if not spoons then
            return
        end
        for _, directory in pairs(spoons) do
            fn(directory)
        end
    end
end