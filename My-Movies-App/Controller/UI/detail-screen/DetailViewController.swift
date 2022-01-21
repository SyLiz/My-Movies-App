//
//  DetailViewController.swift
//  My-Movies-App
//
//  Created by BOICOMP21070027 on 15/1/2565 BE.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var languageCollectionView: UICollectionView!
    @IBOutlet weak var rotateDetailCollectionView: UICollectionView!
    @IBOutlet weak var categoryLabel: UILabel!
    var movieDetailViewModel:Movie?
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        navigationItem.title = movieDetailViewModel?.name
        rotateDetailCollectionView.delegate = self
        rotateDetailCollectionView.dataSource = self
        rotateDetailCollectionView.layoutIfNeeded()
        rotateDetailCollectionView.reloadData()
        
        languageCollectionView.delegate = self
        languageCollectionView.dataSource = self
        languageCollectionView.layoutIfNeeded()
        languageCollectionView.reloadData()

        //startDateLabel.text
        if let strToIntDate = Int(movieDetailViewModel!.startDate) {
            startDateLabel.text = convertDate(dateValue: strToIntDate)
        }
        
        detailLabel.text = movieDetailViewModel?.movieDescription
//        detailLabel.text! += "Japanese (日本語, Nihongo [ɲihoŋɡo] (audio speaker iconlisten)) is an East Asian language spoken by about 128 million people, primarily in Japan, where it is the national language. It is a member of the Japonic (or Japanese-Ryukyuan) language family, and its ultimate derivation and relation to other languages is unclear. Japonic languages have been grouped with other language families such as Ainu, Austroasiatic, Korean, and the now-discredited Altaic, but none of these proposals have gained widespread acceptance"
        
        //categoryLabel.text
        var categoryManyLine = ""
        for index in 0...movieDetailViewModel!.category.count-1 {
            if (index % 2 == 1){
                categoryManyLine += "\n"
            }
            categoryManyLine += movieDetailViewModel!.category[index].rawValue
        }
        categoryLabel.text = categoryManyLine
        
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

extension UIView {

  @IBInspectable var cornerRadius: CGFloat {

   get{
        return layer.cornerRadius
    }
    set {
        layer.cornerRadius = newValue
        layer.masksToBounds = newValue > 0
    }
  }

  @IBInspectable var borderWidth: CGFloat {
    get {
        return layer.borderWidth
    }
    set {
        layer.borderWidth = newValue
    }
  }

  @IBInspectable var borderColor: UIColor? {
    get {
        return UIColor(cgColor: layer.borderColor!)
    }
    set {
        layer.borderColor = newValue?.cgColor
    }
  }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if collectionView == self.rotateDetailCollectionView {
            if let manyImageCount = movieDetailViewModel?.imageUrls?.count {
                return manyImageCount
            } else if (movieDetailViewModel?.imageURL != nil ) {
                return 1
            } else { return 0 }
        }
        
        return (movieDetailViewModel?.language.count)!
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
        else {
           
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.rotateDetailCollectionView {
            let screenSize: CGRect = UIScreen.main.bounds
            let height = self.rotateDetailCollectionView.contentSize.height
            return CGSize(width: screenSize.width, height: height)

        }
        if collectionView == self.languageCollectionView {
            let screenSize: CGRect = UIScreen.main.bounds
            let height = self.languageCollectionView.contentSize.height
            return CGSize(width: screenSize.width/3, height: height)

        }
        return CGSize(width: 0, height: 0)
    }
}
