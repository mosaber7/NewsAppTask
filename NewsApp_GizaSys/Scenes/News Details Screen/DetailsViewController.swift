//
//  DetailsViewController.swift
//  NewsApp_GizaSys
//
//  Created by Saber on 12/09/2021.
//

import UIKit
import Kingfisher

protocol DetailsViewProtocol: AnyObject{
    var presenter: DetailsPresenterProtocol? {get}
    func present(view: UIViewController)
    
    
}

class DetailsViewController: UIViewController {
    @IBOutlet private weak var articleImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var goToSourceBtn: UIButton!
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    
    var presenter: DetailsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView(){
        title = self.presenter?.title
        descriptionLabel.text = self.presenter?.description
        contentLabel.text = self.presenter?.content
        guard let url = self.presenter?.imageUrl else {
            return
        }
        loader.isHidden = false
        loader.startAnimating()
            self.articleImageView.kf.setImage(with: url)
            self.loader.stopAnimating()
            self.loader.isHidden = true
        
    }
    
    @IBAction func sourceButtonClicked(_ sender: UIButton) {
        self.presenter?.webNavigate()
    }
    
}

extension DetailsViewController: DetailsViewProtocol{
    func present(view: UIViewController) {
        present(view, animated: true, completion: nil)
    }
    
    
    
}
