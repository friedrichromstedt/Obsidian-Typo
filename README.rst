Abstract
========

*Obsidian* is a Markdown (``.md`` files) editor.  It used an HTML-based
interface employing *Electron*.

Due to the nature of an HTML-based GUI, *all* interface components of
*Obsidian* can be styled by CSS (*Cascading Style Sheets*).  Style-sheets
can be given either as *themes* or as *CSS snippets*.

While writing texts with Obsidian, I found the rendering of *whitespace*
often inadequate, especially whitespace around headlines, but also in
places like in the surroundings of enumerations and itemisations.

Presented here is *Obsidian-Typo*, a set of CSS snippets implementing
primarily typographic rules related to whitespace, but also addressing a
few topics more.

*Obsidian* distinguishes between *reading mode* and *editing mode*.
*Obsidian-Typo* brings these two very close to each other, implementing all
major achievements already in editing mode.

*Obsidian-Typo* is *not* a theme.  It is of no influence whatsoever on the
general UI appearance, and addresses *only* the typography in *reading
mode* and in *editing mode*.

*Obsidian-Typo* is designed in such a way, that the application of its CSS
codes to a given *Obsidian Vault* does not require adaption of the markdown
sources for the Vault's documents.  If further compensates many adjustments
made before using additional blank lines *from the beginning* wherever
possible and appropriate.  Because with *Obsidian-Typo* the typography is
optimised already in editing mode, the usage of *Obsidian* benefits from
*Obsidian-Typo* early on, improving user experience with Obsidian from the
beginning of drafting Obsidian documents.


Documentation
=============

Documentation is maintained in a separate repository and is distributed as
a ZIP archive (``Typo-Doc.zip``) located in the root directory of this
repository.

The documentation is licensed independently from the MIT-licensed CSS code.
