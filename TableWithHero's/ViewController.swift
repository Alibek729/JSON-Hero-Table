//
//  ViewController.swift
//  TableWithHero's
//
//  Created by Alibek Kozhambekov on 14.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var networkManager = NetworkManager()

    @IBOutlet weak var tableView: UITableView!
    
    var heroTable: [HeroTable]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.delegate = self
        tableView.dataSource = self
    }
}

struct HeroTable {
    let id: Int
    let name: String
    let image: UIImage
}

extension ViewController: NetworkManagerDelegate {
    func updateHero(with hero: HeroResponse) {
        for number in 1...731 {
            heroTable?.append(HeroTable(id: number, name: hero.name , image: hero.images.heroImage ?? UIImage()))
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "heroCell", for: indexPath)
        networkManager.getHero(with: indexPath.row)
        cell.textLabel?.text = heroTable![indexPath.section].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        heroTable!.count
    }
}

