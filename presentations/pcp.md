
# Post's Correspondence Problem (PCP)

Textbook: Chapter 5.2

# Intro

- Imagine we have some set of dominos, each with a top and
    bottom section
- We want to arrange them (repetition allowed) so that the top
    and bottom match when read left to right

$$
\begin{aligned}
    \left\{ \left[
        \frac{ab}{a}
    \right],
    \left[
        \frac{c}{bc}
    \right] \right\} \\
    \left[
        \frac{ab}{a}
    \right]
    \left[
        \frac{c}{bc}
    \right]
    \to
    \frac{abc}{abc}
\end{aligned}
$$

- Some sets of dominos have possible matches, and some don't

**Def.** Post's Correspondence Problem. Does a given set of
dominos have a possible match?

As a language:

$$
PCP = \{ w: w \texttt{ encodes a set of dominos which match } \}
$$

# Undecidability

**Thm.** $PCP$ is undecidable.

**Pf.** By reduction from the decision problem $A_{TM}$. We will
assume $PCP$ is decidable and show that this implies $A_{TM}$ is
decidable (a contradiction).

- We can construct an instance of $PCP$ which simulates a TM
    - Can design it so it matches iff the TM accepts
- Therefore a $PCP$ decider would decide $A_{TM}$

# Next up: Nondeterministic Turing Machines
