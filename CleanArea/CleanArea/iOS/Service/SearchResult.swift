//
//  SearchResult.swift
//  CleanArea
//
//  Created by 최동호 on 3/25/24.
//

import ComposableArchitecture

import Foundation

struct SearchResult {
    var fetch: (URL) async throws -> IdentifiedArrayOf<YouthPolicy>
}

extension SearchResult: DependencyKey {
    static let liveValue = Self(
        fetch: { url in
            let (data, error) = try await URLSession.shared
                .data(from: url)
   
            let decoder = JSONDecoder()
            
            let results = try decoder.decode(IdentifiedArrayOf<YouthPolicy>.self, from: data)
 
            return results
        }
    )
}
