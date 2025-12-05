# 1 Principles
*Obsidian-Typo* follows a few design principles:

1. Typographical whitespace shall be inserted *around headlines* automatically.
2. Whitespace around lists (enumerations and itemsations) should be *encouraged*. As an incentive to adding them, *Obsidian-Typo* renders them in reduced height, and exactly the same amount of white space will be displayed when in reading mode.
3. Whitespace between paragraphs (blocks of text) shall be provided by empty lines, it shall look similar to the whitespace around lists, and it shall be rendered identically both in editing and reading mode (unless multiple blanks are used).
4. The styles shall work also on mobile devices. I am using *Obsidian-Typo* on the iPad and on the desktop (Linux and Windows) to verify functionality.
5. *Obsidian-Typo* shall work with any theme, and shall *only* implement *typesetting*, leaving overall formatting to the theme the user likes best.
6. Moving to using *Obsidian-Typo* shall maintain readability of existing text, s.t. the introduction of *Obsidian-Typo* to an Obsidian vault won't require *any transformation* applied to the vault's contents.

All in all, *Obsidian-Typo* is designed to make it easy writing standard-conformant Markdown code, while still experiencing proper observation of typographical rules. The rendering is almost identical in editing and in reading mode.
# 2 Rendering of Text
*Obsidian-Typo* generally prefers *serif* fonts, both in editing mode as well as in reading mode. This applies to the editing body as well as to the inline title *above* the editing body. Other pieces of the UI are *not* affected.

Continuous text is rendered in *non-justified* manner due to some technical limitations on the iPad.

The font size of `code spans` and of code blocks:
```python
print("Hello World!")
```
is chosen considerably smaller than the continuous text surrounding code listings, to ensure proper visual quality of the results. The shade of grey used for the background colour of inline code is chosen carefully for white text background.
# 3 Whitespace
## 3.1 Paragraphs
In **editing mode**, white space surrounding paragraphs is provided by entering *empty lines*. The *font size* of these lines is reduced to 30%, to limit the visual impact. When the cursor is located directly in such an empty line, the line will be formatted in full size (100%). This results in a slight downward-shift of all elements below that line. The reduction in size of the empty line will be restored when the cursor leaves it.

The blocks of text separated by blank lines form the paragraphs in **reading mode**. Here, the same spacing between such paragraphs is provided as it results from the empty lines in editing mode.
## 3.2 Headlines
Headlines are provided automatically above and below them with 1em of whitespace, measured in em of the continuous text. There is no need for manual blank lines. However, the *Obsidian-Typo* styles are robust against such blank lines:

1. An empty line just *below* a headline will be rendered in such a way that the typographical 1em margin is maintained.
2. Such an empty line can also be placed *in between* of two headlines without impact on the typographical result.
3. Just *above* of a headline, additional blank lines will otherwise be reduced to 30% font-size, so their impact will be little.

This behaviour is implemented not using obscure exeptions and conditions, but is a result of design. However, whitespace around headlines is the most intricate section of the codes in *Obsidian-Typo*.

As a result, existing markdown headlines will format properly with *Obsidian-Typo* in most cases just from the beginning. Before having *Obsidian-Typo* at hand, I found it customary in many places to surround headlines by an empty line below, where I didn't see *any* whitespace before, and then also by a blank line *above*, to prevent the whitespace *above* from being smaller than the one *below*. Such tweaks are not required with *Obsidian-Typo*, but their existence in markdown texts won't disrupt the result when the text will be subjected to *Obsidian-Typo* rendering for the first time.
## 3.3 Tables
In the current version of Obsidian (v1.10.6), tables are inevitably preceded by an empty line. *Obsidian-Typo* limits the effect of this blank line by reducing its height to zero. The *font size* is however set to 30% of the surrounding text. It is still possible to enter this empty line with the cursor; the cursor will be shown with 30% of its default size. This tweak should turn into a no-op automatically when the issue might be fixed upstream.
## 3.4 Enumerations and Itemisations
There is a certain typographic decision which needs to be taken for enumerations (ordered lists) and itemisations (unordered lists):

1. Either whitespace is placed *around* the entire list,
2. or *each list item* is sourrounded by white space, as the complete list.

Furthermore, according to the markdown specification, text directly following an item of the list in the next line belongs to that previous line. This behaviour is useful when list items shall be continued on a new line of the markdown input without further ado. However, Obsidian cannot render this inclusion while in editing mode; it will be performed only when in reading mode.

To meet the markdown specs, a blank line is thus required just beneath the last list element. It is therefore a good idea to place blanks before and after lists already when editing the text. *Obsidian-Typo* does *not* render whitespace around a block of list items in editing mode automatically; instead; it relies on the user to type the required blank line.

In reading mode, corresponding whitespace around the block of list items will be rendered automatically, yielding the same layout as resulting from a *blank line* in editing mode. *Between* list items *no* additional whitespace is produced in reading mode.
# 4 Check List Icons
*Obsidian-Typo* comes with a stylesheet which is a section of kepano's *Minimal* theme, defining various icon names which can be used in checklists.

Different from the default theme, checklist items are provided with a circular shape, as in the *Minimal* theme as well.

The list of icon types is reproduced here:

- [ ] Unchecked
- [x] Checked (`x`)
- [>] Forwarded (`>`)
- [<] Scheduled (`<`)
- [?] Question (`?`)
- [/] Incomplete (`/`)
- [!] Important (`!`)
- ["] Quote (`"`)
- [-] Cancelled (`-`)
- [*] Star (`*`)
- [l] Location (`l`)
- [i] Info (`i`)
- [S] Money (`m`)
- [I] Idea (`I`)
- [f] Fire (`f`)
- [k] Key (`k`)
- [u] Up (`u`)
- [d] Down (`d`)
- [w] Win (`w`)
- [p] Pros (`p`)
- [c] Cons (`c`)
- [b] Bookmark (`b`)