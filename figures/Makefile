IMAGES := dfa_ex.png nfa_ex.png nfa_ex_2.png week2_p1.png \
	week2_p2.png

.PHONY:	all
all:	$(IMAGES)

%.png:	%.dot
	dot -Tpng -o $@ $<
