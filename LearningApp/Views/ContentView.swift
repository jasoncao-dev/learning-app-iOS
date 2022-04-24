//
//  ContentView.swift
//  Learning App
//
//  Created by Jason Cao on 4/20/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                
                // Confirm that currentModule is set
                if model.currentModule != nil {
                    ForEach (0..<model.currentModule!.content.lessons.count) { index in
                        NavigationLink(
                            destination:
                                ContentDetailView()
                                .onAppear(perform: {
                                    model.beginLesson(index)
                                }),
                            label: {
                                ContentViewRow(index: index)
                                    .padding(.bottom, 15.0)
                            })
                        
                    }
                }
            }
            .padding()
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
            .tint(.black)
        }
    }
}

/*
 struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 ContentView()
 }
 }
 */
