//
//  FilmDetailsViewModel.swift
//  GhibiliApp
//
//  Created by Pujitha Kadiyala on 2/21/26.
//

import Foundation
import Observation

@Observable
class FilmDetailsViewModel {
    var people: [Person] = []
    private let service: GhibliServices
    var state: LoadingState<[Person]> = .idle
    
    init(service: GhibliServices = GhibiliAPIService()) {
        self.service = service
    }
    
    //parallel execution with async await using TaskGroup
//    func fetch(for film: Film) async {
//        do {
//            try await withThrowingTaskGroup(of: Person.self) { group in
//                for peopleInfoURL in film.people {
//                    group.addTask {
//                        try await self.service.fetchPerson(from: peopleInfoURL)
//                    }
//                }
//                //collect results as they complete
//                for try await person in group {
//                    people.append(person)
//                }
//            }
//        } catch {
//            
//        }
//    }
    
    func fetch(for film: Film) async {
        guard !state.isLoading else { return }
        
        state = .loading
        
        var loadedPeople: [Person] = []
    
        do {
            try await withThrowingTaskGroup(of: Person.self) { group in
                
                for personInfoURL in film.people {
                    group.addTask {
                        try await self.service.fetchPerson(from: personInfoURL)
                    }
                }
                
                // collect results as they complete
                for try await person in group {
                    loadedPeople.append(person)
                }
            }
            
            state = .loaded(loadedPeople)
            
            
        }  catch let error as APIError {
            self.state = .error(error.errorDescription ?? "unknown error")
        } catch {
            self.state = .error("unknown error")
        }
    }
}

import Playgrounds

#Playground {
    let service = MockGhibliAPIService()
    let vm = FilmDetailsViewModel(service: service)
    
    let film = service.fetchFilm()
    await vm.fetch(for: film)
    
    switch vm.state {
        case .loading: print("loading")
        case .idle: print("idle")
        case .loaded(let people):
            for person in people {
                print(person)
            }
        case .error(let error): print(error)
    }
    
}
