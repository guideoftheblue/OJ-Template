#let first-page-footer(journal, article,) = [
    
    // Copyright
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

    //Journal info and page number
    #grid(
        columns: (1fr, auto),
        [
            #text(size: 8pt)[
                #journal.title: #journal.year, Vol. #journal.volume#("(")#journal.issue#(")") 
                #article.pages
            ]
        ],
        [
            #box(
                stroke: (left: 1pt),
                inset: (left: 1em, right: 1em),
                outset: (top: 0.5em),
                height: 1em,
            )[
                #text(size: 8pt)[
                    #counter(page).display()
                ] 
            ]
        ]
    )
]

#let even-footer(journal, article) = [
    #line(length: 100%)
    #v(-0.7em)
    #grid(
        columns: (auto, 1fr),
        [
            #box(
                stroke: (right: 1pt),
                inset: (left: 1em, right: 1em),
                outset: (top: 0.55em),
                height: 1em,
            )[
                #text(size: 8pt)[
                    #counter(page).display()
                ]
            ]
        ],
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

#let odd-footer(journal, article) = [
    #line(length: 100%)
    #v(-0.7em)

    //Journal info and page number
    #grid(
        columns: (1fr, auto),
        [
            #text(size: 8pt)[
                #journal.title: #journal.year, Vol. #journal.volume#("(")#journal.issue#(")") 
                #article.pages
            ]
        ],
        [
            #box(
                stroke: (left: 1pt),
                inset: (left: 1em, right: 1em),
                outset: (top: 0.5em),
                height: 1em,
            )[
                #text(size: 8pt)[
                    #counter(page).display()
                ] 
            ]
        ]
    )
]