//
//  DetailViewController.swift
//  My-Movies-App
//
//  Created by BOICOMP21070027 on 15/1/2565 BE.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailTableView: UITableView!
    var movieDetailViewModel:Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = movieDetailViewModel?.name
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.allowsSelection = false
    }
    
    func convertDate(dateValue: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(dateValue))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy / MM / dd" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countLayout:Int = 1
        if (movieDetailViewModel?.trailer != nil) { countLayout += 1 }
        if (movieDetailViewModel?.more != nil) { countLayout += 1 }
        return countLayout
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var identifier = ""
        if (indexPath.row == 0) { identifier = "tableRotateCell" }
        else if (indexPath.row == 1) {
            if (movieDetailViewModel?.trailer != nil) {
                identifier = "trailerCell"
            }
        }
        else {
            if (movieDetailViewModel?.more != nil && movieDetailViewModel?.more?.movies.count ?? 0 > 0 ) {
                identifier = "moreMovieTableCell"
            }
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        else {
            return UITableViewCell()
        }
        if (identifier == "tableRotateCell") {
            let buildcell = cell as! RotateDetailTableViewCell
            buildcell.movieDetailViewModel = movieDetailViewModel
            buildcell.contentView.frame = cell.bounds
            buildcell.contentView.layoutIfNeeded()
            buildcell.rotateDetailCollectionView.reloadData()
            buildcell.languageCollectionView.reloadData()
            if (movieDetailViewModel != nil) {
                var date = "No data"
                if (!movieDetailViewModel!.startDate.isEmpty) {
                    date = convertDate(dateValue: Int(movieDetailViewModel!.startDate)!)
                }
                buildcell.dateLabel.text = date
                buildcell.detailLabel.text = movieDetailViewModel?.movieDescription
                var category = ""
                for item in movieDetailViewModel!.category {
                    if (item == movieDetailViewModel!.category.last) { category += item.rawValue }
                    else { category += "\(item.rawValue)\n" }
                }
                buildcell.categoryLabel.text = category
            }
        }
        else if (identifier == "trailerCell") {
            let imv = cell.viewWithTag(10) as! UIImageView
            cell.contentView.frame = cell.bounds
            cell.contentView.layoutIfNeeded()
            if movieDetailViewModel?.imageUrls != nil {
                imv.loadImageUsingCache(withUrl: self.movieDetailViewModel!.imageUrls![indexPath.row])
                imv.contentMode = .scaleAspectFit
            } else {
                imv.loadImageUsingCache(withUrl: self.movieDetailViewModel!.imageURL)
                imv.contentMode = .scaleAspectFit
            }
            let label = cell.viewWithTag(11) as! UILabel
            label.text = movieDetailViewModel?.name
        }
        else if (identifier == "moreMovieTableCell") {
            let buildcell = cell as! MoreMovieTableViewCell
            buildcell.movieDetailViewModel = movieDetailViewModel
            buildcell.contentView.frame = cell.bounds
            buildcell.contentView.layoutIfNeeded()
            buildcell.moreMovieCollectionView.reloadData()
        }
        return cell
    }
}
