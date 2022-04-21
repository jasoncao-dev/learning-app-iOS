//
//  ContentViewRow.swift
//  Learning App
//
//  Created by Jason Cao on 4/20/22.
//

import SwiftUI

struct ContentViewRow: View {
    
    @EnvironmentObject var model: ContentModel
    var index: Int
    
    var body: some View {
        let lesson = model.currentModule!.content.lessons[index]
        // Lesson card
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10.0)
                .shadow(color: Color.black.opacity(0.2), radius: 7.5, x: 0, y: 2.0)
                .frame(height: 100)
            
            HStack(spacing: 30.0) {
                Text(String(index + 1))
                    .font(.title)
                    .bold()
                
                VStack(alignment: .leading) {
                    Text(lesson.title)
                        .font(.title3)
                        .bold()
                    Text(lesson.duration)
                }
            }
            .padding(25.0)
        }
    }
}

/*
 struct ContentViewRow_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewRow()
    }
}
*/
