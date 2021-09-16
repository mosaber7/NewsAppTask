//
//  ViewController.swift
//  NewsApp_GizaSys
//
//  Created by Saber on 12/09/2021.
//

import UIKit

protocol NewsListViewProtocol : AnyObject, NavigationRoute{
    var presenter: NewsListPresenterProtocol?{set get}
    func reloadData()
    func presentAnAlert(error: String)
    func showIndicator()
    func hideIndicator()
}

class NewsListViewController: UIViewController {

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var homeTableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var presenter: NewsListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        title = "News"
        presenter?.viewDidLoad()
        
    }
   
    
    
    private func registerCell(){
        homeTableView.registerNib(cell: HomeTableViewCell.self)

    }

     func showIndicator(){
        self.loader.isHidden = false
        self.loader.startAnimating()
    }
     func hideIndicator(){
        loader.stopAnimating()
        self.loader.isHidden = true
        
    }

}

//MARK: - confiriming to NewsListViewProtocol
extension NewsListViewController: NewsListViewProtocol{
    
    func presentAnAlert(error: String) {
        let alert = UIAlertController(title: "ATTENTION", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style:.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func reloadData() {
        homeTableView.reloadData()
    }
}

//MARK: - tableView setup
extension NewsListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter?.numberOfRowsInSection ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeue() as HomeTableViewCell
        self.presenter?.configureCell(cell: cell, index: indexPath.row)
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.selectCell(at: indexPath)
    }
     
}
extension NewsListViewController: UISearchBarDelegate{
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let topic = searchBar.text, topic != "" else {
            return
        }
        self.presenter?.searchNews(with: topic)
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let topic = searchBar.text, topic != "" else {
            return
        }
        self.presenter?.searchNews(with: topic)
    }
}




