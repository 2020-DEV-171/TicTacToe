# Tic Tac Toe

## How to build and run
Just open the .xcodeproj and run it

## Implementation details

### Board.swift
Mainly contains `Board`, a simple tic tac toe board implemented internally with arrays, each cell can be empty or contain a circle or a cross. There is no logic to prevent updating an already claimed cell, and there's no concept of turns or players, or winning conditions. Cell coordinates are implemented using `enums` to avoid indexing with `Int`s and checking bounds.

### Game.swift
The `Game` class implements the logic of a tic tac toe game: players, turn taking, winning conditions. Users of the class can set themselves as a `delegate` to receive events from the game. It is in fact not necessary to acess the private `Board` instance to play and observe the game.
