# Editing Mode and Reading Mode
*Editing mode* is meant to provide the user with a cursor, to edit the markdown text, while at the same time properties resulting from markdown features shall be reflected instantaneously.

The HTML elemente tree in *reading mode* is almost independent from the *editing mode* hierarchy. Elements used to group together logical units of text, like ordered or unordered lists, are *not at all* used in editing mode, which is entirely *line-based*. Empty lines, as dedicated HTML elements, do exist *only* in editing mode, and are substituted in reading mode by whitespace associated to HTML elements surrounding blocks of text.

In editing mode, the styles *need to avoid* any `margin` property. When not obeying this rule, the text cursor will behave unpredictable on vertical motion. Thus, *only* `padding` is at the developer's disposal to implement whitespace between logical units of the text.

Margin, more precisely *vertical* margin (`margin-top` and `margin-bottom`) comes with the feature of *collapsing*. When two `div` element next to each other define both *margin* between them, only the larger one of both will be rendered - the other is effectless. This is an almost inevitable tool for styling HTML pages. Not having *margin* at hand requires careful consideration about how to style the HTML elements.

*Obsidian-Typo* is designed such that the visual appearance in editing mode and in reading mode is almost identical. It establishes a correspondence between *margin* in the typical-HTML element structure used for *reading mode* and the whitespace created in *edtiting* mode. There are two kind of whitespace sources in editing mode:

1. Whitespace resulting from *blank lines* in continuous text;
2. spacing around headlines.

The former one is used *only* to separate blocks of continuous text, and is *never* used to create white space around the headlines.