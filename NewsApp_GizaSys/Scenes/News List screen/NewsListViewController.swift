//
//  ViewController.swift
//  NewsApp_GizaSys
//
//  Created by Saber on 12/09/2021.
//

import UIKit

protocol NewsListViewProtocol : AnyObject{
    var presenter: NewsListPresenterProtocol?{set get}
}

class NewsListViewController: UIViewController {

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var homeTableView: UITableView!
    
    var presenter: NewsListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        title = "Home"
        
        NewsRequestsFactory.retrieveDaysNews(modelType: Article.self) { (responce) in
            
        } failureBlock: { (error) in
            print("jjjjj\(error)")
        }
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        homeTableView.frame = homeTableView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    
    private func registerCell(){
        homeTableView.registerNib(cell: HomeTableViewCell.self)

    }


}

//MARK: - confiriming to NewsListViewProtocol
extension NewsListViewController: NewsListViewProtocol{
    
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
     
}




