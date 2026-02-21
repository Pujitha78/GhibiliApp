//
//  FilmsViewModel.swift
//  GhibiliApp
//
//  Created by Pujitha Kadiyala on 2/20/26.
//

import Foundation
import Observation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decoding(Error)
    case networkError(Error)
}

@Observable
class FilmsViewModel {
    var films: [Films] = []
    
    enum State: Equatable {
        case idle
        case loading
        case loaded([Films])
        case error(String)
    }
    
    var state: State = .idle
    
    func fetch() async {
        guard state == .idle else { return }
        state = .loading
        do {
            let films = try await fetchFilms()
            self.state = .loaded(films)
        } catch {
            self.state = .error(error.localizedDescription)
        }
    }
    
    private func fetchFilms() async throws -> [Films]{
        guard let url = URL(string: "https://ghibliapi.vercel.app/films") else {
            throw APIError.invalidURL
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            return try JSONDecoder().decode([Films].self, from: data)
        } catch let error as DecodingError{
            throw APIError.decoding(error)
        } catch let error as URLError{
            throw APIError.networkError(error)
        }
    }
}
