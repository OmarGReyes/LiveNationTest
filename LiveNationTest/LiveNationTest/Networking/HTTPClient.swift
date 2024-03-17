//
//  HTTPClient.swift
//  LiveNationTest
//
//  Created by Omar Gonzalez on 16/03/24.
//

import Foundation

// MARK: - HttpClient Protocol
protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
}

// MARK: - HttpClient default implementation
extension HTTPClient {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async -> Result<T, RequestError> {
        // MARK: urlComponents
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems?.map({ (key: String, value: String) in
            URLQueryItem(name: key, value: value)
        })
        
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }
        
        // MARK: Request
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        // MARK: URLSession Configutarion
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForResource = Constants.networkTimeoutInterval
        let session = URLSession(configuration: sessionConfig)
        
        // MARK: Request execution
        do {
            let (data, response) = try await session.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    return .failure(.decode)
                }
                return .success(decodedResponse)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.networkingError)
        }
    }
}

