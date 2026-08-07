// Define footer layouts for first, even and odd pages

// First page footer: copyright information, journal details, and page number
#let first-page-footer(journal, article,) = [
    
    // Copyright logo and linked copyright statement
    #grid(
        columns: (auto, 1fr),
        column-gutter: 0.75em,
        [
            #image("assets/media/copyright.png", height: 1.75em)
        ],
        [
            #link(journal.copyright.url)[
                #text(size: 7pt)[
                    #journal.copyright.text
                ]
            ]
        ]
    )

    #v(-0.3em)
    #line(length: 100%)
    #v(-0.7em)

   
    #grid(
        // Journal details
        columns: (1fr, auto),
        [
            #text(size: 8pt)[ 
                #journal.title: #journal.year, Vol. #journal.volume#("(")#journal.issue#(")") 
                #article.pages
            ]
        ],
        // Page number
        [
            #box( 
                stroke: (left: 1pt), // Tiny vertical line
                inset: (left: 1em, right: 1em),
                outset: (top: 0.35em),
                height: 1em,
            )[
                #text(size: 8pt)[
                    #counter(page).display()
                ] 
            ]
        ]
    )
]

// Even page footer: page number followed by journal details
#let even-footer(journal, article) = [
    #line(length: 100%)
    #v(-0.7em)
    #grid(
        columns: (auto, 1fr),
        // Page number
        [
            #box(
                stroke: (right: 1pt), // Tiny vertical line
                inset: (left: 1em, right: 1em),
                outset: (top: 0.35em),
                height: 1em,
            )[
                #text(size: 8pt)[
                    #counter(page).display()
                ]
            ]
        ],
        // Journal details
        [
            #box(
                inset: (left: 1em),
            )[
                #text(size: 8pt)[
                    #journal.title: #journal.year, Vol. #journal.volume#("(")#journal.issue#(")") 
                    #article.pages
                ]
            ]
        ]
    )
]

// Odd page footer: journal details followed by page number
#let odd-footer(journal, article) = [
    #line(length: 100%)
    #v(-0.7em)

    #grid(
        columns: (1fr, auto),
        // Journal details
        [
            #text(size: 8pt)[
                #journal.title: #journal.year, Vol. #journal.volume#("(")#journal.issue#(")") 
                #article.pages
            ]
        ],
        // Page number
        [
            #box(
                stroke: (left: 1pt), // Tiny vertical line
                inset: (left: 1em, right: 1em),
                outset: (top: 0.35em),
                height: 1em,
            )[
                #text(size: 8pt)[
                    #counter(page).display()
                ] 
            ]
        ]
    )
]