// Define header layouts for first, even, and odd pages

// First page header: article type, DOI, OTESSA website, OTESSA hashtag, and logo
#let first-page-header(doi) = [
    #text(style: "oblique")[Practice Article]
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

// Even page header: short title if available, full title otherwise
#let even-header(title, short-title) = [
  #text(style: "oblique")[
    #if short-title == none or short-title == "" {
      title
    } else {
      short-title
    }
  ]
  #v(-0.8em)
  #line(length: 100%)
]

// Odd page header: author last names
#let odd-header(authors) = [

    // Retrieve author last names
    #let last-names = authors.map(author => author.family)
    

    // Format names based on number of authors
    #let author-string = if last-names.len() == 1 {
        last-names.at(0)
    } else if last-names.len() == 2 {
        last-names.join(" and ")
    } else {
        last-names.slice(0, last-names.len() - 1).join(", ") + ", and " + last-names.last()
    }

    #align(right)[
        #text(style: "oblique")[#author-string]
    ]
    #v(-0.8em)
    #line(length: 100%)
]
