//
//  ViewController.swift
//  My-Movies-App
//
//  Created by BOICOMP21070027 on 12/1/2565 BE.
//

import UIKit

class ViewController: UIViewController, FetchHomePageDelegate {
    var fetchData = NetworkController()
    var viewModel = [DashboardModelElement]()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        fetchData.fetchData()
    }

    
    func didHomeDataLoaded(_ dashboardModel: DashboardModel) {
        viewModel.append(contentsOf: dashboardModel)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
    
    
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var identifier = ""
        switch (viewModel[indexPath.row].type , viewModel[indexPath.row].size) {
        case ("rotate","big"):
            identifier = "tableRotateCell"
        case ("title","medium"):
            identifier = "tableMediumCell"
        case ("title","small"):
            identifier = "tableSmallCell"
        case (_, _):
            return UITableViewCell()
        }
       guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        else {
            return UITableViewCell()
        }
        switch (viewModel[indexPath.row].type , viewModel[indexPath.row].size) {
        case ("rotate","big"):
            let buildcell = cell as! DashboardTableViewCell
            buildcell.viewModel = viewModel
            buildcell.dotPageControl.numberOfPages = viewModel[indexPath.row].movies.count
            buildcell.contentView.frame = cell.bounds
            buildcell.contentView.layoutIfNeeded()
            buildcell.rotateCollectionView.reloadData()
        case ("title","medium"):
            let buildcell = cell as! MeduimTableCell
            buildcell.indext = indexPath.row
            buildcell.viewModel = viewModel
            buildcell.titleLable.text = viewModel[indexPath.row].title
            buildcell.contentView.frame = cell.bounds
            buildcell.contentView.layoutIfNeeded()
            buildcell.secondICollectionView.reloadData()
        case ("title","small"):
            let buildcell = cell as! SmallTableCell
            buildcell.indext = indexPath.row
            buildcell.viewModel = viewModel
            buildcell.titleLable.text = viewModel[indexPath.row].title
            buildcell.contentView.frame = cell.bounds
            buildcell.contentView.layoutIfNeeded()
            buildcell.secondICollectionView.reloadData()
        case (_, _):
            return UITableViewCell()
        }
        
       return cell
    }
}


