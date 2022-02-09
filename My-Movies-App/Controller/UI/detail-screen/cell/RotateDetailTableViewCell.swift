//
//  RotateDetailTableViewCell.swift
//  My-Movies-App
//
//  Created by BOICOMP21070027 on 8/2/2565 BE.
//

import UIKit

class RotateDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    var movieDetailViewModel:Movie?
    @IBOutlet weak var languageCollectionView: UICollectionView!
    @IBOutlet weak var dotPageControl: UIPageControl!
    @IBOutlet weak var rotateDetailCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        rotateDetailCollectionView.delegate = self
        rotateDetailCollectionView.dataSource = self
        rotateDetailCollectionView.layoutIfNeeded()
        languageCollectionView.delegate = self
        languageCollectionView.dataSource = self
        languageCollectionView.layoutIfNeeded()
        
    }
        override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let collectionView = scrollView as? UICollectionView {
            if collectionView.tag == 7 {
                let offSet = scrollView.contentOffset.x
                let width = scrollView.frame.width
                let horizontalCenter = width / 2
                dotPageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
            }
        }
    }
    
    @IBAction func dotSelected(_ sender: UIPageControl) {
        let page: Int? = sender.currentPage
         var frame: CGRect = self.rotateDetailCollectionView.frame
         frame.origin.x = frame.size.width * CGFloat(page ?? 0)
         frame.origin.y = 0
         self.rotateDetailCollectionView.scrollRectToVisible(frame, animated: false)
    }
    

}

extension RotateDetailTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource  {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == self.rotateDetailCollectionView {
                       if let manyImageCount = movieDetailViewModel?.imageUrls?.count {
                           dotPageControl.numberOfPages = manyImageCount
           
                           return manyImageCount
                       } else if (movieDetailViewModel?.imageURL != nil ) {
                           dotPageControl.numberOfPages = 1
                           return 1
                       } else {
                           dotPageControl.numberOfPages = 0
                           return 0 }
                   }
            if (movieDetailViewModel != nil) { return (movieDetailViewModel?.language.count)! }
            return 0
        }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rotateDetailCell", for: indexPath)
            if collectionView == self.rotateDetailCollectionView {
                cell.contentView.layoutIfNeeded()
                let imv = cell.viewWithTag(10) as! UIImageView
                if movieDetailViewModel?.imageUrls != nil {
                    imv.loadImageUsingCache(withUrl: self.movieDetailViewModel!.imageUrls![indexPath.row])
                    imv.contentMode = .scaleAspectFit
                } else {
                    imv.loadImageUsingCache(withUrl: self.movieDetailViewModel!.imageURL)
                    imv.contentMode = .scaleAspectFit
                }
            }
            if collectionView == self.languageCollectionView {
                let label = cell.viewWithTag(20) as! UILabel
                label.text = movieDetailViewModel?.language[indexPath.row].rawValue
            }
            return cell
        }

}




extension RotateDetailTableViewCell: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            if collectionView == self.rotateDetailCollectionView {
                let screenSize: CGRect = UIScreen.main.bounds
                let height = self.rotateDetailCollectionView.contentSize.height
                return CGSize(width: screenSize.width, height: height)
            }
            if collectionView == self.languageCollectionView {
                let screenSize: CGRect = UIScreen.main.bounds
                return CGSize(width: screenSize.width/3, height: 50)
            }
            return CGSize(width: 0, height: 0)
        }

}
