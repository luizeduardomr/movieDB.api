//
//  apiRequest.swift
//  api-tmdb
//
//  Created by Luiz Eduardo Mello dos Reis on 02/07/21.
//

import Foundation


// API Settings
func requestApi(page: Int, completionHandler: @escaping ([Movie]) -> Void){
    if page < 0 { fatalError("Page should not be lower than 0") }
    let key = "06ba203a54577bd8c91c3b4d4b14d0ec"
    let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=\(key)&sort_by=popularity.desc&page=\(page)"
    let url = URL(string: urlString)!
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        typealias MovieOnly = [String: Any]
        
        guard let data = data,
              let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed),
              let dictionary = json as? [String: Any],
              let movies = dictionary["results"] as? [MovieOnly]
        else{
            completionHandler([])
            return
        }
        
        var localMovies: [Movie] = []
        
        
        // parsing
        for dictionaryMovies in movies{
            guard let id = dictionaryMovies["id"] as? Int,
                  let title = dictionaryMovies["title"] as? String,
                  let description = dictionaryMovies["overview"] as? String,
                  let coverImage = dictionaryMovies["poster_path"] as? String,
                  let rating = dictionaryMovies["vote_average"] as? Double,
                  let genres = dictionaryMovies["genre_ids"] as? [Int]
            else{continue}
            let movie = Movie(id: id, title: title, description: description, coverImage: coverImage, rating: rating, genresId: genres)
            localMovies.append(movie)
        }
        print(localMovies)
        completionHandler(localMovies)
    }
    .resume()
}


