
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

\

> "Print the previous with quotes and then without"

> Print the previous with quotes and then without

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
    - Given a proof, we can check if it implies a given
        statement
2. If a statement is provable, it is true

# Gödel pt. 2

**Thm 1:** $Th(\mathcal{N}, +, \times)$ is Turing-recognizable.

**Pf:** Use the implied proof-checker from property 1 to
enumerate the set of all proofs. If a given proof proves the
statement in question, accept. This is a recognizer, but not a
decider. End of proof.

- Corollary: There is an algorithm to decide if a given
    statement is provable. Let this algorithm be called **$P$**

**Lemma 1.1:** $A_{TM}$ is reducible to
$Th(\mathcal{N}, +, \times)$.

**Pf:** You can use $+$ and $\times$ to extract and encode
symbols in very large integers such that they simulate the
evolution of computation histories. Therefore,
$Th(\mathcal{N}, +, \times)$ is Turing-complete and therefore
undecidable.

- Consider encoding a TM in binary, then representing binary as
    a series of additions and multiplications

# Gödel pt. 3

**Thm 2:** Some (true) statement in $Th(\mathcal{N}, +, \times)$
is not provable.

**Pf:** We will assume all true statements are provable and
derive an algorithm to decide $Th(\mathcal{N}, +, \times)$, a
contradiction of lemma 1.1.

Take in some statement $\phi$. Simulate $P$ on both $\phi$ and
$\lnot \phi$. Since a proof exists for $\phi$, one of these two
instances will halt. Therefore, our system decides the truth
value of $\phi$ ($A_{TM}$). Contradiction! End of proof.

# Gödel pt. 4

**Thm 3:** The sentence $\psi_{\texttt{unprovable}}$ = "this
statement has no proof" is true and unprovable.

**Pf:** Let $\phi_{M, w}$ be the statement "TM $M$ accepts input
$w$". This is implied to exist for any TM $M$ and input $w$ by
lemma 1.1.

We will construct the statement "This statement is not provable"
using the recursion theorem.

$S$ = "On any input **(including $0$)**:

1. Obtain own description $\left< S \right>$ via the recursion
    theorem
2. Construct the sentence
    $\psi_{\texttt{unprovable}} = \lnot \exists c [\phi_{S, 0}]$
    using lemma 1.1. ('this TM never accepts 0')
    - If $\psi_{\texttt{unprovable}}$ is true, this TM never
        accepts 0
3. Run $P$ (the theorem prover) on $\psi_{\texttt{unprovable}}$
4. If $P$ accepts (there is a proof for
    $\psi_{\texttt{unprovable}}$), **accept**. If $P$ halts and
    rejects (there is no proof for
    $\psi_{\texttt{unprovable}}$), **reject.**"

# Gödel pt. 5

$$
\begin{aligned}
S &= \begin{cases}
    \texttt{always accept if there is a proof for }
        \psi_{\texttt{unprovable}} \\
    \texttt{reject or loop if there is no proof for }
        \psi_{\texttt{unprovable}} \\
\end{cases} \\
&= \begin{cases}
    \texttt{accept if proof exists that } S
        \texttt{ never accepts } 0 \\
    \texttt{reject or loop otherwise} \\
\end{cases}
\end{aligned}
$$

**Run $S$ on input $0$**

# Gödel pt. 6

$S$ must accept, reject, or loop forever on $0$

- If $S$ accepts $0$, proof exists that $S$ never accepts $0$
    - Since all proven statements are true, this can't happen!
    - Therefore, **this can never be the case**
    - $S$ must reject or loop on $0$

- "$S$ rejects or loops on $0$" is the same as
    $\psi_{\texttt{unprovable}}$
    - Only happens if no proof exists
    - "This statement has no proof"

- $\psi_{\texttt{unprovable}}$ being false causes a
    contradiction
    - Therefore, $\psi_{\texttt{unprovable}}$ must be true

**The statement "this statement has no proof" is true**

# Turing reducibility pt. 1

- Is mapping reducibility the best explanation? **No!**
- Consider: Could we prove that $\overline{A_{TM}}$ is
    undecidable by mapping reducibility?
    - Remember, $\overline{A_{TM}}$ is not Turing-recognizable
    - Therefore, we can't even identify instances of it, let
        along map them!
- However, $\overline{A_{TM}}$ is intuitively reducible to
    $A_{TM}$ and vice versa since a solution to one solves the
    other

- **Solution:** Oracle Turing Machines. An Oracle TM has a
    "magic oracle" decider that it can call without cost at any
    time
    - Assume the "oracle" is magic: It can decide even
        undecidable and unrecognizable languages

