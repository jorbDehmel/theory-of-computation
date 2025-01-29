/**
 * @file dfa.cpp
 * @brief An example implementing DFAs
 */

#include <cstdint>
#include <iostream>
#include <map>
#include <string>

template <typename State, typename Input> struct DFA {
  State state;
  std::map<State, std::map<Input, State>> delta;

  State operator()(const Input &_inp) {
    state = delta.at(state).at(_inp);
    return state;
  }
  State operator()() const noexcept { return state; }
};

int main() {
  DFA<uint8_t, char> dfa;
  std::string input;
  const uint8_t start_state = 0;
  const uint8_t accept_state = 2;

  // Program DFA
  dfa.state = start_state;
  dfa.delta = {{start_state,
                {
                    {'a', start_state},
                    {'b', 1},
                    {'c', 1},
                }},
               {1,
                {
                    {'a', start_state},
                    {'b', 1},
                    {'c', accept_state},
                }},
               {accept_state,
                {
                    {'a', accept_state},
                    {'b', start_state},
                    {'c', accept_state},
                }}};

  // Simulate on some input
  std::cout << "Enter input: ";
  std::cin >> input;

  for (const char &c : input) {
    dfa(c);
  }

  std::cout << "Final state: " << (int)dfa() << '\n';

  return 0;
}
