//
//  QuestionView.swift
//  QuestionView
//
//  Created by Shaw Young on 2021/8/11.
//

import SwiftUI

struct QuestionView: View {
    @State var remainingQuestions: Int
    var selectedNumber: Int
    @State private var tappedNumber: Int = -1
    let range = [1,2,3,4,5,6,7,8,9,10,11,12]
    @State var randomNumber: Int = 1
    @State private var correctAnswer = Int.random(in: 0..<4)
    @Binding var showingSheet: Bool
    @Binding var score: Int
    @State private var showingAlert = false
    @State var answers = [0,1,2,3]
    
    
    func getAnswers() {
        for number in 0...3 {
            if number == correctAnswer {
                answers.insert(selectedNumber * randomNumber, at: number)
            } else {
                answers.insert(selectedNumber * randomNumber + Int.random(in: 1...11), at: number)
            }
        }
    }
    
    func getRandomNumber() {
        
        
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            randomNumber = range.randomElement() ?? 0
            correctAnswer = Int.random(in: 0..<4)
            tappedNumber = -1
            print("correctAnswer: \(correctAnswer)")
            getAnswers()
        }
        
    }
    
    func isCorrectAnswer(number: Int) -> () {
        if number == correctAnswer {
            score += 1
        } else {
            score -= 1
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.blue,Color.purple.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            LinearGradient(colors: [Color.red.opacity(0.3),Color.white.opacity(0.3)], startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
            VStack {
                Text("What is the result of \(selectedNumber) * \(randomNumber)?\n Choose your answer.")
                    .foregroundColor(.white.opacity(0.7))
                    .font(.title)
                    .bold()
                    .padding(.top, 20)
                Spacer(minLength: 20)
                ForEach(0..<4) { number in
                    
                    
                    
                    
                    Button(action: {
                        
                        tappedNumber = number
                        isCorrectAnswer(number: tappedNumber)
                        print("number: \(number), correctAnswer: \(correctAnswer)")
                        
                        guard remainingQuestions != 0 else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                showingAlert.toggle()
                                
                            }
                            return
                        }
                        getRandomNumber()
                        remainingQuestions -= 1
                        
                    }) {
                        Text("\(answers[number])")
                            .padding()
                            .frame(maxWidth: .infinity)
                            
                    }
                    .background(tappedNumber == -1 ? Color.white.opacity(0.1) : (number == correctAnswer  ? Color.green.opacity(0.3): Color.red.opacity(0.3)))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundColor(.white.opacity(0.7))
                }
                .padding(.horizontal, 20)
                Spacer()
                Text("Questions remaining: \(remainingQuestions)")
                    .foregroundColor(.white.opacity(0.7))
                    .font(.title2)
                    .bold()
            }
        }
        .onAppear {
            getAnswers()
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Round end"), message: Text("Your total score is \(score)"), dismissButton: .default(Text("OK")){showingSheet.toggle()})
            
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(remainingQuestions: 5, selectedNumber: 5, showingSheet: .constant(true), score: .constant(0))
    }
}
