# 1 Editing and Reading Mode
*Editing mode* is meant to provide the user with a cursor to edit the markdown text, while at the same time properties resulting from markdown features shall be reflected instantaneously. The editing mode is called also the *live* mode.

HTML Elements used to group together logical units of text, like ordered or unordered lists, are *not at all* used in editing mode, which is almost entirely *line-based*. Empty lines, as dedicated HTML elements, do exist *only* in editing mode, and are substituted in reading mode by whitespace associated to HTML elements surrounding blocks of text.

Normally, whitespace is preferrably accomplished by setting *margins*. Vertical margin (`margin-top` and `margin-bottom`) comes with the feature of *collapsing*: When two elements vertically next to each other define both *margin* between them, whitespace corresponding to the *maximum* of the two figures will be rendered. This is an almost inevitable tool for styling HTML pages.

In editing mode, the styles *need to avoid* any `margin` property. Not obeying this rule misleads the algorithms positioning the cursor, such that the cursor will behave unpredictable on vertical motion. Thus, aside of relying on blank lines, *only* `padding` is at the developer's disposal to implement whitespace between logical units of the text. Not having *margin* at hand requires careful consideration about how to style the HTML elements. Furthermore, the *box model*, consisting of three regions (*padding*, *border*, *margin*), characterises the *background* to *extend* into the padding, while the *margin* inherits the background from the superordinate element. As long as an element's background colour is identical to that of its parent element (and there is no *border*), many spacing issues can be solved by using padding instead of margin, but as soon as the background colours differ from each other, the substitution of *margin* by *padding* is not completely possible anymore.

In Live Mode, each line of raw markdown, as it is stored on-disk and as long as it is not part of a table, is represented by a `div.cm-line` element in Obsidian. `.cm-lines` can occupy several lines of text in the interface, and will be word-wrapped. The `.cm-lines` carry additional classes:

- `.HyperMD-header` matches *any* headline. `.HyperMD-header-1` to `.HypeMD-header-6` are used to style `.cm-lines` as headlines in the respective level.
- Inline *code spans* are defined as `span.cm-inline-code`.
- Lines of markdown input forming *code blocks* carry each the `.HyperMD-codeblock` class.
- The `.cm-line` currently carrying the *cursor* is outfit by an additional `.cm-active` class.

The entire *live mode* document is selected as `div.cm-editor`, the *preview* mode document as `div.markdown-preview-view`.

The HTML elemente tree in *reading mode* is almost independent from the *editing mode* hierarchy. The editing mode also carries the name "*preview* mode", as it shows the HTML rendering using e.g. lists and paragraphs. In reading mode, whitespace between blocks of text is implemented utilising `margin` styles. Blank lines are not rendered *as such* in reading mode.
# 2 Whitespace
Lines of the following types occur in live mode:

- *Headlines*. These shall be surrounded by whitespace automatically, without the need to type blank lines.
- *Blank lines*. When separating paragraphs and/or lists, the height of such separation lines shall be *reduced*. When such a blank separation line however *contains the cursor*, its font size shall be reset to full height.
- *Code block lines*. It is noteworthy here that code block lines use a smaller font size than lines of continuous text.
- *Lines of continuous, non-blank text*. These should form well-lisable paragraphs.

Vertical whitespace can be rendered between each two successive elements drawn from this set of types. The CSS codes shall work for *any* possible type of combination. There are also (rare) cases where *three* consecutive elements are used to define styles.

The spacing around the `h1` ... `h6` elements in `em` of the continuous text can be calculated by multiplying the respective *headline size* in `em` by the *margin size* in `em`. I did an investigation of the margins used by the Firefox browser by writing a simple `.rst` file with six levels of headlines and applying Docutil's `rst2html` to it. The typography of the headlines is defined here solely by the browser stylesheet. The result was two-fold:

1. Larger headlines use a smaller `em` figure for their surrounding margin. Here, the spacings measured in `em` of the surrounding text results were close to each other (although not identical).
2. The margin is identical above and below each headline.

