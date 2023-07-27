//
//  Movie.swift
//  MoviesDB
//
//  Created by User on 7/26/23.
//

import Foundation

struct Movie: Decodable, Identifiable {
    var adult:Bool
    var backdrop_path:String
    var genre_ids:[Int]
    var id:Int
    var original_language:String
    var original_title:String
    var overview:String
    var popularity:Float
    var poster_path:String
    var release_date:String
    var title:String
    var video:Bool
    var vote_average:Float
    var vote_count:Int
}

struct JSONResponse: Decodable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
}
