//
//  Films.swift
//  GhibiliApp
//
//  Created by Pujitha Kadiyala on 2/20/26.
//

import Foundation

struct Films: Codable, Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let description: String
    let director: String
    let producer: String
    
    let releaseYear: String
    let score: String
    let duration: String
    let image: String
    let bannerImage: String
    
    let people: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, title, image, description, director, producer, people
        
        case bannerImage = "movie_banner"
        
        case releaseYear = "release_date"
        case duration = "running_time"
        case score = "rt_score"
    }
}

import Playgrounds
#Playground {
    
    let url = URL(string: "https://ghibliapi.vercel.app/films")!
    
    do {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        try JSONDecoder().decode([Films].self, from: data)
        print(data)
    } catch {
        print(error)
    }
}
