Create beautiful documents and PDFs based on HTML5, CSS3 and leightweight markup.

Pubtml contains multiple steps:

1. **Write:** `[*idea* => markup]` Simply write text in an easly writable and readable markup. Possible formats include HTML, Markdown, Textile and reStructuredText. Large documents can be distributed over many files.
2. **Build**: `[markup => html]` All markup content is parsed into one HTML document.
3. **Style**: `[html => html]` Some general transformations extend the content of the document with metadata, Table of Contents and the like.
4. **Print**: The HTML code is converted to PDF using CSS3.

Pubtml relies on these tools:

* [PrinceXML](http://princexml.com)
    PrinceXML is a high quality HTML-to-PDF converter and understands Javascript and CSS3 plus some extra style sheet properties, which make it easy to use advanced printing features with CSS. Its a proprietary software but is free for private use.
    It would be possible to use some open source alternatives but their support for print specific additiones is quite limited for now, so they lack proper footnote placement for example.
* [pandoc](http://johnmacfarlane.net/pandoc)
    Pandoc is a library for converting from one markup format to another. It can read: markdown and (subsets of) Textile, reStructuredText, HTML, LaTeX, and DocBook XML; and it can write: plain text, markdown, reStructuredText, XHTML, HTML 5, LaTeX (including beamer slide shows), ConTeXt, RTF, DocBook XML, OpenDocument XML, ODT, Word docx, GNU Texinfo, MediaWiki markup, EPUB, Textile, groff man pages, Emacs Org-Mode, AsciiDoc, and Slidy, Slideous, DZSlides, or S5 HTML slide shows.
