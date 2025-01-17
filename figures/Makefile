IMAGES := dfa_ex.png nfa_ex.png nfa_ex_2.png week2_p1.png \
	week2_p2.png nfa_union_closure.png nfa_concat_closure.png \
	nfa_star_closure.png

.PHONY:	all
all:	$(IMAGES)

%.png:	%.dot
	dot -Tpng -o $@ $<
