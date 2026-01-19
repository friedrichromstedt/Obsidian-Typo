documentation: copy package

copy:
	rsync -rt --delete "Typo-Doc.git/Typo-Doc Vault/" Typo-Doc/

package:
	zip --filesync -r Typo-Doc.zip Typo-Doc
