//
//  WebService.swift
//  DataLayer
//
//  Created by Dalton Hinterscher on 2/12/25.
//

open class WebService<Path: WebServicePath> {

    // MARK: - Variables
    
    private let api: ApiClient
    
    // MARK: - Initializers
    
    public init(api: ApiClient) {
        self.api = api
    }
    
    // MARK: - Public Interface
    
    public func get<T: Decodable>(_ path: Path) async throws -> T {
        try await api.get(path.path)
    }
}

public protocol WebServicePath {
    var path: String { get }
}

