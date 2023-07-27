//
//  ContentBox.swift
//  MoviesDB
//
//  Created by User on 7/26/23.
//

import SwiftUI

struct ContentBox: View {
    var movie:Movie
    var body: some View {
        VStack{
            Text("Hello")
        }.frame(width: 150, height: 150)
            .background(Color.gray)
            .cornerRadius(20)
    }
}


