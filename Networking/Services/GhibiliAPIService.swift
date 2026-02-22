//
//  GhibiliAPIService.swift
//  GhibiliApp
//
//  Created by Pujitha Kadiyala on 2/21/26.
//

import Foundation
//Service files contain pure functions, which doesn't hold any mutable state that can change during the runtime, that is why they are struct
//This is used to plug and play and use different implementations
struct GhibiliAPIService: GhibliServices {
    func fetch<T: Decodable>(from URLString: String, type: T.Type) async throws -> T {
        guard let url = URL(string: URLString) else {
            throw APIError.invalidURL
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            return try JSONDecoder().decode(type, from: data)
        } catch let error as DecodingError{
            throw APIError.decoding(error)
        } catch let error as URLError{
            throw APIError.networkError(error)
        }
    }
    
    func fetchFilms() async throws -> [Film] {
       let url = "https://ghibliapi.vercel.app/films"
        return try await fetch(from: url, type: [Film].self)
    }
    
    func fetchPerson(from URLString: String) async throws -> Person {
        return try await fetch(from: URLString, type: Person.self)
    }
    
    func searchFilm(for searchTerm: String) async throws -> [Film] {
        let allFilms = try await fetchFilms() //dont have a search endpoint otherwise would do this here
        
        return allFilms.filter { film in
            film.title.localizedStandardContains(searchTerm)
        }
    }
    
//    func fetchFilms() async throws -> [Films] {
//        guard let url = URL(string: "https://ghibliapi.vercel.app/films") else {
//            throw APIError.invalidURL
//        }
//        do {
//            let (data, response) = try await URLSession.shared.data(from: url)
//            
//            guard let httpResponse = response as? HTTPURLResponse,
//                  (200...299).contains(httpResponse.statusCode) else {
//                throw APIError.invalidResponse
//            }
//            return try JSONDecoder().decode([Films].self, from: data)
//        } catch let error as DecodingError{
//            throw APIError.decoding(error)
//        } catch let error as URLError{
//            throw APIError.networkError(error)
//        }
//    }
}
