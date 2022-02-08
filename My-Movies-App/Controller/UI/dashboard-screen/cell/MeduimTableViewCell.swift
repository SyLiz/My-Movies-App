//
//  MediumTableViewCell.swift
//  My-Movies-App
//
//  Created by BOICOMP21070027 on 15/1/2565 BE.
//

import UIKit

class MeduimTableViewCell: UITableViewCell {
    var indext = 0
    @IBOutlet weak var titleLable: UILabel!
    var viewModel = [DashboardModelElement]()
    @IBOutlet weak var MediumCollectionView: UICollectionView!
    var delegate:CallSegueFromCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        MediumCollectionView.delegate = self
        MediumCollectionView.dataSource = self
        MediumCollectionView.layer.borderWidth = 1
        MediumCollectionView.layer.borderColor = UIColor.gray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(viewModel[indext].movies[indexPath.row].name)
        delegate?.performSegueFromCell(senderObj: viewModel[indext].movies[indexPath.row])
    }
}

extension MeduimTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.count > 0 {
            return viewModel[indext].movies.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediumCell", for: indexPath)
        
        let imv = cell.viewWithTag(20) as! UIImageView
        imv.loadImageUsingCache(withUrl: self.viewModel[indext].movies[indexPath.row].imageURL)
        
        let view = cell.viewWithTag(25)!
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        
        let text = cell.viewWithTag(21) as! UILabel
        text.text = self.viewModel[indext].movies[indexPath.row].name
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 9
        cell.layer.borderColor = UIColor.gray.cgColor
        return cell
    }
}
