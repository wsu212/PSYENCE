//
//  ListServiceType.swift
//  PSYENCE
//
//  Created by Wei-Lun Su on 2021/10/20.
//

import Foundation

protocol ListServiceType {
    var endpoint: Endpoint { get }
    func getList(at page: Int, completion: @escaping ((List?, Error?) -> Void))
}

final class ListService<T: List>: ListServiceType {
    private let token = "726999f05d914729d3ffb0cc5343a8fa"
    private let baseURL = "https://api.vimeo.com"
    private let decoder = JSONDecoder()
    
    let endpoint: Endpoint
    
    init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
    
    func getList(at page: Int, completion: @escaping ((List?, Error?) -> Void)) {
        guard let request = request(with: page) else {
            return
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
            } else if let data = data, let list = try? self.decoder.decode(T.self, from: data) {
                completion(list, nil)
            } else {
                completion(nil, nil)
            }
        }
        task.resume()
    }
    
    // MARK: - Private Helper Method
    
    private func request(with pageIndex: Int) -> URLRequest? {
        let requestURL = baseURL + endpoint.url + "?page=\(pageIndex)"
        guard let url = URL(string: requestURL) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}
