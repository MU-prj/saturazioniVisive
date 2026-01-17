sync:
	git add .
	git commit -m "."
	git pull --quiet
	git push


.PHONY: sync