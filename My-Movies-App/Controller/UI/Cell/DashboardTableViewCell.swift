//
//  DashboardTableViewCell.swift
//  My-Movies-App
//
//  Created by BOICOMP21070027 on 13/1/2565 BE.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {
    @IBOutlet weak var dotPageControl: UIPageControl!
    @IBOutlet weak var rotateCollectionView: UICollectionView!
    var indext = 0
    
    var viewModel = [DashboardModelElement]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rotateCollectionView.delegate = self
        rotateCollectionView.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2

        dotPageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
    
    @IBAction func pageControlSelectionAction(_ sender: UIPageControl) {
       let page: Int? = sender.currentPage
        var frame: CGRect = self.rotateCollectionView.frame
        frame.origin.x = frame.size.width * CGFloat(page ?? 0)
        frame.origin.y = 0
        self.rotateCollectionView.scrollRectToVisible(frame, animated: false)
    }
}


extension DashboardTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.count > 0 {
            return viewModel[indext].movies.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        if (indexPath == [0, 0]) {
//            switch
//        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rotateCell", for: indexPath)
        let imv = cell.viewWithTag(10) as! UIImageView
        imv.loadImageUsingCache(withUrl: self.viewModel[0].movies[indexPath.row].imageURL)
        imv.contentMode = .scaleAspectFit
        return cell
    }
    

}

extension DashboardTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        let height = self.rotateCollectionView.contentSize.height
        return CGSize(width: screenSize.width, height: height)
    }
}

class MeduimTableCell: UITableViewCell {
    var indext = 0
    @IBOutlet weak var titleLable: UILabel!
    var viewModel = [DashboardModelElement]()
    @IBOutlet weak var secondICollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        secondICollectionView.delegate = self
        secondICollectionView.dataSource = self
        secondICollectionView.layer.borderWidth = 1
        secondICollectionView.layer.borderColor = UIColor.gray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MeduimTableCell : UICollectionViewDelegate, UICollectionViewDataSource {
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
        
        //imv.frame = CGRect(x: 0,y: 0, width: imv.frame.width * 1.1 ,height: imv.frame.height*1.04);
//        imv.layer.borderWidth = 1
//        imv.layer.borderColor = UIColor.gray.cgColor
        
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

extension MeduimTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        let height = self.secondICollectionView.contentSize.height
        return CGSize(width: screenSize.width/3.2, height: height*0.85)
    }
}

class SmallTableCell: UITableViewCell {
    var indext = 0
    @IBOutlet weak var titleLable: UILabel!
    
    var viewModel = [DashboardModelElement]()
    @IBOutlet weak var secondICollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        secondICollectionView.delegate = self
        secondICollectionView.dataSource = self
        secondICollectionView.layer.borderWidth = 1
        secondICollectionView.layer.borderColor = UIColor.gray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension SmallTableCell : UICollectionViewDelegate, UICollectionViewDataSource {
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

extension SmallTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        let height = self.secondICollectionView.contentSize.height
        return CGSize(width: screenSize.width/2.4, height: height*0.80)
    }
    
}


let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        if url == nil {return}
        self.image = nil

        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }

        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init()
        activityIndicator.center = self.center
        addSubview(activityIndicator)
        activityIndicator.startAnimating()


        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                    activityIndicator.removeFromSuperview()
                }
            }

        }).resume()
    }
}
