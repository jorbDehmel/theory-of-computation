PRESENTATION_NAMES = advanced_complexity \
	advanced_computability church_turing complexity_intro \
	context_free_grammars finite_acceptors intractability \
	intro nondet_tm pda reducibility regularity space_complexity \
	time_complexity diagonalization pcp th_n
ASSIGNMENTS = docs/final.pdf docs/assignment1.pdf \
	docs/assignment2.pdf docs/assignment3.pdf

PANDOC = pandoc
PRESENTATION_PATHS := $(PRESENTATION_NAMES:%=docs/%.pdf)

.PHONY:	all
all:	$(PRESENTATION_PATHS) $(ASSIGNMENTS)

.PHONY:	check
check:
	@echo "Checking system for validity..."

	@echo "Checking for make..."
	@which make > /dev/null

	@echo "Checking for pandoc..."
	@pandoc --version > /dev/null

	@echo "Checking for texlive..."
	@whereis texlive > /dev/null

	@echo "Checking for graphviz (dot)..."
	@dot -V > /dev/null

	@echo "System is valid!"

docs/%.pdf:	presentations/%.md | images
	@mkdir -p docs
	$(PANDOC) -t beamer $< -o $@

docs/assignment%.pdf:	assignments/assignment%.md | images
	@mkdir -p docs
	$(PANDOC) $< -o $@

docs/final.pdf:	final/main.md | images
	@mkdir -p docs
	$(PANDOC) $< -o $@

.PHONY:	images
images:
	$(MAKE) -C figures

.PHONY:	clean
clean:
	find . -type f \( -iname "*.o" -or -iname "*.out" \) \
		-exec rm -f "{}" \;
	rm -rf docs

################################################################
# Containerization stuff
################################################################

# For absolute path usage later
cwd := $(shell pwd)

.PHONY:	docker
docker:
	docker build --tag 'arbfn' .
	docker run \
		--mount type=bind,source="${cwd}",target="/host" \
		-i \
		-t arbfn:latest \

.PHONY:	podman
podman:
	podman build --tag 'arbfn' .
	podman run \
		--mount type=bind,source="${cwd}",target="/host" \
		-i \
		-t arbfn:latest \
