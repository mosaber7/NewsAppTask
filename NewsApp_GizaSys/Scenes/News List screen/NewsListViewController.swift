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
    func presentAnAlert(error: Error)
}

class NewsListViewController: UIViewController {

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var homeTableView: UITableView!
    
    var presenter: NewsListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        title = "News"
        
        self.presenter?.viewDidLoad()

    }
   
    
    
    private func registerCell(){
        homeTableView.registerNib(cell: HomeTableViewCell.self)

    }


}

//MARK: - confiriming to NewsListViewProtocol
extension NewsListViewController: NewsListViewProtocol{
    
    func presentAnAlert(error: Error) {
        let alert = UIAlertController(title: "ATTENTION", message: error.localizedDescription, preferredStyle: .alert)
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
        cell.configureCell(description: self.presenter?.configureCell().0 ?? "", source: self.presenter?.configureCell().1 ?? "")
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.selectCell(at: indexPath)
    }
     
}




