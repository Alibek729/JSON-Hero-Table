//
//  NetworkManager.swift
//  TableWithHero's
//
//  Created by Alibek Kozhambekov on 14.11.2022.
//

import Foundation

struct NetworkManager {
    
    func fetchHero(completion: @escaping ([HeroResponse]) -> Void) {
        let urlString = "https://cdn.jsdelivr.net/gh/akabab/superhero-api@0.3.0/api/all.json"
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching hero data \(error.localizedDescription)")
            } else {
                guard let safeData = data else { return }
                let decoder = JSONDecoder()
                
                do {
                    let heroData = try decoder.decode([HeroResponse].self, from: safeData)
                    completion(heroData)
                } catch {
                    print("Error in decodeing data \(error.localizedDescription)")
                }
            }
        }
        dataTask.resume()
    }
}
