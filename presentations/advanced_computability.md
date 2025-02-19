
# Advanced computability theory

Textbook: Chapter 6

# Quines

- A **Quine** is a self-producing program
- A Quine takes no input (files, command-line, cin, etc) and
    outputs only its own source code

In `C`:

```c
/* (formatted to fit on slide) */
char*s="char*s=%c%s%c;main(){printf(s,34,s,34);}";
main(){printf(s,34,s,34);}
```

In English:

> Print out this sentence.

**Can we build a TM to do this?**

# Kleene's Recursion Theorem

- By the same Kleene from section 1
- Allows any TM $M$ to access its own description
    $\left<M\right>$

The idea:

> "Print the previous twice: First with quotes and then without"
> Print the previous twice: First with quotes and then without

# Kleene Recursion pt. 2

**Lemma:** Computable printing. There exists a computable
function $q: \Sigma^* \to \Sigma^*$ where, for any string $w$,
$q(w)$ is the description of a Turing machine $P_w$ that prints
out $w$ and then halts.

**Pf:** The following TM $Q$ computes $q(w)$.

$Q$ = "On input string $w$:

1. Construct the following TM $P_w$:
    $P_w$ = "On any input:
    1. Erase input
    2. Write $w$ on the tape
    3. Halt."

2. Output $\left< P_w \right>$."

# The TM $SELF$

- $SELF$ will be a Quine TM
- We will make it 2 parts: $A$ and $B$
    - $\left< SELF \right> = \left< AB \right>$
- $A$ will print out $\left< B \right>$ and $B$ will print out
    $\left< A \right>$
- $A$ is easy! Just use $q(\left< B \right>)$
    - **$A$ leaves $\left< B \right>$ on the tape**

- **How do we create $B$?**
    - We can't use $q$, or we would get a circulate definition!
- $B$ can look at the contents of the tape as its input
- We already know $\left<A\right> = q(\left<B\right>)$, so we
    can compute $\left<A\right>$ given only $\left<B\right>$

# $SELF$ pt. 2

$B$ = "On input $\left<M\right>$:

1. Compute $q(\left< M \right>)$ (the description of a TM that
    prints out the description of $M$)
2. Erase the tape
3. Write $q(\left< M \right>) \left< M \right>$"

$\left< SELF \right> = q(\left< B \right>) \left< B \right>$

# Running $SELF$

- What happens if we run $SELF$?

1. Start with some input tape
2. Start running the TM $q(\left< B \right>)$
    1. Erases tape
    2. Writes $\left< B \right>$
    3. Halts
3. Start running the TM $B$ on the contents of the tape
    1. The input $\left< M \right>$ is $\left< B \right>$!
    2. Computes $q(\left< B \right>)$
    3. Erases the tape
    4. Writes $q(\left< B \right>) \left< B \right>$
    5. Halts
4. Halts

- The contents of the tape are now
    $q(\left< B \right>) \left< B \right> = \left< SELF \right>$
- **Self takes any input and prints its own description**

# Recursion theorem

**Def:** Kleene's recursion theorem. Let $T$ be a TM that
computes a function $t: \Sigma^* \times \Sigma^* \to \Sigma^*$.
There is a TM $R$ that computes some $r: \Sigma^* \to \Sigma^*$
where, for every $w$,

$$
r(w) = t \left( \left< R \right>, w \right)
$$

- **A TM can always obtain its own description!**

# Recursion theorem pf

- Let $\left< R \right> = \left< ABT \right>$

$A$ = "On input $w$:

1. Compute $q(\left< BT \right>)$
2. Erase tape
3. Write $q(\left< BT \right>) w$"

$B$ = "On input $q(\left< MH \right>) w$:

1. Create the TM $N$:

    $N$ = "On input $w$:

    1. Compute $q(\left< MH \right>)$
    2. Erase tape
    3. Write $q(\left< MH \right>) w$"

2. Let $\left< R \right> = \left< NMH \right>$
3. Simulate $H$ on input $\left< R, w \right>$"

# The Minimality problem

**Def:** For a TM $M$, $M$ is **minimal** if there exist no TMs
equivalent to $M$ with a smaller description. Let

$$
MIN_{TM} = \left\{ M : M \texttt{ is a minimal TM} \right\}
$$

**Thm:** $MIN_{TM}$ is not Turing-recognizable.

# The Minimality problem pt. 2

**Pf:** We will assume some enumerator $E$ for $MIN_{TM}$ exists
and obtain a contradiction.

$C$ = "On input $w$:

1. Obtain, via the recursion theorem, own description
    $\left< C \right>$
2. Run $E$ until it yields a TM $D$ such that
    $|\left< C \right>| < |\left< D \right>|$. Since $MIN_{TM}$
    is infinite, this is guaranteed to happen
3. Simulate $D$ on input $w$."

All items yielded by $E$ are definitionally in $MIN_{TM}$.
However, $C$ simulates $D$ and is thus equivalent to it. We know
$C$ is shorter than $D$, but $D$ is minimal: **Contradiction**.

# Decidability of logical theories

**Is logic decidable?** Given some statement, can we every know
whether or not it is true?

Three logic problems of increasing difficulty:

