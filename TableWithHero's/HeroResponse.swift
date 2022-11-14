//
//  HeroResponse.swift
//  TableWithHero's
//
//  Created by Alibek Kozhambekov on 14.11.2022.
//

import Foundation
import UIKit

struct HeroResponse: Decodable {
    let id: Int
    let name: String
    let images: HeroImage
}

struct HeroImage: Decodable {
    let sm: String
    var heroImage: UIImage? {
        guard let imageURL = URL(string: sm),
              let imageData =  try? Data(contentsOf: imageURL) else { return nil}
        return UIImage(data: imageData)
    }
}
