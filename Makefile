PRESENTATIONS = docs/week1.pdf

.PHONY:	test
test:	check

.PHONY:	check
check:
	@echo "Checking system for validity..."

	@echo "Checking for clang-format..."
	@clang-format --version > /dev/null

	@echo "Checking for pandoc..."
	@pandoc --version > /dev/null

	@echo "System is valid!"

.PHONY:	all
all:	$(PRESENTATIONS)

docs/%.pdf:	%/main.md
	@mkdir -p docs
	pandoc -t beamer $< -o $@

.PHONY:	format
format:
	find . -type f \( -iname "*.cpp" -or -iname "*.hpp" \) \
		-exec clang-format -i "{}" \;

.PHONY:	clean
clean:
	find . -type f \( -iname "*.o" -or -iname "*.out" \) \
		-exec rm -f "{}" \;
