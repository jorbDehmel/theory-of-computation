/**
 * @file nfa.cpp
 * @brief An example implementing NFAs
 */

#include <cstdint>
#include <iostream>
#include <map>
#include <queue>
#include <set>
#include <string>

template <typename State, typename Input> struct NFA {
  std::set<State> states;
  std::map<State, std::map<Input, std::set<State>>> delta;
  std::map<State, std::set<State>> outgoing_epsilons;

  /// Runs in time $\le 2^{|Q|}$
  void operator()(const Input &_inp) {
    std::queue<State> to_visit;

    // Handle normal transitions
    for (const auto &s : states) {
      const auto n = delta[s][_inp];
      for (const auto &substate : n) {
        to_visit.push(substate);
      }
    }
    states.clear();

    // Handle epsilons
    while (!to_visit.empty()) {
      const auto c = to_visit.front();
      to_visit.pop();

      if (states.contains(c)) {
        continue;
      }
      states.insert(c);

      if (outgoing_epsilons.contains(c)) {
        const auto n = outgoing_epsilons.at(c);
        for (const auto &substate : n) {
          to_visit.push(substate);
        }
      }
    }
  }

  std::set<State> operator()() const noexcept { return states; }
};

int main() {
  // Construct
  NFA<uint8_t, char> nfa;

  nfa.states = {1};
  nfa.delta = {
      {1, {{'a', {2, 3}}}},
      {3, {{'c', {5}}}},
      {4, {{'d', {2, 4, 5}}}},
  };
  nfa.outgoing_epsilons = {
      {2, {4}},
      {3, {5}},
  };

  // Simulate on some input
  std::string input;
  std::cout << "Enter input: ";
  std::cin >> input;

  for (const char &c : input) {
    nfa(c);
  }

  const auto final_states = nfa();
  bool first = true;

  std::cout << "Final states: {";
  for (const auto &s : final_states) {
    if (first) {
      first = false;
    } else {
      std::cout << ", ";
    }
    std::cout << (int)s;
  }
  std::cout << "}\n";

  return 0;
}
