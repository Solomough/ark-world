# Ark World Architecture

## Goals

Ark World is designed as a small but coherent living settlement prototype. The first playable version prioritizes a strong sense of place, accessible systems, and a foundation that can expand into longer-term social and economic loops.

## Core architecture

### 1. World Layer
The world contains a single settlement with residential, agricultural, market, lab, and public spaces.

- environment and day/night loop
- roads, plots, buildings, and open space
- NPC positioning and schedule logic
- simple atmospheric lighting and weather hooks

### 2. Player Layer
The player is a grounded human character with a stateful controller.

- movement, sprint, jump, gravity
- inventory and skill state
- interaction target detection
- future camera, dialogue, and quest abstraction

### 3. NPC Layer
NPCs are data-driven actors with names, professions, and schedules.

- routine movement between points
- profession-based behaviors
- future queryable dialogue and reputation logic
- local social activity in settlement spaces

### 4. Economy Layer
The economy uses a local simulation of production and value.

- currency: Ark Credits
- supply and demand hooks
- production and trade flow
- business and property foundations

### 5. Growth Layer
The long-term product aims to weave together opportunity creation and apprenticeship.

- skills unlock gameplay
- quests drive progression
- property and enterprise open more possibilities
- reputation influences community trust

## Technical principles

- Godot 4.x only
- GDScript-first for portability and easier iteration
- low-poly stylized visuals with replaceable assets
- performance-conscious world composition
- modular systems that can later support multiplayer abstraction

## Future extensions

- save/data migration system
- quest management and branching dialogue
- local market price simulation
- agriculture growth state machine
- property ownership and rent infrastructure
- ArkID / ArkProfile adapter boundary
