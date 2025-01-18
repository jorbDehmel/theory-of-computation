PRESENTATIONS = docs/week1.pdf docs/week2.pdf docs/week3.pdf \
	docs/week4.pdf docs/week5.pdf docs/week6.pdf \
	docs/week7.pdf docs/week8.pdf docs/week9.pdf \
	docs/week10.pdf docs/week11.pdf docs/week12.pdf \
	docs/week13.pdf docs/week14.pdf

ASSIGNMENTS = docs/assignment1.pdf docs/assignment2.pdf \
	docs/assignment3.pdf docs/final.pdf
PANDOC = pandoc

.PHONY:	test
test:	check

.PHONY:	check
check:
	@echo "Checking system for validity..."

	@echo "Checking for clang-format..."
	@clang-format --version > /dev/null

	@echo "Checking for pandoc..."
	@pandoc --version > /dev/null

	@echo "Checking for graphviz (dot)..."
	@dot -V > /dev/null

	@echo "System is valid!"

.PHONY:	all
all:	$(PRESENTATIONS) $(ASSIGNMENTS)

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

.PHONY:	format
format:
	find . -type f \( -iname "*.cpp" -or -iname "*.hpp" \) \
		-exec clang-format -i "{}" \;

.PHONY:	clean
clean:
	find . -type f \( -iname "*.o" -or -iname "*.out" \) \
		-exec rm -f "{}" \;
	rm -rf docs
