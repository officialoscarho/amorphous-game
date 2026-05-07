AMORPHOUS PROJECT NOTES

Open BLANK GAME.yyp and run from rm_boot.

Active guide:
_planning_ignored/Dev_Build_Guide_v2.md

Context:
_planning_ignored/Build_Context.md

Current state:
- Prologue is the authored first playable room.
- Level 1 and Level 2 rooms need MainTiles, obj_player, encounters, fragments,
  checkpoints, bosses, and transitions.
- Save reset is available through Delete Save on the title menu.
- Resource, room, sprite, and .yy edits should be done in the GameMaker IDE.

Inheritance rule:
If a child object should keep parent behavior, call event_inherited() at the top
of that child event.
