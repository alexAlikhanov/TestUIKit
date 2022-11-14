//
//  CollectionViewCell.swift
//  Pet-1
//
//  Created by Алексей on 11/12/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    let networkManager = NetworkManager()
    private let loadIndicator = UIActivityIndicatorView()
    let a = UIScrollView()
    var postData : PostModel!
    var imageView : UIImageView = {
       var img = UIImageView()
        img.layer.cornerRadius = 10
        img.contentMode = .scaleAspectFill
        img.layer.masksToBounds = true
        return img
    }()
    
    override init(frame: CGRect) {
        super .init(frame: CGRect(x: 5, y: 5, width: 100, height: 100))
        backgroundColor = .white
        layer.cornerRadius = 10
        imageView.frame = CGRect(x: 2, y: 2, width: 150, height: 200)
        contentView.addSubview(imageView)
        contentView.addSubview(loadIndicator)
        
    }
    func config(){
        loadIndicator.startAnimating()
        networkManager.getFirstPhotoInAlbumBy(id: postData.userId) { [weak self] data in
            DispatchQueue.main.async {
                self?.imageView.image = UIImage(data: data)
                self?.loadIndicator.stopAnimating()
            }
        }
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        loadIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        loadIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        loadIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        
    }
}
