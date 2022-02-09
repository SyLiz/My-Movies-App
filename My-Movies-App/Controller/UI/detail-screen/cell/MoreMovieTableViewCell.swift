//
//  morelikeTableViewCell.swift
//  My-Movies-App
//
//  Created by BOICOMP21070027 on 9/2/2565 BE.
//

import UIKit

class MoreMovieTableViewCell: UITableViewCell {
    @IBOutlet weak var moreMovieCollectionView: UICollectionView!
    var movieDetailViewModel:Movie?
    override func awakeFromNib() {
        super.awakeFromNib()
        moreMovieCollectionView.delegate = self
        moreMovieCollectionView.dataSource = self
        moreMovieCollectionView.layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension MoreMovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieDetailViewModel?.more?.movies.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moreMovieCollectionCell", for: indexPath)
        let imv = cell.viewWithTag(20) as! UIImageView
        imv.loadImageUsingCache(withUrl: (self.movieDetailViewModel!.more?.movies[indexPath.row].imageURL)!)
        let label = cell.viewWithTag(21) as! UILabel
        label.text = movieDetailViewModel?.more?.movies[indexPath.row].name
        return cell
    }
    
}
