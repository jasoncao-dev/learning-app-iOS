//
//  ContentDetailView.swift
//  Learning App
//
//  Created by Jason Cao on 4/21/22.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        VStack {
            // Only show video if url is valid
            if url != nil {
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10.0)
            }
            
            // Description
            CodeTextView()
                .mask(
                    LinearGradient(gradient: Gradient(colors: [Color.black, Color.black, Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                )
            
            // Show next lession button, only if there is a next lesson
            if model.hasNextLesson() {
                Button(action: {
                    model.nextLesson()
                }, label: {
                    ZStack {
                        RectangleCard(color: .green)
                            .frame(height: 48.0)

                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .bold()
                            .foregroundColor(.white)
                    }
                })
            } else {
                // Show the complete button
                Button(action: {
                    model.currentContentSelected = nil
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
        }
        .padding()
        .navigationTitle(lesson?.title ?? "")
    }
}
