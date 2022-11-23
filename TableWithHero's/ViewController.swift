//
//  ViewController.swift
//  TableWithHero's
//
//  Created by Alibek Kozhambekov on 14.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var networkManager = NetworkManager()
    
    var tableHeroes: [HeroResponse]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var selectedIndex = 0

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        networkManager.fetchHero { heroes in
            self.tableHeroes = heroes
        }
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableHeroes?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "heroCell", for: indexPath)
        let heroModel = tableHeroes?[indexPath.row]
        cell.textLabel?.text = heroModel?.name
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Heroes"
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "detailView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailView" {
            if let detailVC = segue.destination as? HeroViewController {
                detailVC.heroName = tableHeroes![selectedIndex].name
                detailVC.heroImage = tableHeroes![selectedIndex].images.heroImage
            }
        }
    }
}



