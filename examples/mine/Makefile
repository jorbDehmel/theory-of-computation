TARGETS := dfa.out nfa.out
CPP := g++ -std=c++20 -pedantic -Wall -g -O3

.PHONY:	all
all:	$(TARGETS)

%.out:	%.o
	$(CPP) -o $@ $<

%.o:	%.cpp
	$(CPP) -c -o $@ $<

.PHONY:	clean
clean:
	rm -f *.o *.out
