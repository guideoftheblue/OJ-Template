#import "headers.typ": first-page-header, even-header, odd-header
#import "footers.typ": first-page-footer, even-footer, odd-footer

#let article(
  title: none,
  short-title: none,
  subtitle: none,
  authors: none,
  article: none,
  keywords: (),
  date: none,
  abstract-title: none,
  abstract: none,
  journal: none,
  thanks: none,
  cols: 1,
  lang: "en",
  region: "US",
  font: none,
  fontsize: 11pt,
  abstract-fontsize: 9.5pt, // Smaller to fit first page layout
  title-size: 1.5em,
  subtitle-size: 1.25em,
  heading-family: none,
  heading-weight: "bold",
  heading-style: "normal",
  heading-color: black,
  heading-line-height: 0.65em,
  mathfont: none,
  codefont: none,
  linestretch: 1,
  sectionnumbering: none,
  linkcolor: none,
  citecolor: none,
  filecolor: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  doc,
) = {
  // Set document metadata for PDF accessibility
  set document(title: title, keywords: keywords)
  set document(
    author: authors.map(author => content-to-string(author.name)).join(", ", last: " & "),
  ) if authors != none and authors != ()

  // Configure headers and footers
  set page(
    // Extra margin room on first page to allow for headers and footers
    margin: (top: 1.35in, bottom: 1.35in, x: 1in), 

    header: context [
      #let p = counter(page).get().first() 
      #if p == 1 [ // First page
        #first-page-header(article.doi)
      ] else if calc.rem(p, 2) == 0 [ // Even pages
        #even-header(title, short-title)
      ] else [ // Odd pages
        #odd-header(authors)
      ]
    ],

    footer: context [
      #let p = counter(page).get().first() 
      #if p == 1 [ //First page
        #first-page-footer(journal, article)
      ] else if calc.rem(p, 2) == 0 [ // Even pages
        #even-footer(journal, article)
      ] else [ // Odd pages
        #odd-footer(journal, article)
      ]
    ],
  )

  // Configure typography settings for paragraphs
  set par(
    justify: false,
    leading: linestretch * 0.65em
  )

  // Ensuring bulleted and enumerated lists indent
  set list(indent: 1.5em) 
  set enum(indent: 1.5em)

  // Configure code, math, and text font and language
  set text(lang: lang,
           region: region,
           size: fontsize)
  set text(font: font) if font != none
  show math.equation: set text(font: mathfont) if mathfont != none
  show raw: set text(font: codefont) if codefont != none

  set heading(numbering: sectionnumbering)

  //  Configure colours for hyperlinks, citations, and files
  show link: set text(fill: rgb(content-to-string(linkcolor))) if linkcolor != none
  show ref: set text(fill: rgb(content-to-string(citecolor))) if citecolor != none
  show link: this => {
    if filecolor != none and type(this.dest) == label {
      text(this, fill: rgb(content-to-string(filecolor)))
    } else {
      text(this)
    }
   }

  // Render title block if metadata is available
  let has-title-block = title != none or (authors != none and authors != ()) or date != none or abstract != none
  if has-title-block {
    // Position first page metadata at the top of the document
    place(
      top,
      float: true,
      scope: "parent",
      clearance: 4mm,
      block(below: 1em, width: 100%)[

        // Render article title and subtitle from style settings 
        #if title != none {
          align(center, block(inset: (top: 1em, bottom: 1em))[
            #set par(leading: heading-line-height) if heading-line-height != none
            #set text(font: heading-family) if heading-family != none
            #set text(weight: heading-weight)
            #set text(style: heading-style) if heading-style != "normal"
            #set text(fill: heading-color) if heading-color != black

            #text(size: title-size)[
                #title
                #if thanks != none {
                    footnote(thanks, numbering: "*")
                    counter(footnote).update(n => n - 1)
                }]
            #(if subtitle != none {
              parbreak()
              text(size: subtitle-size)[#subtitle]
            })
          ])
        }

         #if date != none {
          align(center)[#block(inset: 1em)[
            #date
          ]]
        }

        // Find the author marked as corresponding in the metadata
        #let corresponding-author = if authors != none and authors !=(){
          authors.find(author =>
            "corresponding" in author and author.corresponding
          )
        } else {
          none
        }

        // Create two-column layout if metadata available
        #if (
          (authors != none and authors != ()) 
          or abstract != none 
          or (keywords != none and keywords != ())
        ){
          // Two column layout for first page
          // Left: authors and correspondence 
          // Right: abstract and keywords
          grid(
            columns: (1fr, 1fr),
            gutter: 0.5em,
            
            // Left column: authors, affiliations and corresponding author
            block(inset: 1em)[
              #if (authors != none and authors != ()) {
                for author in authors {
                  block(below: 0.75em)[
                    #box[
                      #author.name
                      // If author has orcid, display linked ORCID icon
                      #if "orcid" in author and author.orcid != "" [
                        #link("https://orcid.org/" + str(author.orcid))[
                          #box(image("assets/media/orcid_logo.png", height: 1.2em))
                        ]
                      ]
                    ]\
                    #author.affiliation
                  ]
                }

                // Display corresponding author's contact information
                if corresponding-author != none {
                  block(above: 1.25em)[
                    #text(weight: "semibold")[Correspondence:]\
                    #corresponding-author.name\
                    #corresponding-author.affiliation\
                    #if corresponding-author.email != [] {
                      [Email: ]
                      content-to-string(corresponding-author.email).replace("@", " [at] ")
                    }
                  ]
                }
              }
            ],

            // Right column: abstract and keywords
            block(
              inset: 1em,
              // Dividing line between columns
              stroke: (left: 0.5pt + black),
            )[
              #text(size: abstract-fontsize)[
                #if abstract != none {
                  block(below: 1em)[
                    #text(weight: "semibold")[#abstract-title]\
                    #v(0.75em)
                    #abstract
                    #v(1em)
                  ]
                }

                #if keywords != none and keywords != () {
                  block[
                    #text(weight: "semibold")[Keywords:] #keywords.join(", ")
                  ]
                }
              ]          
            ],
          )
        }
      ]
    )
  }

  // End of first page
  pagebreak()
  // Reset margins after custom first-page layout
  set page(margin: 1in) 

  // Render table of contents when enabled
  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
    #outline(
      title: toc_title,
      depth: toc_depth,
      indent: toc_indent
    );
    ]
  }
  doc
}

#set table(
  inset: 6pt,
  stroke: none
)
