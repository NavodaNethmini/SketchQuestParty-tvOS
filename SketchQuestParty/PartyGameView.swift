import SwiftUI
import Combine

// MARK: - SketchQuest Party Game

struct PartyGameView: View {

    let playerCount: Int

    @Environment(\.dismiss) private var dismiss

    // Each player receives 3 questions.
    private let roundsPerPlayer = 3

    // Game data
    @State private var questions: [SketchCategory] = []
    @State private var answerOptions: [SketchCategory] = []
    @State private var scores: [Int] = []

    // Current game state
    @State private var turnIndex = 0
    @State private var selectedAnswer: SketchCategory?
    @State private var timeRemaining = 30
    @State private var didTimeOut = false
    @State private var gameFinished = false
    @State private var gameStarted = false
    @FocusState private var nextPlayerFocused: Bool
    @State private var waitingForPlayer = true
    @FocusState private var readyButtonFocused: Bool

    // Countdown timer
    private let timer = Timer.publish(
        every: 1,
        on: .main,
        in: .common
    ).autoconnect()

    private var currentPlayer: Int {
        turnIndex % playerCount
    }

    private var currentRound: Int {
        turnIndex / playerCount + 1
    }

    private var currentQuestion: SketchCategory {
        questions[turnIndex]
    }

    private var answerLocked: Bool {
        selectedAnswer != nil || didTimeOut
    }

    // MARK: - Main View

