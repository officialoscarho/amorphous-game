# Amorphous Game

GameMaker project for the Amorphous demo. This repository is meant for opening
the game in GameMaker's IDE, running it, and inspecting the current project
state.

## Open The Project

1. Open `BLANK GAME.yyp` in GameMaker.
2. Let the IDE finish loading the project.
3. Run the game from `rm_boot`.
4. Use the title menu to start, continue, or manage saves.

## In-Game Flow

- `New Game`
- `Continue`
- `Memory Log`
- `Delete Save`
- `Quit`

## Planning Docs

- Build guide: `_planning_ignored/Dev_Build_Guide_v2.md`.
- Context and asset handoff: `_planning_ignored/Build_Context.md`.
- Compact snapshot: `_planning_ignored/repo_state_index.md`.

## What Is Already In The Project

- `Prologue` is the first playable room.
- The project includes the Level 1 and Level 2 room sets.
- `rm_title` and `rm_memory_log` support the title flow.
- `rm_end_demo` is the current demo endpoint.
- Player attacks are wired to display `spr_player_slash` while preserving the
  existing hitbox mask.
- The prologue humanoid shift now accepts any known human enemy type.
- Long rooms use a fixed runtime camera view that pans with the player.
- Room transitions use a short fade screen.
- Humanoid form can duck and shoot.
- Fragment pickups preserve room-authored IDs for the Memory Log.
- Level 1 and Level 2 room backgrounds can be applied from horizontally tiled
  sprite names such as `spr_bg_level1` and `spr_bg_level2`.
- `_planning_ignored/other_rooms/` contains Level 2 layout references from
  another developer.

## Current IDE Polish

- Set `spr_player_slash` origin to the center of its imported art.
- Set `spr_mask_player_humanoid` to a humanoid-height bbox.
- Import or rename the two horizontal level background sprites as
  `spr_bg_level1` and `spr_bg_level2`, then assign them to room `Background`
  layers with horizontal tiling on and stretching off.
- Keep the larger hazard, player-animation, and robot asset packs for after the
  current build is playable end to end.

## Editing Boundary

Resource, room, sprite, and `.yy` edits should be made in the GameMaker IDE.
Planning docs and explicitly requested `.gml` files are the safe text-editing
surface.
