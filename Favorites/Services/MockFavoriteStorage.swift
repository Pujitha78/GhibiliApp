//
//  MockFavoriteStorage.swift
//  GhibiliApp
//
//  Created by Pujitha Kadiyala on 2/21/26.
//


import Foundation

struct MockFavoriteStorage: FavoriteStorage {
    
    func load() -> Set<String> {
        ["2baf70d1-42bb-4437-b551-e5fed5a87abe"]
    }
    
    func save(favoriteIDs: Set<String>) {
        
    }
}