Because of this findings, I decided to place whitespace around headlines which is quivalent to `1em` in continuous text, independent of the headline level. This approach is essential for the practicability of the whole undertaking: Between two headlines, *each* of them can install the `1em` padding, and above/below a block of consecutive headlines, even the lines *above* or *below* can provide `1em` of padding. With an effective spacing *dependent on the headline level*, this freedom of choice would not exist.

In preview mode, the empty lines in the md code are taken into account to determine the boundaries of paragraphs (`p` elements) as well as of itemisation and enumerations (`ul` and `ol` elements). Not all empty lines corresponds by necessity to such a boundary: It is e.g. possible in markdown to separate items of lists by vertical white space, without any effect of this blanks on the HTML rendering in preview mode. However, when using blank lines with caution, limiting their use to places where they correspond to boundaries, makes it possible to establish equivalences of blanks and boundaries. The *margins* defined for `p`, `ul` and `ol` elements in preview mode are designed in such a way, that they introduce *exactly* the same amount of vertical white space as the empty lines in live mode they correspond to.
## 2.1 The Title Line of the Document
The title line wording, contained in an `div.inline-title`, is defined by the document's .md filename on-disk, by removing the `.md` file extension from the file name. In reading mode, the body of the document starts by the `div.inline-title`, followed by the markdown code content of the file translated to HTML, while in live mode, the `.inline-title` resides in an independent container.

The `.inline-title` is provided with a vertical whitespace *below*, equivalent to those used for an `h1` headline. Because the *inline title* is not part of the *live body*, while it *is* part of the document's `div` in preview mode, it can be styled by using `margin-bottom`. Such a margin will *collapse* with the whitespace styles for the file's contents in reading mode, while acting like a *padding* in editing mode.

In live mode, the first `.cm-line` of the *document body* must not define further top padding, to not introduce further empty space between the title and the body.
## 2.2 Headlines
For *any* `div.HyperMD-header.cm-line` the `padding-top` is zeroed out as the first specification. Because all other rules declaring a `padding-top` require a predecessor of *some* sort, this zero padding will be applied as a default value to a headline, when it is placed *directly* at the top end of the body. Otherwise, when the headline is *not* the first line, other rules will override this value of zero.

When a headline element carries a font size setting of `<A>em`, with a decimal number `<A>`, the figure `<1/A>em` corresponds to `1em` of the continuous text, as both figures `<A>` and `<1/A>` accumulate by multiplication. Thus, given a headline sizes of `<A>em`, declaring a padding of `<1/A>em` will provide the headline with a padding of `1em` measured in `em` of the surrounding text. This `<1/A>em` figure will be applied as `padding-top`.

The `padding-top` will be re-set to zero, when the headline is located below a stack of two elements:

1. A headline;
2. an empty line not carrying the cursor.

This set of styles for `padding-top` ensures that in a stack of directly adjacent headlines it holds that:

1. The first headline is separated from the content preceding it by `1em` of continuous text, unless the headline is the first `.cm-line` in the whole document, and unless it is separated from another headline by a blank line;
2. between successive headlines, the `1em` padding is installed.

However, the headlines do not provide the padding between a headline and following non-headline elements. For this sake, any `div.cm-line` directly following a `div.HyperMD-header.cm-line` is styled by rules in the following order:

1. Any such `.cm-line` receives a `padding-top` of `1em`. This remains active, unless it is overridden by the following, specialised rules. In this way, this rule is decisive for any continuous, non-special text.
2. When the next `.cm-line` is of the `.HyperMD-codeblock` class, a *slightly different* measure is applied as `padding-top`, because `.HyperMD-codeblocks` are rendered with a reduced `font-size`.
3. A `div.HyperMD-header` element adjacent to a `div.HyperMD-header` is selected as a "`div.cm-line` following a `div.HyperMD-header.cm-line`" as well. This, in the first place, establishes by rule (1.) a `padding-top: 1em`. *Here*, this is overridden by the correct, smaller figures, which depend on the *level* of the headline. This rule actually selects `div.HyperMD-header` elements when they follow *any* `.cm-line`, and is therefore slightly more general: It also declares a suitable `padding-top` for a headline following *anything*.
4. When the `.cm-line` is *empty* and does *not* carry the cursor, it will be styled to provide the padding between the headline and the following content. The empty line won't be selected for this rule when the cursor is located inside of it; in this case, it will be styled identically to the case where it is non-empty.

