return function(directory)
    io.open(directory .. "/docs.json", "w"):write(hs.doc.builder.genJSON(directory)):close()
end