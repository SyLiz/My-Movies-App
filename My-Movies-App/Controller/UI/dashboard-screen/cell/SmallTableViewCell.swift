//
//  SmallTableViewCell.swift
//  My-Movies-App
//
//  Created by BOICOMP21070027 on 15/1/2565 BE.
//

import UIKit


class SmallTableViewCell: UITableViewCell {
    var indext = 0
    @IBOutlet weak var titleLable: UILabel!
    var delegate:CallSegueFromCell?
    var viewModel = [DashboardModelElement]()
    @IBOutlet weak var smallCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        smallCollectionView.delegate = self
        smallCollectionView.dataSource = self
        smallCollectionView.layer.borderWidth = 1
        smallCollectionView.layer.borderColor = UIColor.gray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(viewModel[indext].movies[indexPath.row].name)
        delegate?.performSegueFromCell(senderObj: viewModel[indext].movies[indexPath.row])
    }
}

extension SmallTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.count > 0 {
            return viewModel[indext].movies.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "smallCell", for: indexPath)
        let imv = cell.viewWithTag(30) as! UIImageView
        imv.loadImageUsingCache(withUrl: self.viewModel[indext].movies[indexPath.row].imageURL)
        let text = cell.viewWithTag(31) as! UILabel
        text.text = self.viewModel[indext].movies[indexPath.row].name
        
        let view = cell.viewWithTag(25)!
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 9
        cell.layer.borderColor = UIColor.gray.cgColor
        return cell
    }
}

extension SmallTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        //let height = self.secondICollectionView.contentSize.height
        return CGSize(width: screenSize.width/2.5, height: screenSize.width/2.5)
    }
    
}
