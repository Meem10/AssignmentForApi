//
//  News.swift
//  AssignmentForApi
//
//  Created by Mohammed on 11/11/1444 AH.
//

import SwiftUI
var myURLAR = "https://newsapi.org/v2/top-headlines?country=us&apiKey=13aa61cfb56f49c0854a5b5abd7da2ff"

struct ArticleRes : Codable{
    let articles : [Article]
}

struct Article: Codable {
    let author: String
    let title, description: String
    let url: String
    let urlToImage: String
    let publishedAt: Date
    let content: String
}



struct News: View {
    @State private var articles: [Article] = []
    var body: some View {
        NavigationView {
            List(articles, id: \.title) { article in
                VStack(alignment: .leading, spacing: 10) {
                    Text(article.author)
                }
            }.task {
                await loadData()
            }
            .navigationTitle("News")
        }
        
    }
    
    func loadData() async {
        guard let url = URL(string: myURLAR) else {
            return
        }
        
        do{
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoderProduct = try JSONDecoder().decode(ArticleRes.self, from: data)
            articles = decoderProduct.articles
                    
        } catch{
            print("did not feach the data \(error)")
            
        }
    }
}

struct News_Previews: PreviewProvider {
    static var previews: some View {
        News()
    }
}
