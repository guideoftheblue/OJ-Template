#let first-page-header(doi) = [
    #text(style: "italic")[Practice Article]
    #v(-0.8em)
    #line(length: 100%)
    #v(-0.8em)
    #grid(
        columns: (1fr, 1fr),
        [
            #text(size: 8pt)[
                DOI:
                #link("https://doi.org/" + str(doi))[
                    #("https://doi.org/" + str(doi))
                ]
                \
                https://otessa.org
                \
                \#OTESSA
            ]
        ],
        [
            #place(
                top + right,
                image("assets/otessa-logo.jpg", width: 1.8in)
            )  
        ]
    ) 
]