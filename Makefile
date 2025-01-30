PRESENTATION_NAMES = advanced_complexity \
	advanced_computability church_turing complexity_intro \
	context_free_grammars finite_acceptors intractability \
	intro lambda_calc nondet_tm pda reducibility regularity \
	space_complexity time_complexity diagonalization
ASSIGNMENTS = docs/final.pdf

PANDOC = pandoc
PRESENTATION_PATHS := $(PRESENTATION_NAMES:%=docs/%.pdf)

.PHONY:	all
all:	$(PRESENTATION_PATHS) $(ASSIGNMENTS)

.PHONY:	check
check:
	@echo "Checking system for validity..."

	@echo "Checking for pandoc..."
	@pandoc --version > /dev/null

	@echo "Checking for graphviz (dot)..."
	@dot -V > /dev/null

	@echo "System is valid!"

docs/%.pdf:	presentations/%.md | images
	@mkdir -p docs
	$(PANDOC) -t beamer $< -o $@

docs/assignment%.pdf:	assignment%/main.md | images
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
