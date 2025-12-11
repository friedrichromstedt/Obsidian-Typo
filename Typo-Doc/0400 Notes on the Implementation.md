# 1 Editing Mode and Reading Mode
*Editing mode* is meant to provide the user with a cursor, to edit the markdown text, while at the same time properties resulting from markdown features shall be reflected instantaneously. The editing mode is called also the *live* mode.

HTML Elements used to group together logical units of text, like ordered or unordered lists, are *not at all* used in editing mode, which is entirely *line-based*. Empty lines, as dedicated HTML elements, do exist *only* in editing mode, and are substituted in reading mode by whitespace associated to HTML elements surrounding blocks of text.

The HTML elemente tree in *reading mode* is almost independent from the *editing mode* hierarchy. The editing mode also carries the name "*preview* mode", as it shows the HTML rendering where lists are used while whitespace lines are *not* used. In reading mode, whitespace between blocks of text is implemented utilising `margin` styles.

In editing mode, the styles *need to avoid* any `margin` property. When not obeying this rule, the text cursor will behave unpredictable on vertical motion. Thus, *only* `padding` is at the developer's disposal to implement whitespace between logical units of the text.

Vertical margin (`margin-top` and `margin-bottom`) comes with the feature of *collapsing*. When two `div` element next to each other define both *margin* between them, only the larger one of both will be rendered - the other is effectless. This is an almost inevitable tool for styling HTML pages. Not having *margin* at hand requires careful consideration about how to style the HTML elements.

*Obsidian-Typo* is designed such that the visual appearance in editing mode and in reading mode is almost identical. It establishes a correspondence between *margin* in the typical-HTML element structure used for *reading mode* and the whitespace created in *edtiting* mode.
# 2 HTML Structure
In Live Mode, each line of raw markdown, as it is stored on-disk, is represented by a `div.cm-line` element in Obsidian. `.cm-lines` can occupy several lines of text in the interface, but line breaks between markdown lines is respected always. The `.cm-lines` carry additional classes:

- `.HyperMD-header` matches *any* headline. `.HyperMD-header-1` to `.HypeMD-header-6` are used to style `.cm-lines` as headlines in the respective level.
- The `div.inline-title` is the document's title, as deduced from the .md filename.
- Inline *code* spans are defined as `span.cm-inline-code`.
- Lines of input used in *code blocks* carry each the `.HyperMD-codeblock` class.
- The entire *live mode* document is selected as `div.cm-editor`, the *preview* mode document as `div.markdown-preview-view`.
- The `.cm-line` currently carrying the *cursor* is outfit by the `.cm-active` class.

It is not possible to make lines of code overflow horizontally, due to the absence of elements grouping lines together in live mode. As a result, if applying overflow attributes, each line overflows independently. It would be possible to enable overflow properties in preview mode, at the expense of losing symmetry w.r.t. mode transition.
# 3 Whitespace
Whitespace comes in two flavours when using *Obsidian-Typo* in live mode:

1. Whitespace resulting from entering *empty lines*,
2. spacing around headlines.

The former one is used *only* to separate blocks of continuous text, and is *never* needed to create white space around headlines.
## 3.1 Whitespace Around Headlines
Normally, whitespace around headlines would be accomplished by setting `margin-top` and `margin-bottom`. Between adjacent headlines and at the frontier between a headline and preceding or following continuous text, the margins would *collapse*. In Obsidian's Live mode, this approach is not possible, because the *collapsing* feature would mislead the code positioning the cursor.

The spacing around the `h1` ... `h6` elements in `em` of the continuous text can be calculated by multiplying the respective *headline size* in `em` by the *margin size* in `em`. I did an investigation of the margins used by the Firefox browser when writing a simple `.rst` file with six levels of headlines and applying Docutil's `rst2html` to it. The typography of the headlines is defined here solely by the browser stylesheet. The result was two-fold:

1. Larger headlines use a smaller `em` figure to control the margin around `h1`...`h6` headlines. However, the spacings measured in `em` of the surrounding text results were not identical, but close to each other.
2. The margin is identical above and below each headline.

Because of this findings, I decided to place `1em` of continuous text between headlines and between continuous text and headlines, independent from the headline level. This approach is significant for the practicability of the whole undertaking: Between two headlines, *each* of them can install the `1em` padding, and between text and a headline, even the *text* can provide `1em` of padding. With an effective spacing *dependent on the headline level*, this freedom of choice would not exist.

