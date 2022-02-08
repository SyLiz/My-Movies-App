//
//  DashboardTableViewCell.swift
//  My-Movies-App
//
//  Created by BOICOMP21070027 on 13/1/2565 BE.
//

import UIKit

class RotateTableViewCell: UITableViewCell {
    @IBOutlet weak var dotPageControl: UIPageControl!
    @IBOutlet weak var rotateCollectionView: UICollectionView!
    var indext = 0
    var delegate:CallSegueFromCell?
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print(viewModel[indext].movies[indexPath.row].name)
        delegate?.performSegueFromCell(senderObj: viewModel[indext].movies[indexPath.row])
    }
}


extension RotateTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.count > 0 {
            return viewModel[indext].movies.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rotateCell", for: indexPath)
        let imv = cell.viewWithTag(10) as! UIImageView
        imv.loadImageUsingCache(withUrl: self.viewModel[0].movies[indexPath.row].imageURL)
        imv.contentMode = .scaleAspectFit
        return cell
    }
    

}

extension RotateTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        let height = self.rotateCollectionView.contentSize.height
        return CGSize(width: screenSize.width, height: height)
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

