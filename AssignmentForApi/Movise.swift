//
//  Movise.swift
//  AssignmentForApi
//
//  Created by Mohammed on 11/11/1444 AH.
//

import SwiftUI

struct WelcomeMove: Codable {
    let page: Int
    let results: [Move]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Move: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: OriginalLanguage
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case fi = "fi"
    case zh = "zh"
}
struct Movise: View {
    @State var movies: [Move] = []
    
    var body: some View {
        NavigationView {
            List(movies, id: \.id) { movie in
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.headline)
                    Text(movie.overview)
                        .font(.subheadline)
                    AsyncImage(url: URL(string:movie.backdropPath))
                    
                }
            }
            .navigationTitle("Movies")
        }
        .task {
           await loadData()
        } 
    }
    func loadData() async {
            guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=1f07b8f150508503c51a34b914da08f2") else {
                return
            }
        
        do{
            let (data, response) = try await URLSession.shared.data(from: url)
            print(data)
            print(response)
            let decoderProduct = try JSONDecoder().decode(WelcomeMove.self, from: data)
            self.movies = decoderProduct.results
            
            
        } catch{
            print("did not feach the data \(error)")
            
        }
        }
}
struct Movise_Previews: PreviewProvider {
    static var previews: some View {
        Movise()
    }
}
