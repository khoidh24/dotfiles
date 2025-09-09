"use strict";

module.exports = {
  types: [
    {
      value: "feat",
      name: "[feat]:     ✨  A new feature (something new for users)",
    },
    {
      value: "fix",
      name: "[fix]:      🐞  A bug fix (something was broken, now it works)",
    },
    {
      value: "docs",
      name: "[docs]:     📚  Documentation changes only (README, guides...)",
    },
    {
      value: "style",
      name: "[style]:    💅  Code style changes (formatting, no logic impact)",
    },
    {
      value: "refactor",
      name: "[refactor]: ♻️   Code refactor (improving structure, no new feature)",
    },
    {
      value: "perf",
      name: "[perf]:     ⚡  Performance improvements (make it faster, lighter)",
    },
    { value: "test", name: "[test]:     🧪  Adding or fixing tests" },
    {
      value: "chore",
      name: "[chore]:    🔧  Chores (build, CI, dependencies, configs)",
    },
  ],

  subjectLimit: 100,

  allowTicketNumber: true,
  prependTicketToHead: true,
  ticketNumberPrefix: "#",
  ticketNumberSuffix: " -",
};
