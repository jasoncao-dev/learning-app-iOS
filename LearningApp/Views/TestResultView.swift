//
//  TestResultView.swift
//  Learning App
//
//  Created by Jason Cao on 4/24/22.
//

import SwiftUI

struct TestResultView: View {
    
    var numCorrect: Int
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        VStack {
            Spacer()
            Text(resultTitle)
                .font(.largeTitle)
                .bold()
                .padding(.bottom)
            
            Text("You got \(numCorrect) out of \(model.currentModule?.test.questions.count ?? 0) questions")
            Spacer()
            Button(
                action: {
                    model.currentTestSelected = nil
                }, label: {
                    ZStack {
                        RectangleCard(color: .green)
                            .frame(height: 48.0)
                        Text("Complete")
                            .bold()
                            .foregroundColor(.white)
                    }
                })
        }
        .padding()
    }
    
    var resultTitle: String {
        guard model.currentModule != nil else {
            return ""
        }
        
        let pct = Double(numCorrect)/Double(model.currentModule!.test.questions.count)
        
        if pct > 0.5 {
            return "Awesome 🎉"
        } else if pct > 0.2 {
            return "Kudos 🎉"
        } else {
            return "Keep learning 😊"
        }
    }
}
