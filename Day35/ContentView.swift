//
//  ContentView.swift
//  Day35
//
//  Created by Shaw Young on 2021/8/10.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedFactor = 1
    @State private var selectedNumberOfQuestions = 0
    @State private var showingSheet = false
    @State private var score: Int = 0 
    let numberOfQuestions = [5,10,20]
    
    init() {
        
        UITableView.appearance().backgroundColor = .clear
        
        
    }
    
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.blue,Color.purple.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            LinearGradient(colors: [Color.red.opacity(0.3),Color.white.opacity(0.3)], startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
            
            
            
            VStack {
                Text("Multiplicaton Game")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white.opacity(0.9))
                    
                Form {
                    Section(header:
                                Text("Number")
                            
                    ) {
                        Stepper("Select your number", value: $selectedFactor, in: 0...12)
                            
                        Text("Your selected number is \(selectedFactor)")
                            .fontWeight(.medium)
                    }
                    .listRowBackground(Color.white.opacity(0.1))
                    .foregroundColor(.white)
                    
                    
        //            Picker(selection: $selectedNumberOfQuestion) {
        //                ForEach(0..<numberOfQuestions.count, id: \.self) { index in
        //                    Text("\(numberOfQuestions[index])")
        //                }
        //            }
                    Section(header: Text("Difficulty")
                                ) {
                        Picker(selection:  $selectedNumberOfQuestions) {
                            ForEach(0..<numberOfQuestions.count, id: \.self) { index in
                                Text("\(numberOfQuestions[index])")
                                
                            }
                            
                            
                        } label: {
                            Text("sb")
                        }
                        
                        
                        .pickerStyle(SegmentedPickerStyle())
                        Text("Your selected difficulty is \(numberOfQuestions[selectedNumberOfQuestions]) questions.")
                            .fontWeight(.medium)
                    }
                    .listRowBackground(Color.white.opacity(0.2))
                    .foregroundColor(.white)
                    

                    
                }
                Text("Your total score so far is \(score).")
                    .foregroundColor(.white.opacity(0.7))
                Spacer()
                Button(action: {showingSheet.toggle()}) {
                    Text("Start Game")
                        .padding()
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                }
                .padding()
                
                
                
                
                
            }
            
            
            
            
        }
        .sheet(isPresented: $showingSheet) {
            QuestionView(remainingQuestions: numberOfQuestions[selectedNumberOfQuestions]-1, selectedNumber: selectedFactor, showingSheet: $showingSheet, score: $score)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
