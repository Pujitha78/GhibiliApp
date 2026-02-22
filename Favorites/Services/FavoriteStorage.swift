//
//  FavoriteStorage.swift
//  GhibiliApp
//
//  Created by Pujitha Kadiyala on 2/21/26.
//

import Foundation

protocol FavoriteStorage {
    func load() -> Set<String>
    func save(favoriteIDs: Set<String>)
}
