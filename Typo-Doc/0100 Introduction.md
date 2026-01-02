Obsidian uses an HTML-based editor to edit and view markdown (`.md`) text files. *Themes* provide a set of rules to style both the editor as well as the surrounding interface. The default settings are laid out in the *default theme*. Obsidian distinguishes between two modes of operation:

1. *Editing mode*, here the markdown text can be edited white it is already HTML-converted;
2. *Reading mode*, where another set of styles and a different HTML hierarchy is used.

The styling of both modes can be customised by user-supplied CSS, either in the form of *CSS Snippets* or as separate *themes*.

There are many templates available, however I was always left insatisfied with a few phenomena:

1. In editing mode, it seems to be common sense that headlines feature whitespace only at the top side. I also most often disagree with the whitespace rendering around headings in reading mode.
2. Whitespace by blank lines appeared too pronounced to me.
3. I prefer writing texts in *serif* font, something which seems unpopular.
4. Regarding the font size of headlines I prefer the behaviour of the default theme.

The result of dealing with these issues is the *Obsidian-Typo package*. *Obsidian-Typo* is a set of stylesheets to achieve an improved typographical experience already in editing mode. Rendering in both modes (reading mode and editing mode) is virtually identical. None of the features is limited to reading mode.

*Obsidian-Typo* is *not* a full theme; in view of the many commits and years @kepano needed to write the popular *Minimal* theme, *Obsidian-Typo* definitely should always build on-top of elaborate present solutions. Furthermore, *Obsidian-Typo* affects *only* the `.md` document rendering; it does not modify the exterior interface.

The styles provided here are understood as *drop-ins* for existing themes. *Obsidian-Typo* tries hard to overcome the abovementioned limitations, using well-designed style sheets, s.t. that the typographic rules addressed by it are implemented with precision.