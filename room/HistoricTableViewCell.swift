//
//  HistoricTableViewCell.swift
//  room
//
//  Created by Vamsi Ravula on 12/3/21.
//

import UIKit

class HistoricTableViewCell: UITableViewCell {

    @IBOutlet weak var Histime: UILabel!
    @IBOutlet weak var Histemp: UILabel!
    @IBOutlet weak var Hishumi: UILabel!
    
    func setatmos(atmosrow: HistoricJSON) {
        Histime.text = String (atmosrow.Historictime)
        Histemp.text = String (atmosrow.Historictemperature)
        Hishumi.text = String (atmosrow.Historichumidity)
       }
    
}
