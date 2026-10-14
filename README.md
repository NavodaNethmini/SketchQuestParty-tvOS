# SketchQuest Party – tvOS

**A Multiplayer Sketch Guessing Game for Apple TV**

SE4041 – Mobile Application Design and Development  
Assignment 02 – Part B  
Platform: Apple tvOS

## Project Overview

SketchQuest Party is a local multiplayer drawing-guessing game developed using SwiftUI for Apple TV.

The game allows 2–4 players to compete by identifying sketches displayed on the television. Players take turns using the Apple TV remote or simulator keyboard to select answers and earn points.

## Key Features

- Support for 2–4 local players
- Eight custom vector sketch categories: Apple, Bicycle, Car, Cat, Fish, House, Star and Tree
- Random sketch questions
- Four multiple-choice answers per question
- Three rounds for each player
- 30-second countdown timer
- 100 points for each correct answer
- Correct, incorrect and timeout feedback
- Player Ready screen before each turn
- Real-time player score display
- Final leaderboard and winner announcement
- Play Again functionality
- tvOS focus-based navigation

## Technologies Used

- Swift
- SwiftUI
- Apple tvOS
- Xcode
- SwiftUI Path and Shape
- Git and GitHub

## How to Run

1. Download or clone the GitHub repository.
2. Open `SketchQuestParty.xcodeproj` using Xcode on a Mac.
3. Select the SketchQuestParty application scheme.
4. Select a compatible Apple TV Simulator.
5. Build and run the application.
6. Select Start Party and choose the number of players.
7. Start the game and follow the on-screen instructions.

**Test Environment:** Apple TV 4K (3rd generation) Simulator, tvOS 26.1.

## How to Play

1. Select 2, 3 or 4 players.
2. Press Start Game.
3. Pass the remote to the current player.
4. Press Start Turn when ready.
5. Identify the drawing before the timer expires.
6. Earn 100 points for a correct answer.
7. Complete three rounds per player.
8. View the final leaderboard to see the winner.

## Testing

Manual testing was performed using the Apple TV Simulator.

The following functionality was checked:

- Home screen and navigation
- Player selection
- Random sketch generation
- Correct and incorrect answers
- Countdown timer and timeout behaviour
- Multiplayer scoring for 2, 3 and 4 players
- Player Ready screen
- Final leaderboard
- Play Again and score reset
- Button focus navigation

## AI-Assisted Development

ChatGPT was used as a development assistance tool to help explain SwiftUI concepts, generate initial code suggestions, troubleshoot focus navigation issues, and plan test cases.

The generated suggestions were integrated, adjusted and manually tested during development. AI-assisted interactions are documented separately for the assignment.

## Development Notes

Sketch drawings are created programmatically using SwiftUI `Path` and `Shape`. The tvOS game does not require an external image dataset or a machine learning model.

The prototype uses a local turn-based multiplayer approach with one shared input device.

## Academic Information

Developed for SE4041 – Mobile Application Design and Development, Assignment 02, Part B.

This project is an academic functional prototype intended for educational demonstration.