    var body: some View {

        ZStack {

            LinearGradient(
                colors: [
                    Color(
                        red: 0.07,
                        green: 0.05,
                        blue: 0.17
                    ),
                    Color(
                        red: 0.19,
                        green: 0.11,
                        blue: 0.39
                    )
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            if !gameStarted {

                ProgressView("Preparing Game...")

            } else if gameFinished {

                leaderboardView

            } else if waitingForPlayer {

                readyView

            } else {

                gameView
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {

            if !gameStarted {
                startNewGame()
            }
        }
        .onReceive(timer) { _ in

            guard gameStarted,
                  !gameFinished,
                  !waitingForPlayer,
                  !answerLocked else {
                return
            }

            if timeRemaining > 0 {
                timeRemaining -= 1
            }

            if timeRemaining == 0 {
                didTimeOut = true
            }
        }
    }
    
    // MARK: - Player Ready Screen

    private var readyView: some View {

        VStack(spacing: 30) {

            Image(systemName: "gamecontroller.fill")
                .font(.system(size: 80))
                .foregroundStyle(.purple)

            Text("Round \(currentRound) / \(roundsPerPlayer)")
                .font(.system(size: 28))
                .foregroundStyle(.white.opacity(0.7))

            Text("Player \(currentPlayer + 1)")
                .font(.system(size: 70, weight: .bold))

            Text("Are You Ready?")
                .font(.system(size: 43, weight: .semibold))
                .foregroundStyle(.white)

            Text("Pass the remote or keyboard to Player \(currentPlayer + 1).")
                .font(.system(size: 25))
                .foregroundStyle(.white.opacity(0.65))

            Button {

                waitingForPlayer = false
                readyButtonFocused = false

            } label: {

                Label(
                    "Start Turn",
                    systemImage: "play.fill"
                )
                .font(.system(size: 28, weight: .bold))
                .padding(.horizontal, 35)
                .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
            .tint(.purple)
            .focused($readyButtonFocused)
            .onAppear {
                readyButtonFocused = true
            }

            Text("Your 30-second timer starts after pressing Start Turn.")
                .font(.system(size: 22))
                .foregroundStyle(.white.opacity(0.55))
        }
        .padding(60)
    }

    // MARK: - Game Screen

    private var gameView: some View {

        VStack(spacing: 20) {

            // Header
            HStack {

                Label(
                    "SKETCHQUEST PARTY",
                    systemImage: "sparkles"
                )
                .foregroundStyle(.purple)

                Spacer()

                Text(
                    "Round \(currentRound) / \(roundsPerPlayer)"
                )

                Spacer()

                Text(
                    "Player \(currentPlayer + 1)"
                )

                Spacer()

                Label(
                    "\(timeRemaining)s",
                    systemImage: "timer"
                )
                .foregroundStyle(
                    timeRemaining <= 10
                    ? .red
                    : .white
                )
            }
            .font(.system(size: 25, weight: .bold))

            Text("Guess the Drawing!")
                .font(
                    .system(
                        size: 47,
                        weight: .bold
                    )
                )

            Text(
                "Player \(currentPlayer + 1), choose the correct answer!"
            )
            .font(.system(size: 25))
            .foregroundStyle(.white.opacity(0.7))

            // MARK: Random Sketch

            SketchDrawingView(
                category: currentQuestion
            )
            .frame(
                width: 450,
                height: 310
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 28)
            )

            // Countdown Progress
            ProgressView(
                value: Double(timeRemaining),
                total: 30
            )
            .tint(
                timeRemaining <= 10
                ? Color.red
                : Color.purple
            )
            .frame(width: 450)

            // MARK: Multiple Choice

            HStack(spacing: 22) {

                ForEach(
                    answerOptions,
                    id: \.self
                ) { answer in

                    Button {

                        submitAnswer(answer)

                    } label: {

                        Text(answer.title)
                            .font(
                                .system(
                                    size: 27,
                                    weight: .bold
                                )
                            )
                            .frame(
                                width: 205,
                                height: 65
                            )
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(
                        answerColor(for: answer)
                    )
                    .disabled(answerLocked)
                }
            }

            // MARK: Result Feedback

            if answerLocked {

                VStack(spacing: 16) {

                    if didTimeOut {

                        Label(
                            "Time's Up! Answer: \(currentQuestion.title)",
                            systemImage: "clock.fill"
                        )
                        .foregroundStyle(.orange)

                    } else if selectedAnswer == currentQuestion {

                        Label(
                            "Correct! +100 Points",
                            systemImage: "checkmark.circle.fill"
                        )
                        .foregroundStyle(.green)

                    } else {

                        Label(
                            "Incorrect! Answer: \(currentQuestion.title)",
                            systemImage: "xmark.circle.fill"
                        )
                        .foregroundStyle(.orange)
                    }

                    Button {

                        nextTurn()

                    } label: {

                        Label(
                            nextButtonTitle,
                            systemImage: "arrow.right"
                        )
                        .font(
                            .system(
                                size: 25,
                                weight: .bold
                            )
                        )
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.purple)
                    .focused($nextPlayerFocused)
                    .onAppear {
                        nextPlayerFocused = true
                    }
                }
                .font(
                    .system(
                        size: 26,
                        weight: .semibold
                    )
                )

            } else {

                Text(
                    "Use your Apple TV remote to select an answer."
                )
                .font(.system(size: 22))
                .foregroundStyle(.white.opacity(0.6))
            }

            // MARK: Player Scores

            HStack(spacing: 35) {

                ForEach(
                    0..<playerCount,
                    id: \.self
                ) { index in

                    VStack(spacing: 7) {

                        Text("Player \(index + 1)")
                            .font(.system(size: 21))

                        Text("\(score(for: index)) pts")
                            .font(
                                .system(
                                    size: 27,
                                    weight: .bold
                                )
                            )
                    }
                    .foregroundStyle(
                        index == currentPlayer
                        ? .white
                        : .white.opacity(0.5)
                    )
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(
                                index == currentPlayer
                                ? Color.purple.opacity(0.3)
                                : Color.clear
                            )
                    )
                }
            }

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 100)
        .padding(.top, 25)
    }

    // MARK: - Generate Random Questions

    private func generateQuestions() -> [SketchCategory] {

        var result: [SketchCategory] = []

        // Track categories already shown to each player.
        var usedCategories = Array(
            repeating: Set<SketchCategory>(),
            count: playerCount
        )

        let totalTurns = playerCount * roundsPerPlayer

        for turn in 0..<totalTurns {

            let player = turn % playerCount

            // Do not repeat a category for this player.
            var available = SketchCategory.allCases.filter {
                !usedCategories[player].contains($0)
            }

            // Avoid showing the same sketch in
            // consecutive turns.
            if let previous = result.last {

                available.removeAll {
                    $0 == previous
                }
            }

            let question = available.randomElement()
                ?? SketchCategory.house

            result.append(question)

            usedCategories[player].insert(question)
        }

        return result
    }

    // MARK: - Generate Answer Options

    private func generateAnswers(
        for correct: SketchCategory
    ) -> [SketchCategory] {

        // Choose 3 incorrect categories.
        let incorrect = SketchCategory.allCases
            .filter {
                $0 != correct
            }
            .shuffled()
            .prefix(3)

        // Include the correct answer and shuffle.
        var options = Array(incorrect)

        options.append(correct)

        return options.shuffled()
    }

    // MARK: - Start Game

    private func startNewGame() {

        scores = Array(
            repeating: 0,
            count: playerCount
        )

        questions = generateQuestions()

        turnIndex = 0
        selectedAnswer = nil
        timeRemaining = 30
        didTimeOut = false
        gameFinished = false
        waitingForPlayer = true

        answerOptions = generateAnswers(
            for: questions[0]
        )

        gameStarted = true
    }

    // MARK: - Submit Answer

    private func submitAnswer(
        _ answer: SketchCategory
    ) {

        guard !answerLocked,
              !gameFinished else {
            return
        }

        selectedAnswer = answer

        // Award 100 points for a correct answer.
        if answer == currentQuestion {

            scores[currentPlayer] += 100
        }
    }

    // MARK: - Answer Button Color

    private func answerColor(
        for answer: SketchCategory
    ) -> Color {

        guard answerLocked else {
            return .purple
        }

        if answer == currentQuestion {
            return .green
        }

        if answer == selectedAnswer {
            return .red
        }

        return .gray
    }

    // MARK: - Next Player / Round

    private var nextButtonTitle: String {

        if turnIndex + 1 >= questions.count {
            return "See Leaderboard"
        }

        if currentPlayer == playerCount - 1 {
            return "Next Round"
        }

        return "Next Player"
    }

    private func nextTurn() {

        // All players completed all rounds.
        if turnIndex + 1 >= questions.count {

            gameFinished = true
            return
        }

        // Advance to next player's question.
        turnIndex += 1
        waitingForPlayer = true

        selectedAnswer = nil
        didTimeOut = false
        timeRemaining = 30

        answerOptions = generateAnswers(
            for: currentQuestion
        )
    }

    // MARK: - Score Helper

    private func score(for index: Int) -> Int {

        guard scores.indices.contains(index) else {
            return 0
        }

        return scores[index]
    }

    // MARK: - Determine Winner

    private var winnerText: String {

        let highest = scores.max() ?? 0

        let winners = scores.indices.filter {
            scores[$0] == highest
        }

        if winners.count == 1,
           let winner = winners.first {

            return "Player \(winner + 1) Wins!"
        }

        return "It's a Tie!"
    }

    // MARK: - Final Leaderboard

    private var leaderboardView: some View {

        VStack(spacing: 22) {

            Image(systemName: "trophy.fill")
                .font(.system(size: 75))
                .foregroundStyle(.yellow)

            Text("Final Leaderboard")
                .font(
                    .system(
                        size: 55,
                        weight: .bold
                    )
                )

            Text(winnerText)
                .font(
                    .system(
                        size: 35,
                        weight: .bold
                    )
                )
                .foregroundStyle(.yellow)

            Text(
                "\(roundsPerPlayer) rounds completed per player"
            )
            .font(.system(size: 23))
            .foregroundStyle(.white.opacity(0.65))

            // Sort players by their scores.
            ForEach(
                scores.indices.sorted {
                    first, second in

                    if scores[first] == scores[second] {
                        return first < second
                    }

                    return scores[first] > scores[second]
                },
                id: \.self
            ) { index in

                HStack {

                    Image(
                        systemName: "person.circle.fill"
                    )

                    Text("Player \(index + 1)")

                    Spacer()

                    Text("\(scores[index]) Points")
                }
                .font(
                    .system(
                        size: 27,
                        weight: .semibold
                    )
                )
                .padding(19)
                .frame(width: 690)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(.white.opacity(0.12))
                )
            }

            HStack(spacing: 30) {

                Button {

                    startNewGame()

                } label: {

                    Label(
                        "Play Again",
                        systemImage: "arrow.clockwise"
                    )
                }
                .buttonStyle(.borderedProminent)
                .tint(.purple)

                Button {

                    dismiss()

                } label: {

                    Label(
                        "Player Setup",
                        systemImage: "person.3.fill"
                    )
                }
                .buttonStyle(.bordered)
            }
            .font(.system(size: 25))
            .padding(.top, 20)
        }
    }
}
