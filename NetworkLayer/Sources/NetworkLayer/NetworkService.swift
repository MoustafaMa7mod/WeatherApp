//
//  NetworkService.swift
//  NetworkLayer
//
//  Created by Mostafa Mahmoud on 09/02/2025.
//

import Foundation

/// `NetworkService` is responsible for handling network requests using `URLSession` with async/await.
/// It provides a generic `fetchData` method that can fetch and decode JSON data into a specified `Decodable` type.
///
public class NetworkService {
    
    /// Fetches and decodes JSON data from a given URL string.
    ///
    /// - Parameter urlString: The URL string of the API endpoint.
    /// - Returns: A decoded object of the specified generic type `T` (must conform to `Decodable`).
    /// - Throws: `APIError` in case of an invalid URL, request failure, invalid response, or decoding error.
    /// 
    public func fetchData<T: Decodable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw APIError.invalidResponse
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw APIError.decodingError
        }
    }
}
