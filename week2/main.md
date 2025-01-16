
# Week 2: Finite-State Acceptors

Textbook: 1.1 and 1.2

# Definitions

- An **automaton** (plural automata) is a self-moving machine.
    In this context, it just means "small, simple, simulated
    machine".

- An **acceptor** is an automaton which takes in a string and
    either accepts or rejects it through a series of state
    transitions. **Note:** Many texts fail to distinguish
    between *automata* and *acceptors*. Acceptors are a proper
    subset of automata.

- A **finite-state** automaton has a finite number of states
    that it can transition through. Infinite-state automata are
    not used.

- A **deterministic** automaton has exactly one set of state
    transitions which follow from a given string. A
    nondeterministic one, on the other hand, has multiple series
    of state transitions which may follow.

# Kleene operators

- For an alphabet $\Sigma$, the **Kleene star** is an operator
    creating the set of all strings of zero or more characters
- If $\Sigma^i$ is the set of all strings of length $i$ over
    $\Sigma$, then $\Sigma^* = \bigcup_{i = 0}^\infty \Sigma^i$
- Ex:
    $$
    \{ 0, 1 \}^* = \{ \epsilon, 0, 1, 00, 01, 10, 11, \ldots \}
    $$

- The **Kleene plus** gives the set of all strings of *one* or
    more characters over an alphabet. It is less common

$$
\Sigma^* = \Sigma^+ \cup \{ \epsilon \}
$$

# DFAs

- A **deterministic finite-state acceptor (DFA)** is an
    automaton built to accept strings using a finite number of
    states where each string corresponds to exactly one series
    of state transitions. Formally:

**Def:** Finite-state acceptor. A finite acceptor is a 5-tuple
$A = (Q, \Sigma, \delta, q_0, F)$ where:

1) Q is a finite set called the **states**
2) $\Sigma$ is a finite set of symbols called the **alphabet**
3) $\delta : ( Q \times \Sigma ) \to Q$ is the
    **transition function**
4) $q_0 \in Q$ is the **start state**
5) $F \subseteq Q$ is the set of acceptance states

**Note:** A DFA must define all transitions! Every state must
have a specified target state for every character in the
alphabet.

# DFA operation

Consider the DFA $A$ with states $Q = \{ q_0, q_1, q_2 \}$,
starting state $q_0$, alphabet $\Sigma = \{ a, b, c \}$, and
acceptance state set $F = \{ q_2 \}$. The following graph
demonstrates $\delta$.

**Note:** An arrow from nothing means "initial state". In these
diagrams, shading means "accepting state".

![](figures/dfa_ex.png)

This will accept any string of the forms $abc^i$ or $bc^i$,
where $i$ is any nonnegative integer.

# NFAs

- A **nondeterministic finite-state acceptor (NFA)** is a DFA
    that can follow multiple series of state transitions
- The NFA accepts iff any of its branches do
- The only formal difference is in the transition function:
    **$\delta$ can output any number of output states**

**Def:** Nondeterministic finite-state acceptor (NFA). An NFA is
a 5-tuple $A = (Q, \Sigma, \delta, q_0, F)$ where:

1) Q is a finite set called the states
2) $\Sigma$ is a finite set of symbols called the alphabet
3) $\delta : (Q \times \{ \Sigma \cup \epsilon \}) \to \mathcal{P}(Q)$
    is the **nondeterministic transition function**
4) $q_0 \in Q$ is the start state
5) $F \subseteq Q$ is the set of acceptance states

**Note:** If an NFA can leave transitions undefined, unlike a
DFA. If it comes to a fork in the road, it duplicates and goes
down both paths.

# NFA operation

This NFA accepts the same language as our previous DFA:

![](figures/nfa_ex.png)

This NFA has more "weird" branches:

![](figures/nfa_ex_2.png)

# Practice problems

Do these problems on your own, then we will do them on the
board.

1) Does the following DFA accept `fizz`? `foo`? `buzz`?

![](figures/week2_p1.png)

2) Describe the set of all strings accepted by the this NFA.

![](figures/week2_p2.png)

3) Construct an NFA **and** a DFA to recognize the set of all
    strings consisting of repetitions of `abc`.

# DFA-NFA equivalence

- put informal description of proof here

# DFA-NFA equivalence proof pt. 1

- Counterintuitively, **NFA and DFA are equivalent**: Every DFA
    has an equivalent NFA and vice versa. We will prove this in
    two parts below.

**Thm:** All DFA have equivalent NFA. **Pf:** The set of all DFA
is a subset of the set of all NFA. Therefore, all DFA are
trivially NFA. End of proof.

**Thm:** All NFA have equivalent DFA. **Pf:** By construction.
DFA have $\delta_{\texttt{DFA}}: (Q \times \Sigma) \to Q$, while
NFA have
$\delta_{\texttt{NFA}}: (Q \times \{ \Sigma \cup \epsilon \}) \to \mathcal{P}(Q)$.
We will show that all $\delta_{\texttt{NFA}}$ have an equivalent
modification in the form of $\delta_{\texttt{DFA}}$, proving that
all NFA are equivalent to DFA. Let $A$ be an arbitrary NFA
$= (Q, \Sigma, \delta, q_0, F)$.

1) $Q$ vs $\mathcal{P}(Q)$. Since $Q$ is a finite set,
    $\mathcal{P}(Q)$ is a finite set of size $2^{|Q|}$. Any
    finite set can be used as a set of DFA states, so
    $\mathcal{P}(Q)$ works. **Let**
    $Q^\prime = \mathcal{P}(Q)$.

# DFA-NFA equivalence proof pt. 2

2) $\epsilon$ transitions. We must eliminate any nonconsumptive
    transitions in order to be a valid DFA. Let
    $E: Q \to \mathcal{P}(Q)$ be the **$\epsilon$-closure**
    function mapping a state to the set all all states reachable
    by $\epsilon$ transitions from it. Note that
    $E: Q \to Q^\prime$.
    **Let** $\delta^\prime(q, \sigma) = E(\delta_{\texttt{NFA}}(E(q), \sigma))$.
    Note that
    $\delta^\prime : (Q^\prime \times \Sigma) \to Q^\prime$.

3) Starting states. The starting state may have outgoing
    $\epsilon$ transitions which must be accounted for. Thus,
    **let** $q_0^\prime = E(q_0)$.

4) Accepting states. An NFA's $F$ is a subset of the set of its
    states ($F \subset Q$). However, it is not a subset of
    $Q^\prime$ yet: Thus, we must adjust it.
    **Let** $F^\prime = \{ R \in Q^\prime : R \texttt{ contains an accept state from } F \}$.

Now, for an arbitrary NFA $A = (Q, \Sigma, \delta, q_0, F)$, let
$A^\prime = (Q^\prime, \Sigma, \delta^\prime, q_0^\prime, F^\prime)$.
By the above rules, $A^\prime$ is a valid DFA equivalent to $A$.
End of proof.

# The regular operations

# Next up: Regular languages