In preview mode, where *margins* can be used to style vertical whitespace, and where no elements corresponding to empty lines exist, the situation is considerably more simple. For headlines, it is sufficient to install vertical `margin` using the figures equivalent to `1em` of continuous text.

Following is a table of headline font sizes and accompanying `padding` or `margin` figures, s.t. the whitespace introduced by these is equivalent to `1em` of continuous text surrounding the headline. Here, the `font-size` figures are those reported by the *inspector* of Obsidian, using the Default theme:

|                                                    | H1       | H2       | H3       | H4       | H5       | H6       |
| -------------------------------------------------- | -------- | -------- | -------- | -------- | -------- | -------- |
| `font-size`                                        | 1.618 em | 1.462 em | 1.318 em | 1.188 em | 1.076 em | 1.000 em |
| `padding` or `margin` $\equiv$ `1em` in cont. text | 0.62 em  | 0.68 em  | 0.76 em  | 0.84 em  | 0.93 em  | 1.00 em  |
## 2.3 Empty Lines
Empty lines do not exist in reading mode, and therefore do not need to be styled in reading mode. In live mode, they are selected as `div.cm-line` elements whose only child is a `br` element:

```css
div.cm-line:has(> br:only-child)
```

An initial rule selecting such empty lines provides them with a `font-size` reduced to a carefully crafted relative fraction, unless they are part of a code block, as blank lines in code blocks shall be shown verbatim.

When placing the cursor in an empty line, the size reduction of the empty line involved shall be revoked. Otherwise the user experience would be impeded: Placing the cursor in an empty lines would lead to a reduced cursor size, until the user starts typing (by which the line would no longer be *empty*). There is one special empty line carrying a reduced size: The empty line preceding a table inevitably, introduced by Obsidian for unknown reason. Here, the `height` of the line is *reduced to zero*: it is truly superfluous. In *this case*, when placing the cursor in such a line, the cursor size shall be reduced, and the zeroed height of the element shall be maintained; the line is not intended as a spacer. The applied `font-size` is of no typographic relevance here; the default style applied to *all* empty lines in the beginning can be reused.

Another case of a special empty line is a blank following a headline. Such empty lines are not made to serve the purpose of an additional vertical spacer. Their are used as a substitute for the padding inserted below the headline:

- Their `font-size` is set to `100%`;
- their `line-height` is specified as `1.0`, to prevent additional vertical whitespace;
- the `padding-top` applied to the *next line* is overridden to 0.

In this way, the vertical space introduced by the blank line is fully equivalent to `1em` of padding.

Reusing a blank line following a headline in this manner has advantages:

1. Traditional themes do not introduce whitespace between any headline and the content following it. When an empty line was written to introduce a separation below a headline, such a blank line is consumed here without vertical impact on the next elements following the headline.
2. Such a blank line can be used to improve rendering of code blocks directly following a headline. Without the blank, the upmost code block line is outfitted by a `padding-top` declaration separating the code block content from the headline by the figure which produces `1em` of continuous text. This amount of padding space however will extend the region of the code block's background, leading to an extension of the background-styled rectangle containing the code lines. By separating such a code block in the markdown code by an empty line from the headline above it, such an extension can be prevented from occuring, improving visual quality. In reading mode, the spacing is provided by *margin*, which isn't coloured by the background colour, and the empty line is of no harmful impact whatsoever.

Using blank lines around code blocks is generally encouraged: The *margin* around code blocks in *reading mode* is styled in such a way, that they correspond to a single line of blank above and below of such a code block in *editing mode*. The blank lines of markdown are not required, but placing them in the markdown code in this way improves readability and brings the live mode closer to the preview mode.
# 3 CSS Variables
## 3.1 Continuous Text
To choose a serif font, the `--font-text` variable is set to `serif` for the `div.markdown-preview-view` (for the preview mode) as well as for the `div.cm-editor` (for the live mode). This suffices in the default theme. However, with kepano's *Minimal* theme, the setting is ineffective in live mode; here, I've added a declaration `font-family: serif` to the `div.cm-editor` rule.

