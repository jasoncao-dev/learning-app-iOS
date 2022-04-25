//
//  TestView.swift
//  Learning App
//
//  Created by Jason Cao on 4/24/22.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var selectedAnswerIndex: Int?
    @State var numCorrect = 0
    @State var submitted = false
    
    var body: some View {
        
        if model.currentQuestion != nil {
            VStack(alignment: .leading) {
                // Question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding([.leading, .top], 20.0)
                    .font(.title3)
                
                // Question
                CodeTextView()
                    .padding(.horizontal, 20.0)
                
                // Answers
                ScrollView {
                    VStack(spacing: 20.0) {
                        ForEach(0..<model.currentQuestion!.answers.count, id: \.self) { index in
                            Button(
                                action: {
                                    // Track the selected index
                                    selectedAnswerIndex = index
                                },
                                label: {
                                    ZStack {
                                        if (!submitted) {
                                            // If has not been submitted
                                            RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                                .frame(height: 48.0)
                                        } else {
                                            // Check if the answer is correct
                                            if index == selectedAnswerIndex && index == model.currentQuestion!.correctIndex {
                                                // User has selected the right answer: Show a green background
                                                RectangleCard(color: .green)
                                                    .frame(height: 48.0)
                                            } else if index == selectedAnswerIndex && index != model.currentQuestion!.correctIndex {
                                                // User has selected the wrong answer: Show red background color
                                                RectangleCard(color: .red)
                                                    .frame(height: 48.0)
                                            } else if index == model.currentQuestion!.correctIndex {
                                                // This button is the correct answer
                                                RectangleCard(color: .green)
                                                    .frame(height: 48.0)
                                            } else {
                                                RectangleCard(color: .white)
                                                    .frame(height: 48.0)
                                            }
                                        }
                                        
                                        Text(model.currentQuestion!.answers[index])
                                            .bold()
                                    }
                                    
                                })
                            .disabled(submitted)
                        }
                    }
                    .padding()

                }
                
                // Button
                Button(
                    action: {
                        
                        // Check if answer has been submitted
                        if submitted == true {
                            // Answer has already been submitted, move to the next questions
                            model.nextQuestion()
                            
                            // Reset properties
                            submitted = false
                            selectedAnswerIndex = nil
                        } else {
                            // Submit the answer
                            // Change submitted to true
                            submitted = true
                            
                            // Check the answer and increment the counter if correct
                            if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                                numCorrect += 1
                            }
                        }
                    },
                    label: {
                    ZStack {
                        RectangleCard(color: .green)
                            .frame(height: 48.0)
                        Text(buttonText)
                            .bold()
                            .foregroundColor(.white)
                    }
                })
                .padding()
                .disabled(selectedAnswerIndex == nil ? true : false)

            }
            .navigationTitle("\(model.currentModule?.category ?? "") Test")
            .tint(.black)
        } else {
            Text("No Questions")
        }
    }
    
    var buttonText: String {
        return submitted ? model.hasNextQuestion() ? "Next" : "Finished" : "Submit"
    }
}
