# Contribution Guide

This guide describes the styling conventions that are applicable to the
development of this library.

This file is not comprehensive yet, it contains mistakes and unclear
indications, and some topics may have been overlooked: please consider improving
it.

## Layout of the file system

### Naming of files

## Statements of lemmas, theorems and definitions.

- Universal quantifications with dependent variable should appear on the left hand side of the colon, until we reach the first non dependent variables. e.g.
  `Lemma example x y : x < y -> x >= y = false`

### Naming of variables

- Hypothesis should not be named `H`, `H'`,... but have meaningful names. For
  example, an hypothesis `n > 0` should be named `n_gt0`.

### Naming conventions

To be defined…

## Proof style

### General guidelines

- **A line should have no more than 80 characters**. What a
character is is subject to interpretation. If a line is longer than that,
it should be cut semantically. If there is no way to make a semantic
cut (e.g. the user provides an explicit term that is too long to fit on
one line), then just cut it over several lines to make it readable.

### White space

- Operators are surrounded by space, for example `n*m` should be written `n * m`.

We write
- `move=>` and `move:` (no space between `move` and `=>` or `:`)
- `apply/` and `apply:` (no space between `apply` and `/` or `:`)
- `rewrite /definition` (there is a space between `rewrite` and an unfold)

### Indentation in proof scripts

- Lines end with a point `.` and only have `;` inside them.
- Lines that close a goal must start with a terminator (`by` or
  `exact`).
- When two subgoals are created, the first subgoal is indented by 2
  spaces, the second is not. Use `last first` to bring the
  smallest/less meaningful goal first, and keep the main flow of the
  proof unindented.
- When more than two subgoals are created, bullets are used `-` for
  the first level, `+` for the second and `*` for the third as in:
  ```
  tactic.
  - tactic.
    + tactic.
      * tactic.
      * tactic.
      * tactic.
    + tactic.
    + tactic.
  - tactic
  - tactic
  ```

  If all the subgoals have the same importance, use bullets for all of
  them, however, if one goal is more important than the others
  (i.e. is main flow of the proof). Then you might remove the bullet
  for this last one and unindent it as in:
  ```
  tactic.
  - tactic. (* secondary subgoal 1 *)
  - tactic. (* secondary subgoal 2 *)
  tactic. (* third subgoal is the main one *)
  ```

