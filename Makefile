LZ_DIR=/Users/pavel/code/src/github.com/novoid/lazyblorg
build:
	mkdir -p target
	PYTHONPATH="$(LZ_DIR):" \
	python3 $(LZ_DIR)/lazyblorg.py \
	   --targetdir target \
	   --previous-metadata ./target/previous-metadata.pk \
	   --new-metadata ./target/current-metadata.pk \
	   --logfile ./target/logfile.org \
	   --orgfiles Pavels-Emacs-Configuration.org \
	              templates.org \
	              /Users/pavel/Documents/Notes/pavel.org
