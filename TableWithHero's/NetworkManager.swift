//
//  NetworkManager.swift
//  TableWithHero's
//
//  Created by Alibek Kozhambekov on 14.11.2022.
//

import Foundation

protocol NetworkManagerDelegate {
    func updateHero(with hero: HeroResponse)
}

struct NetworkManager {
    
    var delegate: NetworkManagerDelegate?
    
    func getHero(with id: Int) {
        let urlString = "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/id/\(id).json"
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error in data request: \(error.localizedDescription)")
            } else {
                guard let safeData = data else { return }
                decoder(with: safeData)
            }
        }
        task.resume()
    }
    
    private func decoder(with data: Data) {
        let decoder = JSONDecoder()
        do {
            let responseModel = try decoder.decode(HeroResponse.self, from: data)
            DispatchQueue.main.async {
                delegate?.updateHero(with: responseModel)
            }
        } catch {
            print("Error in parcing data: \(error.localizedDescription)")
        }
    }
}
