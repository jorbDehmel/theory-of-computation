
# Intractability

Textbook: Chapter 9

# Tractability vs. Intractability

**Def:** A language $A$ is **tractable** ("realistically"
solvable) if $A \in P$. It is **intractable** (theoretically
solvable, but not in "realistic" time) if $A \notin P$.

- In reality, there are plenty of language $\in P$ that are
    infeasible to decide IRL: $O(n^{999999})$ is technically
    "tractable"

![](figures/intractable.png)

- Exponential cost will eventually overtake **any** polynomial

# Space Constructability

- Recall: A function runs with deterministic **space**
    complexity $O(f(n))$ if it uses space $f(n)$ on input length
    $n$
- **Def:** A function $f$ is **space-constructable** if a TM can
    map any string of length $x$ to $f(x)$ in space $O(f(x))$
- Space-constructable function examples
    - $\lg(n)$
    - $n \lg(n)$
    - $n^2$

# Space Hierarchy Theorems

- Clearly, $SPACE(n) \subseteq SPACE(n^2)$ since $n$ is $O(n^2)$
- How can we prove that two space complexity classes are
    different, e.g. $SPACE(n) \subsetneq SPACE(n^2)$?

**Thm:** Space hierarchy theorem. For any space-constructable
$f$, a language $A$ exists that is decidable in $O(f(n))$ space
but **not** in $o(f(n))$ space.

- $A$ is decidable with space bounded by $f(n)$, but cannot be
    decided with space insignificant to $f(n)$

**Corollary:** For any nonnegative integers
$\epsilon_1, epsilon_2$ where $0 \le \epsilon_1 < \epsilon_2$,

$$
SPACE(n^{\epsilon_1}) \subsetneq SPACE(n^{\epsilon_2})
$$

- Finally, a proper hierarchy! This is very useful!

# Space Hierarchy Proof

# Time Constructability

- Time complexities give us a lot more trouble than space ones
- If we could prove that $P \subsetneq NP$ like we can prove
    $PSPACE = NPSPACE$, we could settle the $P$/$NP$ debate
- Thus, we try to do the same with time

**Def:** A function $t$ where $t(n)$ is at least $O(n \log n)$
is called **time constructible** if a TM can map input of length
$n$ to $t(n)$ in deterministic time $O(t(n))$.

- Examples: $n \log n$, $n \sqrt{n}$, $n^2$, $2^n$

# Time Hierarchy Theorems

**Thm:** Time hierarchy theorem. For any time constructible
function $t$, a language $A$ exists that is decidable in
$O(t(n))$ time but not in time

$$
o \left( \frac{t(n)}{\log t(n)} \right)
$$

- Subtly different, and therefore less strong!

**Corollary:** For functions $t_1, t_2$ where $t_2$ is time
constructable and $t_1$ is
$o \left( \frac{t_2(n)}{\log t_2(n)} \right)$,

$$
TIME(t_1(n)) \subsetneq TIME(t_2(n))
$$

# Time Hierarchy Proof

# $EXPSPACE$-Completeness

- Recall: $EXPSPACE$ is the set of all problems solvable given
    exponential space
- $EXPSPACE = \bigcup_{k} SPACE( a^{n^k} )$

# Relativization

# Circuit Complexity

# Next up: Advanced Complexity Analysis