The `--line-height-normal` of the `body` element has been crafted carefully to provide continuous text as a *block*, while at the same time keeping the lines of it well-distanced for lisability.
## 3.2 Code Blocks
The shade of grey used is implemented by setting the `--code-background` variable.

Size of code segment texts, both inline as well as in code blocks, is set by `--code-size`. Inline code sequences in header lines appear as a corner case: These spans are `span.cm-header.cm-inline-code` elements. Here, Obsidian imposes a `font-size: inherit !important` declaration, overriding the non-`!important` styles to implement `--code-size`; this is overridden once more by a `font-size: var(--code-size) !important` declaration in *Typo*.
## 3.3 Blank Lines and Corresponding Margin
*Typo* introduces variables `--font-size-blank-line` and `--margin-blank-line`. Here, the `--font-size-blank-line` is set to a percentage, applied to the `font-size` of blank lines. The measure is designed to provide clear separation of the two lines neighbouring to it, while avoiding the unnecessary spacious separation of a *blank line* in full size. The figure has been determined down to a percent of change. The equivalent of the editing mode `--font-size-blank-line` is the reading mode `--margin-blank-line`. Both shall introduce whitespace of the same amount: `--font-size-blank-line` by being applied to an *entire line*, while `--margin-blank-line` being used as the `margin` property of one of the elements corresponding to the contents preceding/following the empty line. Here, a manual calculation is required to ensure identical rendering of *blank lines* and corresponding *margin*. The height of the empty line is defined by the font size it inherits, reduced by the `--font-size-blank-line` to a certain fraction, while the blank line *also* inherits the `--line-height-normal`, leading to an additional factor when calculating its entire height in `em` of the continuous text. Calling the `--font-size-blank-line` $f$, the `--line-height-normal` $l$, and the resulting *space* $s$, it holds that:$$ s = f \cdot l \cdot \mathrm{1em} $$Thus, the mantissa of the `--margin-blank-line` variable's value, before the unit `em`, is $f \cdot l$.

`--margin-blank-line` is used as vertical margin of `p`, `ol` und `ul`, as well as `pre` HTML elements. The `pre` element in preview mode does not override the `font-size` it inherits: the reduction to `--code-size` is applied to the contained `code` element. Thus, the `--margin-blank-line` can be applied to the `pre` element *directly*.

When in live mode a block of code lines directly follows a headline, the code block lines will implement the padding between the headline and the actual lines of code. These lines carry the reduced `--code-size` measures. To ensure a precise separation by `1em` *of continuous text*, a variable `--code-1em` is used to style the `padding-top` of code block lines directly following a headline. Calling the `--code-1em` variable $c$ and the `--code-size` $i$, it should hold:$$ c \cdot i = \mathrm{1em} $$where $i$ is a given prerequisite, and $c$ needs to be chosen to suffice the equation. In this way, the reduced font size of code blocks is compensated. For instance, when $i = 75\%$, it would suffice to declare $c = \mathrm{1.33\,em}$.

During the tuning phase of writing *Obsidian-Typo*, the measures related to *blank lines* and corresponding *margins* were adjusted in the following order:

1. Optimisation of the line height `--line-height-normal`;
2. Determining the font size of empty lines (stored in `--font-size-blank-line`).

At this point, `--margin-blank-line` can be calculated. After the decision about `--code-size`, the `--code-1em` value can be chosen as well.
## 3.4 Headlines
The sizes of headlines are imposed by setting `--h1-size` .. `--h6-size` to the figures given in the table above (Sect. *Whitespace*).

Furthermore, the weight of all headlines is set to 600 using `--h1-weight` .. `--h6-weight`.

Finally, all headlines are declared to use the *normal* font variant via `--h1-variant` .. `--h6-variant`.
## 3.5 Checklists
The shape of checklist items using the default theme is rectangular with smoothed corners. It is changed to fully circular by declaring `--checkbox-radius: 50%`.

