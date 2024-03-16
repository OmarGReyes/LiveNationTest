//
//  HTTPClient.swift
//  LiveNationTest
//
//  Created by Omar Gonzalez on 16/03/24.
//

import Foundation

// MARK: HttpClient Protocol
protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
}

// MARK: HttpClient Extension
extension HTTPClient {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async -> Result<T, RequestError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems?.map({ (key: String, value: String) in
            URLQueryItem(name: key, value: value)
        })
        
        guard let url = urlComponents.url else {
//            URLError(.badURL)
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
//                URLError(.badServerResponse)
                return .failure(.noResponse)
            }
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
//                    URLError(.cannotDecodeRawData)
                    return .failure(.decode)
                }
                return .success(decodedResponse)
            case 401:
//                URLError(.userAuthenticationRequired)
                return .failure(.unauthorized)
            default:
//                 URLError(.unknown)
                return .failure(.unexpectedStatusCode)
            }
        } catch {
//          URLError(.unknown)
            return .failure(.networkingError)
        }
    }
}

