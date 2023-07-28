//
//  ContentView.swift
//  MoviesDB
//
//  Created by User on 7/26/23.
//

import SwiftUI

struct ContentView: View {
    @State var Movies:[Movie] = []
    @State var dataLoadSuccess:Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var upcomingMovies:[Movie] = []
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                Text("MovieDB")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                HStack{
                    Text("All")
                        .frame(width: 50, height: 300)
                        .background(Color.gray)
                        .cornerRadius(20)
                        .padding()
                    Text("Movies")
                        .frame(width: 150, height: 300)
                        .background(Color.gray)
                        .cornerRadius(20)
                        .padding()
                    Text("Series")
                        .frame(width: 150, height: 300)
                        .background(Color.gray)
                        .cornerRadius(20)
                        .padding()
                }
//                if(dataLoadSuccess){
//                GeometryReader { geometry in
//                    CarouselView(numberOfImages: 3) {
//                        ZStack{
//
//                            NavigationLink(destination: MoviesDetails(movie: self.upcomingMovies[0])){
//                                //Text("Something")
//                                //                                Image("Meditation 10 mins")
//                                //                                    .resizable()
//                                //                                    .scaledToFill()
//                                //                                    .frame(width: geometry.size.width, height: geometry.size.height)
//                                //                                .clipped()}
//                                Text("Meditation").font(Font.custom("Nexa Bold", size: 19)).fontWeight(.bold).padding(.top, 185).padding(.trailing, 130)
//                            }
//
//                        }
//                        ZStack{
//                            NavigationLink(destination: MoviesDetails(movie: self.upcomingMovies[1])){
//                                Text("Thought Hunter").font(Font.custom("Nexa Bold", size: 19)).fontWeight(.bold).padding(.top, 195).padding(.trailing, 130)
//                            }
//                        }
//                        ZStack{
//                            NavigationLink(destination: MoviesDetails(movie: self.upcomingMovies[2])){
//                                //                        Image("Seeking balance")
//                                //                            .resizable()
//                                //                            .scaledToFill()
//                                //                            .frame(width: geometry.size.width, height: geometry.size.height)
//                                //                            .clipped()}
//                                Text("Seeking Balance").font(Font.custom("Nexa Bold", size: 19)).fontWeight(.bold).padding(.top, 195).padding(.trailing, 130)
//
//                            }
//                        }
//                    }
//
//
//                }.frame(height: 240, alignment: .center)
            //}
                ScrollView(.vertical, showsIndicators: false) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top, spacing: 0){
                            ForEach(self.Movies){ movie in
                                
                                NavigationLink(
                                    destination: MoviesDetails(movie: movie)
                                ) {
                                    ContentBox(movie: movie).padding()
                                }
                            }
                        }
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top, spacing: 0){
                            ForEach(self.upcomingMovies){ movie in
                                
                                NavigationLink(
                                    destination: MoviesDetails(movie: movie)
                                ) {
                                    ContentBox(movie: movie).padding()
                                }
                            }
                        }
                    }
                }
                .padding()
                BottomNavBar()
            }
            .padding()
            .onAppear(perform: {
                requestMovie()
                requestUpcomingMovie()
            })
            .onReceive(timer) { _ in
                requestMovie()
                requestUpcomingMovie()
                        }
        }.padding()
    }

    func requestUpcomingMovie(){
            
        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4Yzc3ZDBiNDIyMDFiYmI5MWMxYWY2MDY0Y2QxNmU3MyIsInN1YiI6IjY0YzBhMTVlMTNhMzIwMDEzOWYwODg1NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.uY9lGRUbzFFNI9szpmj8ePhbF5s3uJ9vUIdt43Ooxo8"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/movie/upcoming")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
              self.upcomingMovies.append(Movie(adult: false, backdrop_path: " ", genre_ids: [0,1], id: 1, original_language: "en", original_title: "placeholder", overview: "placeholder", popularity: 4.1, poster_path: " ", release_date: "1/1/2023", title: "placeholder", video: false, vote_average: 4.1, vote_count: 30))
            print(error as Any)
          } else {
            let httpResponse = response as? HTTPURLResponse
                    if let data = data {
                      do {
                        let responses = try JSONDecoder().decode(JSONResponse.self, from: data)
                          for result in responses.results {
                              self.upcomingMovies.append(Movie(adult: result.adult, backdrop_path: result.backdrop_path, genre_ids: result.genre_ids, id: result.id, original_language: result.original_language, original_title: result.original_title, overview: result.overview, popularity: result.popularity, poster_path: result.poster_path, release_date: result.release_date, title: result.title, video: result.video, vote_average: result.vote_average, vote_count: result.vote_count))
                          }
                      } catch let decoderError {
                          print(decoderError)
                          self.upcomingMovies.append(Movie(adult: false, backdrop_path: " ", genre_ids: [0,1], id: 1, original_language: "en", original_title: "placeholder", overview: "placeholder", popularity: 4.1, poster_path: " ", release_date: "1/1/2023", title: "placeholder", video: false, vote_average: 4.1, vote_count: 30))
                          return
                      }
                    }
          }
        })

        dataTask.resume()
    }
    
    func requestMovie(){
            
        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4Yzc3ZDBiNDIyMDFiYmI5MWMxYWY2MDY0Y2QxNmU3MyIsInN1YiI6IjY0YzBhMTVlMTNhMzIwMDEzOWYwODg1NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.uY9lGRUbzFFNI9szpmj8ePhbF5s3uJ9vUIdt43Ooxo8"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/movie/popular")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
              self.upcomingMovies.append(Movie(adult: false, backdrop_path: " ", genre_ids: [0,1], id: 1, original_language: "en", original_title: "placeholder", overview: "placeholder", popularity: 4.1, poster_path: " ", release_date: "1/1/2023", title: "placeholder", video: false, vote_average: 4.1, vote_count: 30))
            print(error as Any)
          } else {
            let httpResponse = response as? HTTPURLResponse
                    if let data = data {
                      do {
                        let responses = try JSONDecoder().decode(JSONResponse.self, from: data)
                          for result in responses.results {
                              self.Movies.append(Movie(adult: result.adult, backdrop_path: result.backdrop_path, genre_ids: result.genre_ids, id: result.id, original_language: result.original_language, original_title: result.original_title, overview: result.overview, popularity: result.popularity, poster_path: result.poster_path, release_date: result.release_date, title: result.title, video: result.video, vote_average: result.vote_average, vote_count: result.vote_count))
                          }
                      } catch let decoderError {
                          print(decoderError)
                          self.upcomingMovies.append(Movie(adult: false, backdrop_path: " ", genre_ids: [0,1], id: 1, original_language: "en", original_title: "placeholder", overview: "placeholder", popularity: 4.1, poster_path: " ", release_date: "1/1/2023", title: "placeholder", video: false, vote_average: 4.1, vote_count: 30))
                          print("Internet")
                          return
                      }
                    }
          }
        })

        dataTask.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
