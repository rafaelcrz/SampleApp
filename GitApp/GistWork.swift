//
//  API.swift

import Foundation

struct Gist: Codable {
    var description: String?
    var owner: Owner?
}

struct Owner: Codable {
    var login: String?
}

class API {

    func getGists(completion: @escaping (Gist?) -> Void) {
        let url: URL = URL(string: "https://api.github.com/gists/a88b2a942084c0e66b34d0db5f7cf2e5")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            let response: Gist = try! JSONDecoder().decode(Gist.self, from: data!)
            
            completion(response)
        }
        
        task.resume()
    }
}
