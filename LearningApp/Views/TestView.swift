//
//  TestView.swift
//  Learning App
//
//  Created by Jason Cao on 4/24/22.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {

         if model.currentQuestion != nil {
            VStack {
                // Question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                
                // Question
                /*
                 Text("Question \(model.currentQuestionIndex + 1): \(model.currentQuestion!.content)")
                 */
                CodeTextView()
                
                // Answers
                
                // Button
            }
            .navigationTitle("\(model.currentModule?.category ?? "") Test")
         } else {
             Text("No Questions")
         }
    }
}
