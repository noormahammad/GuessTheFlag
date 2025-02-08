//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by noor on 2/5/25.
//

import SwiftUI


struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    @State private var correctAnswer: Int = Int.random(in: 0...2)
    @State private var scoreTitle = ""
    @State private var scoreShowing = false
    @State private var score = 0
    @State private var gameOver = false
    @State private var questionCounter = 1
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack(spacing: 30) {
                Spacer()
                Text("Guess the Flag")
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flage of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    VStack(spacing:15) {
                        ForEach(0..<3){ number in
                            Button {
                                flagTapped(number)
                            } label: {
                                Image(countries[number])
                                    .clipShape(.capsule)
                                    .shadow(radius: 5)
                            } .alert(scoreTitle, isPresented: $scoreShowing){
                                Button("Continue?") {
                                    countries.shuffle()
                                    correctAnswer = Int.random(in: 0...2)
                                    
                                    if questionCounter > 9 {
                                        gameOver = true
                                    } else {
                                        questionCounter += 1
                                    }
                                }
                            }
                            .alert("Game OVer", isPresented: $gameOver){
                                Button("Restart") {
                                    questionCounter = 0
                                    score = 0
                                }
                                Button("Cancel") {
                                    
                                }
                            } message: {
                                Text("Game Over! Do you want to Restart?")
                            }
                        }
                        Text("Qestion \(questionCounter) of 10")
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                VStack {
                    Text("Score: \(score)")
                        .foregroundStyle(.white)
                        .font(.title.bold())
                }
                Spacer()
            }.padding()
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer {
            score +=  1
            scoreTitle = "Correct. Your Score now is: \(score)"
            scoreShowing = true
            
        } else {
            scoreTitle = "Wrong. That's the flag of \(countries[number])"
            scoreShowing = true
        }
    }
}
#Preview {
    ContentView()
}