The text of *done* checklist descriptions are decorated in the default theme by a *strike-through* line. This decoration is reverted to `none` by using `--checklist-done-decoration`.
# 4 Limitations
It is not possible to make lines of code overflow horizontally, due to the absence of elements grouping lines together in live mode. As a result, if applying overflow attributes, each line overflows independently. It would be possible to enable overflow properties in preview mode, at the expense of losing symmetry w.r.t. mode change.

The rendering of code blocks directly beneath a headline is degraded slightly by the extension of the first line in the code block using `padding-top`. This rule has been designed for lines below the headline not carrying special background. The imperfection introduced by the `padding-top` declaration can be remedied by placing in the markdown code an *empty line* between the headline and the code block.
# 5 Discussion
Whitespace around the `.inline-title` `div` is introduced by `margin-bottom`. This is different from the use of `padding-top` for any other headline. It can be conceived that the `.inline-title` should adhere to the headline styles, s.t. for `div.inline-title` *no* padding or margin is defined *at all* (as it is the first line of the entire document). Such an approach would require in live mode styles for the first line of the document providing the `1em` spacing. The approach which is implemented only overrides the `padding-top` for the first headline in case it is the first line below the title line. Thus, both ways of providing `1em` of space between the title line and the first headline are roughly equivalent to each other.

Empty lines inherit the `line-height` from the containing element. This complicates the precise determination of the corresponding margin in preview mode around paragraphs, lists and code blocks. It therefore is an option to define the `line-height` of blank lines as `1.0`. Then, a `font-size` slightly larger than the current percentage would be applied to such blank lines, in compensation of the reduction of `line-height`. This choice would render the vertical space introduced by blank lines constant w.r.t. the line height of the surrounding text segments; for some line heights, the visual separation of blocks when inserting a blank line between them might or might not be appropriate anymore.

To provide optimal rendering of code blocks beneath a headline, an empty line separating these two elements is required. This empty line will be *invisible* as long as *Obsidian-Typo* is used for the typography. Normally, headlines do *not* require such empty lines, and are even *designed* to work without such spacer lines. A blank line between a headline and a following code block is not required either by markdown. The blank lines introduced in this case will show in the markdown text as an exception. The decision in favour or in disfavour of inserting them thus is a question of priorisation. For the preview rendering, these blanks are completely insignificant.
# 6 Testing *Obsidian-Typo*
The test to be carried out the most easy and at the same time the most difficult test to pass is the transition between editing mode and reading mode: Here, the typography of the document should change as little as possible when using *Obsidian-Typo*.

When separating a paragraph from the following content by an empty line, i.e. pressing *Enter* twice, the cursor remains always at the full size, while the separating blank line reduces in height after leaving it, s.t. the cursor moves *not a full line* down when Enter is pressed the second time.

Revisiting such empty lines with the cursor temporarily restores their height to the size of a line carrying content. This shifts the following content momentarily a little downwards.

Introducing headlines is possible without intervening blank lines. When entering the leading *hash marks*, whitespace above as well as below is introduced instantaneously. Blank lines above a headline are styled identically to those between e.g. paragraphs.

The cursor moves to the position below a headline when completing the headline by a line feed. Pressing enter *once more* has *no* effect on the displayed text as well as on the cursor position (the additional empty line substitutes the padding between the headline and the cursor line).

When a code block directly follows a headline, the *grey background region* extends up to the headline. This problem can be remedied by placing a blank line in the markdown code between the headline and the code block. When typing this additional empty line, the *position of the code text* is not affected.

Empty lines in code blocks are never reduced in text height.

When obeying the rule to surround lists (enumerations as well as itemisations), paragraphs and code blocks atop and below by an *empty line*, the hereby introduced amount of whitespace corresponds precisely to the whitespace rendered in preview mode.

The special blank line *above tables* can be visited by the cursor using the left/right cursor keys starting from the table or the preceding line of content. When entering this empty line, nothing changes visually, and the cursor line is shown reduced in height. *Typing* here text of any kind to populate this empty line restores the font height to standard size along with the cursor, and the line behaves as a regular content line. In turn a new empty line just above the table will be introduced.