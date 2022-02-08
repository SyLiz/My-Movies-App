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
        //dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
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
        return countLayout
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var identifier = ""
        if (indexPath.row == 0) { identifier = "tableRotateCell" }
        else if (indexPath.row == 1) {
            if (movieDetailViewModel?.trailer != nil) {
                identifier = "trailerCell"
            } else {
                identifier = ""
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
                buildcell.dateLabel.text = convertDate(dateValue: Int(movieDetailViewModel!.startDate)!)
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
        return cell
    }
}




//extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if let collectionView = scrollView as? UICollectionView {
//            if collectionView.tag == 7 {
//                let offSet = scrollView.contentOffset.x
//                let width = scrollView.frame.width
//                let horizontalCenter = width / 2
//                dotPageControlDetail.currentPage = Int(offSet + horizontalCenter) / Int(width)
//            }
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == self.rotateDetailCollectionView {
//            if let manyImageCount = movieDetailViewModel?.imageUrls?.count {
//                dotPageControlDetail.numberOfPages = manyImageCount
//
//                return manyImageCount
//            } else if (movieDetailViewModel?.imageURL != nil ) {
//                dotPageControlDetail.numberOfPages = 1
//                return 1
//            } else {
//                dotPageControlDetail.numberOfPages = 0
//                return 0 }
//        }
//        return (movieDetailViewModel?.language.count)!
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rotateDetailCell", for: indexPath)
//        if collectionView == self.rotateDetailCollectionView {
//            cell.contentView.layoutIfNeeded()
//            let imv = cell.viewWithTag(10) as! UIImageView
//            if movieDetailViewModel?.imageUrls != nil {
//                imv.loadImageUsingCache(withUrl: self.movieDetailViewModel!.imageUrls![indexPath.row])
//                imv.contentMode = .scaleAspectFit
//            } else {
//                imv.loadImageUsingCache(withUrl: self.movieDetailViewModel!.imageURL)
//                imv.contentMode = .scaleAspectFit
//            }
//
//        }
//        if collectionView == self.languageCollectionView {
//            let label = cell.viewWithTag(20) as! UILabel
//            label.text = movieDetailViewModel?.language[indexPath.row].rawValue
//        }
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView == self.rotateDetailCollectionView {
//            let screenSize: CGRect = UIScreen.main.bounds
//            let height = self.rotateDetailCollectionView.contentSize.height
//            return CGSize(width: screenSize.width, height: height)
//        }
//        if collectionView == self.languageCollectionView {
//            let screenSize: CGRect = UIScreen.main.bounds
//            let height = self.languageCollectionView.contentSize.height
//            return CGSize(width: screenSize.width/3, height: height*0.834)
//        }
//        return CGSize(width: 0, height: 0)
//    }
//}
