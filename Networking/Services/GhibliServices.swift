//
//  GhibiliiServices.swift
//  GhibiliApp
//
//  Created by Pujitha Kadiyala on 2/21/26.
//

import Foundation

protocol GhibliServices: Sendable {
    func fetchFilms() async throws -> [Film]
    func fetchPerson(from URLString: String) async throws -> Person
    func searchFilm(for searchTerm: String) async throws -> [Film]
}
