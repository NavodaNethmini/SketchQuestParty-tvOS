import SwiftUI

// MARK: - SketchQuest Party Home Screen

struct ContentView: View {

    @State private var showingRules = false

    private let purple = Color(
        red: 0.48,
        green: 0.32,
        blue: 0.95
    )

    var body: some View {

        NavigationStack {

            ZStack {

                // Background
                LinearGradient(
                    colors: [
                        Color(red: 0.07, green: 0.05, blue: 0.17),
                        Color(red: 0.17, green: 0.10, blue: 0.36),
                        Color(red: 0.05, green: 0.08, blue: 0.20)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                HStack(spacing: 90) {

                    // Left section
                    VStack(alignment: .leading, spacing: 28) {

                        Label(
                            "SKETCHQUEST • TV EDITION",
                            systemImage: "sparkles"
                        )
                        .font(.system(size: 26, weight: .bold))
                        .foregroundStyle(.purple)

                        Text("SketchQuest\nParty")
                            .font(
                                .system(
                                    size: 88,
                                    weight: .black,
                                    design: .rounded
                                )
                            )
                            .foregroundStyle(.white)
                            .fixedSize(
                                horizontal: false,
                                vertical: true
                            )

                        Text("Guess the sketch.\nWin the round.")
                            .font(.system(size: 38, weight: .medium))
                            .foregroundStyle(.white.opacity(0.85))

                        Text(
                            "A fun drawing guessing game for friends and family."
                        )
                        .font(.system(size: 25))
                        .foregroundStyle(.white.opacity(0.65))
                        .padding(.top, 8)

                        HStack(spacing: 25) {

                            // Start button
                            NavigationLink {
                                PlayerSetupView()
                            } label: {
                                Label(
                                    "Start Party",
                                    systemImage: "play.fill"
                                )
                                .font(
                                    .system(
                                        size: 27,
                                        weight: .bold
                                    )
                                )
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(purple)

                            // Instructions button
                            Button {
                                showingRules = true
                            } label: {
                                Label(
                                    "How to Play",
                                    systemImage: "questionmark.circle"
                                )
                                .font(.system(size: 27))
                                .padding(.horizontal, 15)
                                .padding(.vertical, 10)
                            }
                            .buttonStyle(.bordered)

                        }
                        .padding(.top, 30)

                        HStack(spacing: 35) {

                            Label(
                                "2–4 Players",
                                systemImage: "person.3.fill"
                            )

                            Label(
                                "TV Remote",
                                systemImage: "gamecontroller.fill"
                            )
                        }
                        .font(.system(size: 23))
                        .foregroundStyle(.white.opacity(0.65))
                        .padding(.top, 25)

                    }

                    Spacer(minLength: 20)

                    // Right section - Drawing cards
                    VStack(spacing: 25) {

                        HStack(spacing: 25) {
                            DrawingIconCard(
                                icon: "house.fill",
                                color: .purple
                            )

                            DrawingIconCard(
                                icon: "star.fill",
                                color: .yellow
                            )
                        }

                        HStack(spacing: 25) {
                            DrawingIconCard(
                                icon: "car.fill",
                                color: .cyan
                            )

                            DrawingIconCard(
                                icon: "apple.logo",
                                color: .pink
                            )
                        }

                    }

                }
                .padding(.horizontal, 100)
                .frame(maxWidth: 1800)
            }
            .alert(
                "How to Play",
                isPresented: $showingRules
            ) {

                Button("Got It", role: .cancel) {}

            } message: {

                Text(
                    """
                    1. Select 2 to 4 players.
                    2. Look at the sketch on the TV.
                    3. Choose the correct answer.
                    4. Earn points for correct guesses.
                    5. The player with the highest score wins!
                    """
                )
            }
        }
        .preferredColorScheme(.dark)
    }
}

// MARK: - Decorative Drawing Card

private struct DrawingIconCard: View {

    let icon: String
    let color: Color

    var body: some View {

        Image(systemName: icon)
            .font(.system(size: 95, weight: .medium))
            .foregroundStyle(color)
            .frame(width: 205, height: 190)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(.white.opacity(0.09))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(
                        .white.opacity(0.15),
                        lineWidth: 2
                    )
            )
    }
}

// MARK: - Player Setup Screen

struct PlayerSetupView: View {

    @State private var selectedPlayers = 2

    var body: some View {

        ZStack {

            LinearGradient(
                colors: [
                    Color(red: 0.07, green: 0.05, blue: 0.17),
                    Color(red: 0.20, green: 0.12, blue: 0.40)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 35) {

                Text("Choose Your Players")
                    .font(.system(size: 65, weight: .bold))
                    .foregroundStyle(.white)

                Text("Select how many players will join the party.")
                    .font(.system(size: 28))
                    .foregroundStyle(.white.opacity(0.7))

                HStack(spacing: 30) {

                    ForEach(2...4, id: \.self) { count in

                        Button {

                            selectedPlayers = count

                        } label: {

                            VStack(spacing: 12) {

                                Text("\(count)")
                                    .font(
                                        .system(
                                            size: 58,
                                            weight: .bold
                                        )
                                    )

                                Text("Players")
                                    .font(.system(size: 25))

                            }
                            .frame(width: 210, height: 150)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(
                            selectedPlayers == count
                                ? .purple
                                : .gray.opacity(0.4)
                        )
                    }
                }
                .padding(.top, 35)

                Text(
                    "\(selectedPlayers) players selected"
                )
                .font(.system(size: 27))
                .foregroundStyle(.white)

                NavigationLink {
                    PartyGameView(playerCount: selectedPlayers)
                } label: {
                    Label(
                        "Start Game",
                        systemImage: "play.fill"
                    )
                    .font(.system(size: 27, weight: .bold))
                    .padding(.horizontal, 30)
                }
                .buttonStyle(.borderedProminent)
                .tint(.purple)
                .padding(.top, 25)
                    .font(.system(size: 22))
                    .foregroundStyle(.white.opacity(0.55))

            }
            .padding(70)
        }
    }
}
