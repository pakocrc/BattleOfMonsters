//
//  NetworkClient.swift
//  BattleOfMonsters
//
//  Created by Francisco Cordoba on 18/9/24.
//

import Foundation

enum NetworkClientUrlType: String {
    case monsters
    case battle
}

protocol NetworkClient {
    func getMonsters(completion: @escaping (Result<[Monster?], Error>) -> Void)
    func battle(battleBody: BattleBody, completion: @escaping (Result<Battle, Error>) -> Void)
}

final class ApiNetworkClient: NetworkClient {
    private let baseUrl = "http://localhost:8080/"
    private var session: URLSession

    init(session: URLSession = URLSession.shared) {
        if ProcessInfo.processInfo.environment["ISTESTING"] == "true" {
            let configuration = URLSessionConfiguration.ephemeral
            configuration.protocolClasses = [URLProtocolMock.self]
            self.session = URLSession(configuration: configuration)
        } else {
            self.session = session
        }
    }

    func getMonsters(completion: @escaping (Result<[Monster?], Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)\(NetworkClientUrlType.monsters)") else {
            completion(.failure(ClientError.badUrl))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

//        if ProcessInfo.processInfo.environment["ISTESTING"] == "true" {
//            // Your code that should run under tests
//            let services = BattleOfMonstersServices()
//
//            services.getMonsters(forResource: forResource){ (result) in
//                switch result {
//                case .success(let data):
//                    URLProtocolMock.requestHandler = { request in
//                        return (HTTPURLResponse(), data)
//                    }
//                case .failure(let error):
//                    URLProtocolMock.requestHandler = { request in
//                        throw error
//                    }
//                }
//            }
//        }
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }

            guard let data = data else {
                completion(.failure(ClientError.badData))
                return
            }

            guard let apiResponse = try? JSONDecoder().decode(ApiResponse.self, from: data) else {
                completion(.failure(NSError()))
                return
            }

            if let monsters = apiResponse.monsters {
                completion(.success(monsters))
            }
        }

        task.resume()
    }

    func battle(battleBody: BattleBody, completion: @escaping (Result<Battle, Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)\(NetworkClientUrlType.battle)") else {
            completion(.failure(ClientError.badUrl))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(battleBody)
        } catch {
            completion(.failure(ClientError.badEncoding))
        }

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(ClientError.badData))
                return
            }

            guard let apiResponse = try? JSONDecoder().decode(BattleApiResponse.self, from: data) else {
                completion(.failure(NSError()))
                return
            }

            if let battle = apiResponse.battle {
                completion(.success(battle))
            }
        }

        task.resume()
    }
}

enum ClientError: String, Error {
    case badUrl = "Bad url"
    case badEncoding = "Error encoding request's body"
    case badData = "Bad data"
    case badRequestBody = "Error in the request's body"
}
