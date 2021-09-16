//
//  HomeTableViewCell.swift
//  NewsApp_GizaSys
//
//  Created by Saber on 12/09/2021.
//

import UIKit
import Kingfisher

protocol  HomeCellViewProtocol {
    func config(description: String, source: String, url: URL? )
    
}
class HomeTableViewCell: UITableViewCell {

    @IBOutlet private weak var homeImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    
    
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
    func configureCell(description: String, source: String, url: URL?){
        
        
        
    }
    private func showIndicator(){
        self.loader.isHidden = false
        self.loader.startAnimating()
    }
    private func hideIndicator(){
        loader.stopAnimating()
        self.loader.isHidden = true
        
    }
    
}

extension HomeTableViewCell: HomeCellViewProtocol{
    func config(description: String, source: String, url: URL? ) {
        self.descriptionLabel.text = description
        self.sourceLabel.text = source
        guard let url = url else {
            return
        }
        showIndicator()
        homeImageView.kf.setImage(with: url)
        hideIndicator()
    }
}
