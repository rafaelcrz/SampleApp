//
//  API.swift

import Foundation

protocol APIProtocol {
    func getGists(session: URLSession, endpoint: Endpoint, completion: @escaping (Result<Gist, GitAppError>) -> Void)
}

final class API: APIProtocol {
    
    func getGists(session: URLSession, endpoint: Endpoint, completion: @escaping (Result<Gist, GitAppError>) -> Void) {
        guard
            let _baseURL = endpoint.baseUrl,
            let url = URL(string: "\(_baseURL)\(endpoint.path)")
        else {
            completion(.failure(.urlError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        let task = session.dataTask(with: request) { data, response, error in
            if let data {
                do {
                    let response: Gist = try JSONDecoder().decode(Gist.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.parseError))
                }
            } else {
                completion(.failure(.requestError))
            }
        }
        
        task.resume()
    }
}
