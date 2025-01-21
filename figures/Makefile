IMAGES := dfa_ex.png nfa_ex.png nfa_ex_2.png week2_p1.png \
	week2_p2.png nfa_union_closure.png nfa_concat_closure.png \
	nfa_star_closure.png regex1.png regex2.png regex3.png \
	regex4.png regex5.png regex6.png gnfa.png

.PHONY:	all
all:	$(IMAGES)

%.png:	%.dot
	dot -Tpng -o $@ $<
