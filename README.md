Create beautiful documents and PDFs based on HTML5, CSS3 and leightweight markup.

Pubtml contains multiple steps:

1. **Write:** `[*idea* => markup]` Simply write text in an easly writable and readable markup. Possible formats include HTML, Markdown, Textile and reStructuredText. Large documents can be distributed over many files.
2. **Build**: `[markup => html]` All markup content is parsed into one HTML document.
3. **Style**: `[html => html]` Some general transformations extend the content of the document with metadata, Table of Contents and the like.
4. **Print**: The HTML code is converted to PDF using CSS3.

Pubtml relies on these tools:

* [PrinceXML](http://princexml.com)
* [pandoc](http://johnmacfarlane.net/pandoc)
    Pandoc is a library for converting from one markup format to another. It can read: markdown and (subsets of) Textile, reStructuredText, HTML, LaTeX, and DocBook XML; and it can write: plain text, markdown, reStructuredText, XHTML, HTML 5, LaTeX (including beamer slide shows), ConTeXt, RTF, DocBook XML, OpenDocument XML, ODT, Word docx, GNU Texinfo, MediaWiki markup, EPUB, Textile, groff man pages, Emacs Org-Mode, AsciiDoc, and Slidy, Slideous, DZSlides, or S5 HTML slide shows.
