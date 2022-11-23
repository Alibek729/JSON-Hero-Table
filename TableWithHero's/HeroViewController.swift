//
//  HeroViewController.swift
//  TableWithHero's
//
//  Created by Alibek Kozhambekov on 14.11.2022.
//

import UIKit

class HeroViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var heroImage: UIImage?
    var heroName: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = heroImage
        nameLabel.text = heroName
    }

}
