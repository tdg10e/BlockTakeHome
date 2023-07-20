//
//  ServiceManager.swift
//  BlockTakeHome
//
//  Created by Tremaine Grant on 7/18/23.
//

import SwiftUI

enum ErrorCode: String {
    case unknown = "-1"
    case invalidURL = "1001"
    case networkError = "1002"
    case decodingError = "1003"
    case permissionsDenied = "1004"
    case malformedDataMissingTeam = "1005"
    case malformedDataMissingType = "1006"
    case malformedData = "1007"
    case noEmployees = "4000"
    case nilEmployeeObject = "4001"
}

class ServiceManager: ObservableObject {
    @Published var employees: [Employee] = []
    @Published var error: Error?
    @Published var errorCode: ErrorCode?
    
    func configure() async {
        await fetchEmployees()
    }
    
    func fetchEmployees() async {
        // With more time and option to install swift packages, I would opt to store this link on a secure server
        guard let url = URL(string: "https://s3.amazonaws.com/sq-mobile-interview/employees.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let employeesData = try decoder.decode([String: [Employee]].self, from: data)
            let employees = employeesData["employees"]
            
            if let empls = employees {
                if empls.isEmpty {
                    errorCode = .noEmployees
                }
                DispatchQueue.main.async {
                    self.employees = empls
                }
            } else {
                errorCode = .nilEmployeeObject
            }
        } catch {
            let errorCode: ErrorCode
            if let decodingError = error as? DecodingError {
                switch decodingError {
                case .keyNotFound(let key, _):
                    if key.stringValue == "team" {
                        errorCode = .malformedDataMissingTeam
                    } else if key.stringValue == "type" {
                        errorCode = .malformedDataMissingType
                    }else {
                        errorCode = .malformedData
                    }
                default:
                    errorCode = .decodingError
                }
            } else {
                errorCode = .unknown
            }
            
            self.errorCode = errorCode
            print("Error fetching or decoding employees: \(error.localizedDescription)")
        }
    }

    
    func fetchImage(with url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let imageURL = URL(string: url) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid image URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert data to image"])))
                return
            }
            
            completion(.success(image))
        }.resume()
    }
}

