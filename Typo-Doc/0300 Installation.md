# 1 Contents of the Repository
After having downloaded the main Git repo of *Obsidian-Typo*, the repository contains the following items:

- The folder `CSS` contains the CSS codes which constitute *Obsidian-Typo*.
- The `other` folder holds material I used during developing *Obsidian-Typo*, either work by *other* people or content created with *other* people's tools.
- In `Typo-Doc` this documentation is provided.

The CSS snippets needed to be installed to your Obsidian vault are those provided by the `CSS` folder:

- `Core-Typo.css` contains all the required styles to begin formatting with typographic pleasure.
- `Checklist-Typo.css` provides *in addition* the checklist icons provided by @kepano part of his *Minimal* theme.
- `Code-Background-Typo.css` installs *Obsidian-Typo's* choice of background for code sequences.
- `Hyperlink-Typo.css` prevents markdown links to be formatted with the *underline* text-decoration as it is present in the default theme.
- `Serif-Typo.css` performs the transition to serif font for the document editing/display pane.
# 3 Procedure of Installation
The installation consists of two steps:

1. Copying the CSS `.css` files from the `CSS` folder in *Obsidian-Typo's* repo to a folder where *Obsidian* expects user-supplied snippets to be provided. The method depends on the operating system, and is described for the macOS and for the iOS/iPadOS-version in detail *below*, together with some hints for Windows users and for the situation on Linux.
2. In the *Appearance* settings tab of Obsidian, the snippets just copied over need to be *enabled*. The corresponding settings are located at the bottom end of the *Appearance* pane.

After installation, *Obsidian-Typo* will start carrying out its typographic work.

If ever deciding to not using *Obsidian-Typo* any longer, either the the corresponding CSS snippets can be *disabled* in the *Appearance* pane or the respective files can be directly *removed*.

Changing to another revision of *Obsidian-Typo* is accomplished by just replacing the existing files by the other varaint. Obsidian will automatically reformat the documents.

Notice that with ongoing work on *Obsidian-Typo*, it *might* happen that existing CSS snippets are renamed, split, united or removed. In this case, such changes need to be carried out when maintaining the `.obsidian/snippets/` folder.
## 3.1 Copying over the Snippets in macOS
There are at least two different options to copy over the snippets on macOS:

- Graphically by using the Finder;
- via the Terminal.
### 3.1.1 Using the Finder
1. While in the vault folder, press Cmd + Shift + G or choose "Go To > Go To Folder" (or similar) from the menu. Then enter `.obsidian` and commence the dialog. You should now see the hidden folder in light colour.
2. Navigate to the `snippets` folder inside of the `.obsidian` folder. If it doesn't exist, create it first.
3. Place the CSS snippets by copying them over from the git repo of *Obsidian-Typo*.
### 3.1.2 Using the Terminal
1. Reveal the Obsidian vault folder in Finder.
2. Open a Terminal window.
3. Start by typing `cd`, space, and "copy" over the vault folder from the Finder window to the Terminal window by dragging it with the mouse cursor. After releasing the folder *on the Terminal*, its path in the filesystem will be appended to the command line, forming a complete `$ cd <Vault Folder>` command, which you can execute.
4. Now, use `$ cd .obsidian` to enter the vault configuration folder.
5. Ensure that the `snippets` folder exists, creating it when necessary; move into it and use `cp` to copy the CSS snippets from the git repo of *Obsidian-Typo* into that folder.
## 3.2 Copying Procedure for iOS or iPadOS
The Apple iOS and iPadOS apps as well as the iCloud service are all reluctant to provide access to the `.obsidian` folder. The only way to modify CSS snippets on the iPad I could figure out uses the iCloud Drive to expose an iCloud-based Obsidian vault to the macOS desktop:

1. Provide an iCloud-based vault. It is also possible to copy over an existing non-iCloud vault to Obsidian's folder in iCloud using the *Files* app from i(Pad)OS.
2. Make sure you see the Obsidian folder in the iCloud drive on your Macintosh.
3. Locate the folder of the Obsidian vault you want to provide with the snippets in the iCloud drive on the Mac.
4. Apply the same methodology as you would use for a vault stored locally on the Mac.
## 3.3 Things Which *Don't* Work With Apple Software
1. You cannot accesss the `.obsidian` folder by the iOS Files application.
2. When copying or moving a folder into a different location, by any means, it will *replace* any existing folder *completely* and won't just change or add new files.
3. You cannot replace the `.obsidian` folder separately by using iTunes-based file exchange with the Obsidian app installed on the iOS device.
4. I didn't find an Obsidian plugin to manually copy over a CSS snippet. There are some ways of creating and editing them, but I didn't spot a way to *copy files*. I also couldn't figure out an alternative to Apple's Files app, to get access to dot-directories like `.obsidian`.
5. I've tried to work with the Google Drive app by copying over the vault in question using Files to the Google Drive, and attempting to copy it back after modification. While the first step was successfully carried out, the second one was not, with an error message about some failed communication with a helper program. This error did not show up when the vault folder on Google Drive did not contain the `.obsidian` folder.
6. There's no way to copy over symblic links, so this isn't an option to peek into the `.obsidian` folder from the Files app or similar.
7. An iCloud-based Obsidian vault can, in principle, be accessed by the iCloud Drive web interface, however, here's also no possibility e.g. to create dot-folders like `.obsidian`, with the hint that such names would be reserved for the operating system.
8. In the iCloud Drive folder on the Macintosh it is furthermore *impossible* to *create* folders like `.obsidian`. Luckily in our case this folder already exists, so that in this way the iCloud Drive can be used to surgically modify the vault, as described in the previous section.
## 3.4 Windows
On Windows, the situation is similar to the macOS one: *Either* you use the Explorer, *or* some program providing a terminal. There exist *two* terminals built-in to Windows: The `cmd` program and PowerShell. But any other terminal will do as well; personally, I am using the Cygwin Terminal.

In the Explorer, the `.obsidian` folder can be revealed by:

1. Moving into the vault folder;
2. clicking into the address bar, either at its left or the right side (avoiding the section consisting of buttons);
3. appending `\.obsidian` to the "address", and pressing enter.

Now, the internals of the `.obsidian` folder are accessible. Copy over files as needed.
## 3.5 Linux
On Linux, there is no definite default program for file and terminal access. It depends on your distro and your general preference which tools you can use. In general, here as well the distinction between graphical filesystem access programs and access via some command line is decisive, but there exists a multitude of applications for either case.