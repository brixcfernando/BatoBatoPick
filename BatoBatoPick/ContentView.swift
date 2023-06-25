import SwiftUI

enum Choices: String {
    case Paper = "📜"
    case Rock = "🪨"
    case Scissors = "✂️"
}

enum Result: String {
    case Win = "You Win"
    case Lose = "You Lose"
    case Draw = "It's a Draw"
}

struct ContentView: View {

    @State private var playerChoice = 0
    @State private var enemyChoice = 0
    @State private var shouldWin = false

    private let choices: [Choices] = [.Paper, .Rock, .Scissors]

    @State private var showChoice = false
    @State private var showResult = false
    @State private var result: Result = .Draw
    
    @State private var score = 0

    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 80) {
                Text(shouldWin ? "Win" : "Lose")
                    .font(.system(size: 80))
                
                HStack(spacing: 50) {
                    Text(choices[playerChoice].rawValue)
                        .opacity(showChoice ? 1 : 0)
                    Text("vs")
                    Text(choices[enemyChoice].rawValue)
                }
                .font(.system(size: 80))
                
                HStack(spacing: 50) {
                    ForEach(0..<3) { index in
                        Text(choices[index].rawValue)
//                            .background(.blue)
                            .shadow(color: .white, radius: 2)
                            .onTapGesture() {
                                showChoice = true
                                playerChoice = index
                                getResult()
                            }
                    }
                }
                .font(.system(size: 50))

                Text("Score: \(score)")
                    .foregroundColor(.white)
            }
            .padding()
//            .alert(result.rawValue, isPresented: $showResult) {
//                Button("Continue", action: newGame)
//            }
            .alert(isPresented: $showResult) {
                Alert(
                    title: Text("\(result.rawValue)"),
                    dismissButton: .default(Text("play again"), action: {
                            newGame()
                    })
                )
            }.padding()
        }
    }
    
    private func getResult() {
        switch choices[enemyChoice] {
        case .Paper:
            switch choices[playerChoice] {
            case .Paper:
                result = .Draw
            case .Rock:
                result = shouldWin ? .Lose : .Win
            case .Scissors:
                result = shouldWin ? .Win : .Lose
            }
        case .Rock:
            switch choices[playerChoice] {
            case .Paper:
                result = shouldWin ? .Win : .Lose
            case .Rock:
                result = .Draw
            case .Scissors:
                result = shouldWin ? .Lose : .Win
            }
        case .Scissors:
            switch choices[playerChoice] {
            case .Paper:
                result = shouldWin ? .Lose : .Win
            case .Rock:
                result = shouldWin ? .Win : .Lose
            case .Scissors:
                result = .Draw
            }
        }
        
        if result == .Win {
            score += 1
        }
        showResult = true
    }
    
    private func newGame() {
        showChoice = false
        enemyChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
