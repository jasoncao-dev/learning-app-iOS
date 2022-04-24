//
//  RectangleCard.swift
//  Learning App
//
//  Created by Jason Cao on 4/24/22.
//

import SwiftUI

struct RectangleCard: View {
    var color = Color.white
    
    var body: some View {
        Rectangle()
            .foregroundColor(color)
            .cornerRadius(10.0)
            .shadow(radius: 5.0)
    }
}

struct RectangleCard_Previews: PreviewProvider {
    static var previews: some View {
        RectangleCard()
    }
}
