# Amorphous Game

GameMaker project for an asset-poor playable Amorphous demo covering the title
flow, Prologue, Level 1, Level 2, and `rm_end_demo`.

## Open The Project

1. Open `BLANK GAME.yyp` in GameMaker.
2. Run from `rm_boot`.
3. Use the title menu for `New Game`, `Continue`, `Memory Log`,
   `Delete Save`, or `Quit`.

## Active Planning

- Build guide: `_planning_ignored/Dev_Build_Guide_v2.md`.
- Context and sprite/resource handoff: `_planning_ignored/Build_Context.md`.
- Latest compact snapshot: `_planning_ignored/repo_state_index.md`.
- Story reference: `_planning_ignored/Story_Canon.md`.

## Current State

- `Prologue` is the authored first playable room.
- Level 1 and Level 2 rooms exist but still need IDE-authored tiles,
  instances, encounters, fragments, checkpoints, bosses, and transitions.
- Save reset is exposed as `Delete Save` on the title menu.
- Death now uses a menu buffer with `Respawn` and `Main Menu`.

## Editing Boundary

GameMaker resource edits belong in the GameMaker IDE. Do not manually edit
`.yy`, `.yyp`, room metadata, sprite folders, or project resource files outside
the IDE. Planning docs and explicitly allowed `.gml` files are the safe text
editing surface.
