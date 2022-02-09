//
//  ViewController.swift
//  My-Movies-App
//
//  Created by BOICOMP21070027 on 12/1/2565 BE.
//

import UIKit

protocol CallSegueFromCell{
    func performSegueFromCell(senderObj:Movie)
}

class DashboardViewController: UIViewController, FetchHomePageDelegate , CallSegueFromCell {
    
    var identifierSegue = "DashboardToDetail"
    func performSegueFromCell(senderObj: Movie) {
        performSegue(withIdentifier: identifierSegue, sender: senderObj)
    }
    
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
        //performSegue(withIdentifier: "DashboardToDetail", sender: "test")
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "DashboardToDetail") {
            if let nextViewController = segue.destination as? DetailViewController {
                nextViewController.movieDetailViewModel = sender as? Movie
            }
        }
    }
}

extension DashboardViewController: UITableViewDelegate,UITableViewDataSource {
    
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
            let buildcell = cell as! RotateTableViewCell
            buildcell.viewModel = viewModel
            buildcell.dotPageControl.numberOfPages = viewModel[indexPath.row].movies.count
            buildcell.contentView.frame = cell.bounds
            buildcell.contentView.layoutIfNeeded()
            buildcell.delegate = self
            buildcell.rotateCollectionView.reloadData()
        case ("title","medium"):
            let buildcell = cell as! MeduimTableViewCell
            buildcell.indext = indexPath.row
            buildcell.viewModel = viewModel
            buildcell.titleLable.text = viewModel[indexPath.row].title
            buildcell.contentView.frame = cell.bounds
            buildcell.contentView.layoutIfNeeded()
            buildcell.delegate = self
            buildcell.MediumCollectionView.reloadData()
        case ("title","small"):
            let buildcell = cell as! SmallTableViewCell
            buildcell.indext = indexPath.row
            buildcell.viewModel = viewModel
            buildcell.titleLable.text = viewModel[indexPath.row].title
            buildcell.delegate = self
            buildcell.smallCollectionView.reloadData()
        case (_, _):
            return UITableViewCell()
        }
        
       return cell
    }
}


