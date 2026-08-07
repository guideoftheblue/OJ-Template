function Pandoc(doc)
    local authors = doc.meta.authors or {}
    local markdown = "" -- Markdown text to be inserted in ORCID block

    for _, author in ipairs(authors) do
        -- Building author names and ORCID IDs
        local name = pandoc.utils.stringify(author.name.given) .. " " .. 
            pandoc.utils.stringify(author.name.family)
        local orcid = pandoc.utils.stringify(author.orcid)

        -- If author has ORCID, add them to the block with linked ORCID icon and URL
        if orcid ~= "" then 
           markdown = markdown 
           .. name 
           .. " [![ORCID](assets/media/orcid_logo.png){width=11pt height=11pt}](https://orcid.org/" .. orcid .. ")"
           .. " [https://orcid.org/" .. orcid .. "](https://orcid.org/" .. orcid .. ")  \n" 
        end
    end

    local output = pandoc.Blocks(pandoc.read(markdown, "markdown").blocks)

    return doc:walk({
        Div = function(el)
            if el.identifier == "orcid" then -- Finds {#orcid} in md and fills it with built block
                return output
            end
        end
    })

end