When a headline element carries a font size setting of `<A>em`, with a decimal number `<A>`, the figure `<1/A>em` corresponds to `1em` of the continuous text, as both figures `<A>` and `<1/A>` accumulate by multiplication. Thus, given a headline sizes of `<A>em`, declaring `padding: <1/A>em` will provide the headline with a padding of `1em` measured in `em` of the surrounding text.

The principal approach to apply these results, the following procedure is taken:

1. Each `.HyperMD-header-<N>` element is provided with a `padding-top` of `1em` of the surrounding continuous text, by translating this `1em` to the corresponding size in *headline* `em`.
2. The first non-headline `.cm-line` *following* a `.HyperMD-header` line is instructed to carry a `1em` `padding-top` in its native size *as well*.

While the item (1.) provides the margin atop the first headline following ordinary text *and* the margin between headlines following each other, the second rule completes the headline section by separating the last heading from the first following line of continuous text by the same amount of space. In a block of two headings or more, all headlines from the second one onwards *are* are `.cm-line` *and* are following a `HyperMD-header`, s.t. the second rule selects these headlines. At the same time, rule (1.) applies *only* header lines (of the given level), this means, that the first line of continuous text is selected *only* by rule (2.). Writing thus rule (2.) in the CSS code *above* rule (1.) ensures that:

- All header lines carry the `padding-top` resulting in a padding of `1em` of the continuous text;
- the first line of continuous text below provides the separation from the headline by `1em` of its native, continuous font size.

Whitespace around headlines in preview mode is accomplished by the usual declaration of symmetric *margin*, using otherwise the same figures as used for the editing mode.

The *title* of the document displayed at the very top of the rendered output, as it is derived from the .md filename, is a `div.inline-title` element with the `h1` font-size. In reading mode, its separation from the first line of text can be declared using `margin` as for all other headlines, as it is directly adjacent to these following lines.

In *editing mode*, the `div.inline-title` is *kept separate* from the text body. To maintain `1em` of whitespace *between the inline title and the body*, in this case the `.inline-title` provides the padding. This means, that the *first line* of the body *never* carries *any* `margin-top`; this is expressible by using the idom `.cm-line +` in front of it.
# 4 Whitespace in Continuous Text
Each line of blank is an `.cm-line` containing *nothing more* than a `br` element, so empty lines can be selected by:
```css
div.cm-line:has(> br:only-child)
```
The height of blanks between lines of continuous text is limited to a fraction of the text height of the continuous text, unless the blank line *has the cursor*. A blank line is considered as surrounded by continuous text also when line items are adjacent to list items.

To accomplish both, first a rule selecting *all* blank lines is given, which sets the `font-size` to a certain value, and in direct succession another rule is written, which resets these declaration by `font-size: 100%` for the `.cm-active` line. This styling of the `.cm-active` line in beneficial because otherwise the cursor would be shown in the reduced size until the user starts typing.

When the rendering of a line of md text wraps around at the viewport boundary or when lines of text are placed without interspersed blanks in between, the vertical spacing between successive lines is controlled by the *line height*.

The markdown standard requires that *paragraphs* are separated by a blank line. Furthermore, lines directly following a list item line in the same spirit *belong to that list item*. Following a list block thus a blank line needs to be provided, in order to prevent the next following line from being subsumed to the list. As a result, it is a good idea to separate lists and body text by a blank line *at the top* and *at the bottom end*.

The *Obsidian-Typo* styles for lists include declaration of corresponding whitespace atop/below lists. This means, that the *blank lines* from the editing mode can correspond to the margin of the lists involved when watching the reading mode rendering.

During designing the amount of whitespace between text blocks, I adjusted the measures in the following order:

1. Optimisation of the *line height*;
2. tuning the size of a blank line in percent `'%'` of the surrounding text;
3. defining the figure used in *reading mode* around lists and around paragraphs. This measure is given in `em`. It is defined by both the percentage of the second point as well as by the line height. The size of the blank lines in `em` is given by the product of both figures, in `em`: When the line height is $l$ and the "blank line percentage" by $p$, then the size occupied by a blank line amounts to `1em * l * p`. This length is then used to dimension the *margin* of lists and of paragraphs.

In this way, switching between editing and reading mode has almost negligible impact on the amount of whitespace in continuous text.
# 5 Blank Lines Adjacent to Headlines