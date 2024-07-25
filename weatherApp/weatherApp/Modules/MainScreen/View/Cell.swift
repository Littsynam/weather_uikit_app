//
//  Cell.swift
//  weatherApp
//
//  Created by Mastery on 12.07.2024.
//

import Foundation
import UIKit

class ForecastCell: UICollectionViewCell {
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    func configur(tittle:String, subtittle:String){
        topLabel.text = tittle
        bottomLabel.text = subtittle
        
        if let temperature = Double(subtittle.replacingOccurrences(of: " °C", with: "")) {
            if temperature > 0 {
                bottomLabel.textColor = .red
            } else {
                bottomLabel.textColor = .blue
            }
        }
    }
}
