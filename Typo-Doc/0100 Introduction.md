Obsidian comes with default settings, laid out in the *default theme*. These provide a set of rules to format plain markdown (`.md`) text files as HTML. Obsidian distinguishes between two modes of operation:

1. *Editing mode*, here the pure-text is already HTML-converted *while editing* it;
2. *Reading mode*, where another set of styles and a different HTML hierarchy is used.

The styling of both modes can be customised by user-supplied CSS, either in the form of *CSS Snippets* or as separate *themes*.

There are many templates available, however I was always left insatisfied with a few phenomena:

1. In the edting mode, headlines feature whitespace only on the top side, and I also dislike formatting in reading mode (for instance in both the default as well as the Minimal theme).
2. Whitespace by blank lines appeared too pronounced to me.
3. I prefer writing texts in *serif* font, something which seems unpopular.
4. The font size of headlines in the popular *Minimal* theme by @kepano are rather small, so I'd prefer the behaviour of the default theme in this matter.
5. However, I found myself using the advanced checkmark icons of the *Minimal* theme regularly.

The result of dealing with these issues is the *Obsidian-Typo package*. *Obsidian-Typo* is a set of Stylesheets to achieve an improved typographical experience already in the editing mode, which is maintained also in reading mode.

*Obsidian-Typo* is *not* a full theme; in view of the many commits and years @kepano needed to write the popular *Minimal* theme, *Obsidian-Typo* definitely should always build on-top of elaborate present solutions.

Thus, the styles provided here are understood as *drop-ins* for existing themes. *Obsidian-Typo* tries hard to overcome the abovementioned limitations, using well-designed style sheets, s.t. that the typographics rules addressed by it are implemented with precision. It is tested with the default theme and with the *Minimal* theme.