# Ark World technical notes

## Current implementation status

This repository represents the beginning of a Godot 4 prototype foundation for Ark World. The first pass has been structured to support a small settlement world with a playable human character, NPCs, basic lighting, and a reusable architecture for future systems.

## Approach

- keep the world small and coherent
- use stylized low-poly visuals to preserve performance and flexibility
- script movement and logic in GDScript for portability
- create modular layers that can later support quests, economy, property, dialogue, and multiplayer architecture

## Notable decisions

- The player uses a human-like stylized body rather than a capsule, ready for later asset replacement.
- NPCs are lightweight and able to wander between a few points to create a living settlement feel.
- Interaction is not hard-coded to one NPC; it is designed as a reusable pattern for doors, signs, market stalls, and future world objects.
- The project is intentionally designed to be exportable to Web, Android, and desktop with a low-overhead first pass.
