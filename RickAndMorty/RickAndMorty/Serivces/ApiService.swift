import Foundation

class APIClient {
    static let baseURL = "http://127.0.0.1:8000/api/"

    static func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)characters/") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let characters = try JSONDecoder().decode([Character].self, from: data)
                completion(.success(characters))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }

    static func fetchEpisodes(completion: @escaping (Result<[Episode], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)episodes/") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let episodes = try JSONDecoder().decode([Episode].self, from: data)
                completion(.success(episodes))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }

    static func fetchLocations(completion: @escaping (Result<[Location], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)locations/") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let locations = try JSONDecoder().decode([Location].self, from: data)
                completion(.success(locations))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    static func fetchCharactersWithParams(params: [String: String], completion: @escaping (Result<[Character], Error>) -> Void) {
            var urlString = "\(baseURL)characters/"
            
            if !params.isEmpty {
                let queryString = params.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
                urlString += "?\(queryString)"
            }
            
            guard let url = URL(string: urlString) else { return }
            
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let characters = try JSONDecoder().decode([Character].self, from: data)
                    completion(.success(characters))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    static func fetchLocationsWithParams(params: [String: String], completion: @escaping (Result<[Location], Error>) -> Void) {
            var urlString = "\(baseURL)locations/"
            
            if !params.isEmpty {
                let queryString = params.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
                urlString += "?\(queryString)"
            }
            
            guard let url = URL(string: urlString) else { return }
            
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let locations = try JSONDecoder().decode([Location].self, from: data)
                    completion(.success(locations))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }

    static func fetchAvailableTypes(completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)characters/types/") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                // Assuming the backend returns a list of types as strings
                let types = try JSONDecoder().decode([String].self, from: data)
                completion(.success(types))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    static func fetchEpisodesWithParams(params: [String: String], completion: @escaping (Result<[Episode], Error>) -> Void) {
        var urlString = "\(baseURL)episodes/"
        
        if !params.isEmpty {
            let queryString = params.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
            urlString += "?\(queryString)"
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let episodes = try JSONDecoder().decode([Episode].self, from: data)
                completion(.success(episodes))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    

}
