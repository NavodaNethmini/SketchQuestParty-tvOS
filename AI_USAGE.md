# AI-Assisted Development Documentation

## Project Information

**Project:** SketchQuest Party – tvOS  
**Module:** SE4041 – Mobile Application Design and Development  
**Assignment:** Assignment 02 – Part B  
**Platform:** Apple tvOS  
**Development Language:** Swift  
**Framework:** SwiftUI  
**AI Tool Used:** OpenAI ChatGPT

## 1. Purpose of AI Assistance

ChatGPT was used to support the development of SketchQuest Party, a multiplayer sketch guessing game designed for Apple TV.

AI assistance included explaining SwiftUI concepts, suggesting implementations, generating initial code, identifying potential errors, troubleshooting navigation problems, and preparing testing procedures and documentation.

## 2. AI Interaction Log

The following entries summarize selected development conversations. Prompt descriptions and response summaries are condensed rather than complete verbatim transcripts.

### Interaction 01 – Project Setup

**Prompt / Request:** Guide the creation of a new tvOS application using Xcode and SwiftUI.

**AI Response Summary:** Provided beginner-friendly instructions for creating the Xcode project, selecting the tvOS platform, configuring the project settings, and running the application using the Apple TV Simulator.

**Development Outcome:** Created the SketchQuestParty Xcode project and successfully launched the application.

### Interaction 02 – Home Screen Development

**Prompt / Request:** Develop a home screen for the Apple TV multiplayer drawing game.

**AI Response Summary:** Suggested a SwiftUI interface featuring a purple gradient background, game title, decorative icons, Start Party button, How to Play instructions, and player selection.

**Development Outcome:** Implemented and tested the home screen and player selection navigation.

### Interaction 03 – Sketch Drawing Implementation

**Prompt / Request:** Generate sketch drawings directly using SwiftUI code, similar to the existing house drawing, instead of importing image files.

**AI Response Summary:** Provided reusable SwiftUI Shape and Path implementations for eight object categories: Apple, Bicycle, Car, Cat, Fish, House, Star, and Tree.

**Development Outcome:** Added eight programmatically drawn vector sketches and verified their appearance in Xcode.

### Interaction 04 – Multiplayer Game Logic

**Prompt / Request:** Implement random sketch questions, multiple-choice answers, three rounds per player, countdown timers, points, and a final leaderboard.

**AI Response Summary:** Generated SwiftUI game logic for random questions, answer validation, player turns, score calculation, round progression, and winner determination.

**Development Outcome:** Tested multiplayer gameplay with 2, 3, and 4 players.

### Interaction 05 – Focus Navigation Problem

**Prompt / Request:** The keyboard cannot move focus to the Next Player button after selecting an answer.

**AI Response Summary:** Suggested using SwiftUI FocusState to assign focus to the Next Player button when it appears.

**Development Outcome:** Updated the focus handling and verified that the Next Player button could be activated.

### Interaction 06 – Player Ready Screen

**Prompt / Request:** Improve turn transitions by allowing players to prepare before the question timer starts.

**AI Response Summary:** Suggested a separate Player Ready screen and updated timer conditions so the countdown begins only after selecting Start Turn.

**Development Outcome:** Implemented and tested the Player Ready screen and countdown behaviour.

### Interaction 07 – Testing and Documentation

**Prompt / Request:** Provide procedures for testing gameplay and preparing the project for GitHub submission.

**AI Response Summary:** Supplied manual test scenarios, instructions for transferring the Xcode project, GitHub Desktop procedures, and README documentation guidance.

**Development Outcome:** Completed manual gameplay testing, uploaded source files to GitHub, and prepared project documentation.

## 3. Testing and Validation

The application was tested manually using the Apple TV 4K (3rd generation) Simulator.

Validated behaviours included:

- Player selection for 2, 3, and 4 players
- Random sketch generation
- Multiple-choice answer validation
- 30-second countdown timer
- Correct and incorrect answer feedback
- Score calculation and round progression
- Player Ready screens
- Focus navigation
- Final leaderboard
- Play Again functionality

Screenshots of application testing are available in the repository's `screenshots` directory.

## 4. Developer Responsibilities

AI-generated code suggestions were incorporated into the Xcode project and checked through manual testing. Development decisions, project integration, running the application, identifying issues, and verifying functionality remained part of the developer's workflow.

ChatGPT was an assistance tool rather than an independent application testing environment.

## 5. Limitations and Transparency

The application is an academic prototype. The tvOS game uses rule-based gameplay and custom SwiftUI vector drawings. It does not use an integrated machine learning model.

AI-generated code and explanations were used during development. This document records the nature of that assistance, with selected interactions summarized for readability.

## 6. Tool Reference

OpenAI. ChatGPT. https://chatgpt.com/

AI-assisted development interactions conducted during October 2026.
