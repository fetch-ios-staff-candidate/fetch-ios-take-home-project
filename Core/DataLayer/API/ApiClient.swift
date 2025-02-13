//
//  ApiClient.swift
//  DataLayer
//
//  Created by Dalton Hinterscher on 2/12/25.
//

import UIKit

public enum HTTPMethod: String {
    case get = "GET"
}

open class ApiClient {
    
    public enum ApiClientError: Error {
        case http(_ response: HTTPURLResponse, _ body: String? = nil)
        case unexpectedResponseType(_ response: URLResponse)
    }
    
    private lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config, delegate: nil, delegateQueue: nil)
    }()
    
    private let baseUrl: String
    private let jsonDecoder: JSONDecoder
    
    public init(
        baseUrl: String,
        jsonDecoder: JSONDecoder
    ) {
        self.baseUrl = baseUrl
        self.jsonDecoder = jsonDecoder
    }
    
    public func `get`<T: Decodable>(_ path: String) async throws -> T {
        try await sendNoBody(path, method: HTTPMethod.get)
    }
    
    @discardableResult
    private func processResponse(
        _ response: URLResponse,
        data: Data
    ) throws -> HTTPURLResponse {
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiClientError.unexpectedResponseType(response)
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            let body = String(data: data, encoding: .utf8) ?? String(data: data, encoding: .macOSRoman)!
            throw ApiClientError.http(httpResponse, body)
        }
        
        return httpResponse
    }
    
    private func sendNoBody<T: Decodable>(_ path: String, method: HTTPMethod) async throws -> T {
        var request = URLRequest(url: URL(string: "\(baseUrl)\(path)")!)
        request.httpMethod = method.rawValue
        return try await execute(request)
    }
    
    // MARK: - Request Executions
    
    private func execute(_ request: URLRequest) async throws -> HTTPURLResponse {
        let (data, response) = try await session.data(for: request)
        let httpResponse = try processResponse(response, data: data)
        return httpResponse
    }
    
    private func execute<T: Decodable>(_ request: URLRequest) async throws -> T {
        try await execute(request) { request in
            try await session.data(for: request)
        }
    }
    
    private func execute<T: Decodable>(
        _ request: URLRequest,
        block: (URLRequest) async throws -> (Data, URLResponse),
        allowRetry: Bool = true
    ) async throws -> T {
        
        do {
            let (data, response) = try await block(request)
            try processResponse(response, data: data)
            return try jsonDecoder.decode(T.self, from: data)
        } catch DecodingError.dataCorrupted(let context) {
            throw DecodingError.dataCorrupted(context)
        } catch {
            throw error
        }
    }
    
}
