//
//  HomeTableViewCell.swift
//  NewsApp_GizaSys
//
//  Created by Saber on 12/09/2021.
//

import UIKit

protocol  HomeCellViewProtocol {
    func config()
    
}
class HomeTableViewCell: UITableViewCell {

    @IBOutlet private weak var homeImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.layer.cornerRadius = 20
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(description: String, source: String){
        self.descriptionLabel.text = description
        self.sourceLabel.text = source
    }
    
}

extension HomeTableViewCell: HomeCellViewProtocol{
    func config() {
        
    }
}
