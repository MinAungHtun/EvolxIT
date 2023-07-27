////
////  API.swift
////  MoviesDB
////
////  Created by User on 7/26/23.
////
//
//import Foundation
//
//class MovieAPI {
//    
//    var Movies:[Movie] = []
//    
//    func requestMovie() -> JSONResponse{
//            
//
//        let headers = [
//          "accept": "application/json",
//          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4Yzc3ZDBiNDIyMDFiYmI5MWMxYWY2MDY0Y2QxNmU3MyIsInN1YiI6IjY0YzBhMTVlMTNhMzIwMDEzOWYwODg1NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.uY9lGRUbzFFNI9szpmj8ePhbF5s3uJ9vUIdt43Ooxo8"
//        ]
//
//        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/discover/movie")! as URL,
//                                                cachePolicy: .useProtocolCachePolicy,
//                                            timeoutInterval: 10.0)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
//
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//          if (error != nil) {
//            print(error as Any)
//          } else {
//            let httpResponse = response as? HTTPURLResponse
//                    if let data = data {
//                      do {
//                        let responses = try JSONDecoder().decode(JSONResponse.self, from: data)
//                          return responses
//                          //print(self.Movies)
//                          
//                      } catch let decoderError {
//                          print(decoderError)
//                          return
//                      }
//                    }
//          }
//        })
//
//        dataTask.resume()
//    }
//}
//