# Turing reducibility pt. 2

**Def:** A **TM $M$** with access to a decider for
**language $B$** is written $M^B$.

- Ex: A TM $T$ with access to a decider for $A_{TM}$ would be
    written $T^{A_{TM}}$

**Def:** If $M^B$ decides $A$, we say $A$ is
**decidable relative** to $B$.
    - Given a decider for $B$, we can decide $A$

- **Much more intuitive than mapping reducibility**

**Def:** If $A$ is decidable relative to $B$, then $A$ is
**Turing reducible** to $B$, written $A \le_T B$.

# Ex: $E_{TM} \le_T A_{TM}$

**Thm:** $E_{TM} \le_T A_{TM}$ ("given a decider for $A_{TM}$,
we can decide $E_{TM}$")

**Pf:** By construction. Let `accepts(M, w)` be the oracle
procedure deciding $A_{TM}$.

```python
def is_empty(M):        # Decides emptiness problem
  def T(_):             # Define a helper TM T
    for every string s: # Enumerate every possible string
      if accepts(M, s): # If M accepts this random string
        accept
  if accepts(T, ''):    # T is empty iff not M(s)
    reject
  else:
    accept
```

This decides $A_{TM}$. End of proof.

# Ex: $A_{TM} \le_T E_{TM}$

**Thm:** $A_{TM} \le_T E_{TM}$ ("given a decider for $E_{TM}$,
we can decide $A_{TM}$")

**Pf:** By construction. Let $is_empty(M)$ be an **oracle** (not
the fn from the previous: That would be circular).

```python
def accepts(M, w): # Decides acceptance problem
  def T(x):        # Helper TM
    if x == w:
      if M(w):     # Simulates M on w
        accept
    reject         # Rejects all non-w
  if is_empty(T):  # Is empty iff M rejects w
    reject
  else:
    accept         # Nonempty iff M accepts w
```

This decides $A_{TM}$. End of proof.

# The *other* meaning of Turing-Equivalence

- $E_{TM} \le_T A_{TM}$ **and** $A_{TM} \le_T E_{TM}$
- In this case we say that $E_{TM}$ and $A_{TM}$ are
    **Turing-equivalent**
- Written $E_{TM} \equiv_T A_{TM}$

This is an **equivalence relation**

Not to be confused with the Turing-equivalence of a system $S$,
where a TM can simulate $S$ and vice versa.

# A definition of information

- There is no singular definition of information
- *One* definition is the size of the minimal representation

$$
\begin{aligned}
    A = \texttt{10101010101010101010} \\
    B = \texttt{10111001011111101000}
\end{aligned}
$$

- $A$ is just `01` 10 times
- $B$ has "more information" than $A$, since it doesn't appear
    to follow a pattern

**Def:** Minimal descriptions. Let $x$ be a binary string. The
**minimal description** of $x$, written $d(x)$, is the shortest
string $\left< M, w \right>$ where TM $M$ on input $w$ halts
with $x$ on its tape. The **descriptive complexity** of $x$,
written $K(x)$, is

$$
K(x) = |d(x)|
$$

**Note:** $x$'s descriptive complexity **is not** its length! It
can be **longer!**

# Compression

- $K(x)$ might be longer than $x$
- If it's shorter, we can treat it as the compressed version,
    running $M$ on $w$ to uncompress it

**Def:** Let $x$ be a string. $x$ is said to be
**$c$-compressible** for some natural number $c$ if

$$
K(x) \le |x| - c
$$

That is, if $|\left< M, w \right>| \le |x| - c$ for minimal
$\left< M, w \right>$.

If $x$ is not compressible by $1$, we say it is
**incompressible**.

# Incompressible strings

**Thm:** There are incompressible strings of every length.

**Pf:** If a string $x$ is compressible, there exists a
description $d(x)$ such that $|d(x)| < |x|$. Let $n$ be any
arbitrary integer.

There are $2^n$ binary string of length $n$: However, there are
only $\sum_{i = 1}^{n - 1} 2^i = 2^n - 1$ descriptions of length
$< n$. Therefore, there must exist at least one incompressible
string of length $n$. End of proof.

# What do incompressible strings look like?

- It can be shown that incompressible strings look like series
    of random coin tosses
- $K$ is **incomputable**, so no examples exist
- If we had an example, we couldn't prove it was incompressable

# Next up: Intro to complexity and asymptotic analysis

**End of part 2 out of 3!**

![](figures/asymptotes.png)
