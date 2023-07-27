//
//  MoviesDetails.swift
//  MoviesDB
//
//  Created by User on 7/26/23.
//

import SwiftUI

struct MoviesDetails: View {
    var movie:Movie
    var body: some View {
        VStack{
            NavigationLink(
                destination: PlayerView()
            )
            {
                Text("Watch Now")
            }
            Text(movie.title)
            Text(movie.overview)
            Text(movie.release_date)
        }
    }
}