1. $\forall q \exists p \forall x, y \left[ p > q \land (x, y > 1 \to xy \ne p) \right]$
    - (Infinitely many primes exist: Proven by Euclid)
2. $\forall a, b, c, n \left[ (a, b, c > 0 \land n > 2) \to a^n + b^n \ne c^n \right]$
    - (Fermat's last theorem: Only recently proven)
3. $\forall q \exists p \forall x, y \left[ p > q \land (x, y > 1 \to (xy \ne p \land xy \ne p + 2)) \right]$
    - (Twin prime conjecture: Unproven)

# Formal definition of logic

Let the alphabet of logic be:

$$
\left\{
    \land, \lor, \lnot, (, ), \forall, x, \exists, R_1, \cdots,
    R_k
\right\}
$$

- $\land, \lor,$ and $\lnot$ are **Boolean operations**
- "(" and ")" are the **parenthesis**
- $\forall$ and $\exists$ are the **quantifiers**
- $x$ represents the infinite sets of **variables**
- $R_1, \cdots, R_k$ denote **relations**

**Def:** A string $\phi$ is a **formula** if:

1. $\phi$ has the form $R_i(x_1, \ldots, x_j)$ **or**
2. $\phi$ has the form $\phi_1 \land \phi_2$ or
    $\phi_1 \lor \phi_2$ or $\lnot \phi_1$, where $\phi_1$ and
    $\phi_2$ are formulas **or**
3. $\phi$ has the form $\exists x_i ( \phi_1 )$ or
    $\forall x_i ( \phi_1 )$, where $\phi_1$ is a formula

# Mathematical models and theories

- A formula is in **prenex normal form** iff all quantifiers
    occur at the beginning
- An unquantified variable is called a **free variable**
- A formula with no free variables is called a **sentence** or
    **statement**
- The **universe** is the set of values that variables may take
- A **model** $\mathcal{M}$ is a tuple $(U, P_1, \ldots, P_k)$,
    where $U$ is the universe and $P_1, \ldots, P_k$ are the
    relations assigned to symbols $R_1$ through $R_k$
- The **theory of $\mathcal{M}$**, written $Th(\mathcal{M})$, is
    the set of all true sentences on model $\mathcal{M}$

**Ex:** $(\mathcal{N}, +, \times)$ is a model where variables
can take any value $\in \mathcal{N}$ and the relations $+$ and
$\times$ can be used. Note: $+$ corresponds to a relation
$R_+(x_1, x_2, x_3) \iff (x_1 + x_2 = x_3)$, with a similar
relation for $\times$.

# Proving Gödel's incompleteness theorem

**Def:** Formal proof. The **formal proof** $\pi$ of a statement
$\phi$ uis a sequence of statements $S_1, S_2, \ldots, S_l$
where $S_l = \phi$. Each statement must follow simply and
directly from the previous statements.

Assume the following are true:

1. The correctness of a proof of a statement can be checked by
    a machine. Formally,
    $\{\left<\phi, \pi\right>:\pi\texttt{ is a proof of }\phi\}$
    is decidable
2. If a statement is provable, it is true

# Gödel pt. 2

**Thm 1:** $Th(\mathcal{N}, +, \times)$ is Turing-recognizable.

**Pf:** Use the implied proof-checker from property 1 to
enumerate the set of all proofs. If a given proof proves the
statement in question, accept. This is a recognizer, but not a
decider. End of proof.

**Lemma 1.1:** $A_{TM}$ is reducible to
$Th(\mathcal{N}, +, \times)$.

**Pf:** You can use $+$ and $\times$ to extract and encode
symbols in very large integers such that they simulate the
evolution of computation histories. Therefore,
$Th(\mathcal{N}, +, \times)$ is Turing-complete and therefore
undecidable.

Note: The Church-Turing thesis suggests that
$Th(\mathcal{N}, +, \times)$ is Turing-equivalent.

# Gödel pt. 3

**Thm 2:** Some (true) statement in $Th(\mathcal{N}, +, \times)$
is not provable.

**Pf:** We will assume all true statements are provable and
derive an algorithm to decide $Th(\mathcal{N}, +, \times)$, a
contradiction of lemma 1.1.

Take in some statement $\phi$. Simulate the algorithm from
theorem 1 on both $\phi$ and $\lnot \phi$. Since a proof exists
for $\phi$, one of these two instances will halt. Therefore, our
system decides the truth value of $\phi$. Contradiction!

End of proof.

# Gödel pt. 4

**Thm 3:** The sentence $\psi_{\texttt{unprovable}}$, as
described in the proof, is unprovable.

**Pf:** Let $\phi_{M, w}$ be the statement "TM $M$ accepts input
$w$". This is implied to exist for any TM $M$ and input $w$ by
lemma 1.1.

We will construct the statement "This statement is not provable"
using the recursion theorem.

$S$ = "On any input:

1. Obtain own description $\left< S \right>$ via the recursion
    theorem
2. Construct the sentence
    $\psi_{\texttt{unprovable}} = \lnot \exists c [\psi_{S, 0}]$
    using lemma 1.1. ('there is no input for which this TM
    accepts')
3.
4. "

# Turing reducibility

# A definition of information

# Proving compression minimality

# Incompressible strings

# Next up: Intro to complexity and asymptotic analysis

**End of part 2 out of 3!**
