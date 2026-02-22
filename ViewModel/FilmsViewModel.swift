//
//  FilmsViewModel.swift
//  GhibiliApp
//
//  Created by Pujitha Kadiyala on 2/20/26.
//

import Foundation
import Observation


@Observable
class FilmsViewModel {
    var films: [Film] = []
    var state: LoadingState<[Film]> = .idle
    
    //Dependency injection
    private let service: GhibliServices
    init(service: GhibliServices = GhibiliAPIService()) {
        self.service = service
    }
    
    func fetch() async {
        guard !state.isLoading || state.error != nil else { return }
        
        state = .loading
        
        do {
            let films = try await service.fetchFilms()
            self.state = .loaded(films)
        } catch let error as APIError {
            self.state = .error(error.errorDescription ?? "unknown error")
        } catch {
            self.state = .error("unknown error")
        }
    }
    
//    func fetch() async {
//        guard state == .idle else { return }
//        state = .loading
//        do {
//            let films = try await service.fetchFilms()
//            self.state = .loaded(films)
//        } catch {
//            self.state = .error(error.localizedDescription)
//        }
//    }

    static var example: FilmsViewModel {
        let vm = FilmsViewModel(service: MockGhibliAPIService())
        vm.state = .loaded([Film.example, Film.exampleFavorite])
        return vm
    }
}
