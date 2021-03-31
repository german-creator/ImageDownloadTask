//
//  CommonInitTableViewCell.swift
//  ImageDownloadTask
//
//  Created by Герман Иванилов on 29.03.2021.
//

import UIKit


class CommonInitTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
    }
    
}
