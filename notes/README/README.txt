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
- Player attacks are now wired to spr_player_slash for visuals while keeping
  spr_attack_hitbox for damage collision.
- The prologue shift trigger counts workers, scientists, security guards, and
  soldiers as human enemies.
- Long rooms now use a fixed runtime camera view instead of squishing into the
  window.
- Room transitions now use a short fade screen.
- Fragment pickups preserve room fragment_id overrides for Memory Log.
- Humanoid form can duck with S/Down and shoot with right mouse/K.
- _planning_ignored/other_rooms contains Level 2 layout references to recreate
  manually in the IDE if desired.
- Resource, room, sprite, and .yy edits should be done in the GameMaker IDE.

Current IDE polish:
- Center spr_player_slash's origin.
- Fix spr_mask_player_humanoid's bbox to cover humanoid height.
- Import or rename horizontal background sprites as spr_bg_level1 and
  spr_bg_level2, then assign them to Level 1 and Level 2 Background layers with
  horizontal tiling on and stretching off.

Inheritance rule:
If a child object should keep parent behavior, call event_inherited() at the top
of that child event.
