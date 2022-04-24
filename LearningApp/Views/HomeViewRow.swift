//
//  HomeViewRow.swift
//  Learning App
//
//  Created by Jason Cao on 4/20/22.
//

import SwiftUI

struct HomeViewRow: View {
    
    var image: String
    var title: String
    var description: String
    var count: String
    var time: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10.0)
                .shadow(color: Color.black.opacity(0.2), radius: 10.0, x: 0, y: 2.0)
                .aspectRatio(CGSize(width: 335, height: 175), contentMode: .fit)
            HStack(spacing: 30.0) {
                
                // Image
                Image(image)
                    .resizable()
                    .frame(width: 125, height: 125)
                    .clipShape(Circle())
                
                // Text
                VStack(alignment: .leading, spacing: 10.0) {
                    // Headline
                    Text(title)
                        .font(.title2)
                        .bold()
                    
                    // Description
                    Text(description)
                        .padding(.bottom, 20.0)
                        .font(.caption)
                        .multilineTextAlignment(.leading)
                    
                    // Icons
                    HStack {
                        // Number of lessons/ questions
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(count)
                            .font(.caption2)
                        
                        Spacer()
                        
                        // Time
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 15, height: 15)
                        
                        Text(time)
                            .font(.caption2)
                    }
                }
                
            }
            .padding(.horizontal, 20.0)
        }

    }
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRow(image: "swift", title: "Learn Swift", description: "Some description", count: "10 Lessons", time: "2 Hours")
    }
}
