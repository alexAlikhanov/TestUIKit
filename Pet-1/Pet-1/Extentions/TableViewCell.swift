//
//  TableViewCell.swift
//  Pet-1
//
//  Created by Алексей on 11/10/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    var postData : PostModel!
    
    private var collectionView : UICollectionView?

    private var userId : UILabel = {
        let userId = UILabel()
        return userId
    }()
    private var id : UILabel = {
        let id = UILabel()
        return id
    }()
    private var title : UILabel = {
        let title = UILabel()
        return title
    }()
    private var body : UILabel = {
        let body = UILabel()
        body.numberOfLines = 1
        return body
    }()

 
    
    func config(){
        
        userId.text = String(postData.userId)
        title.text = postData.title
        body.text = postData.body
    }
    
    override func prepareForReuse() {
        collectionView?.reloadData()
        let indexPath = IndexPath(item: 0, section: 0)
       collectionView?.scrollToItem(at: indexPath, at: .left, animated: false)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: "Cell")
        //selectionStyle = .none
        contentView.addSubview(userId)
        contentView.addSubview(id)
        contentView.addSubview(title)
        contentView.addSubview(body)
        createCollectionView()
    }
    
    private func createCollectionView(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 10, right: 10)
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: CGRect(x: 10, y: 10, width: 10, height: 10),  collectionViewLayout: layout)
        collectionView?.backgroundColor = nil
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView?.isPagingEnabled = true
        contentView.addSubview(collectionView ?? UICollectionView())
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        userId.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        body.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userId.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 5),
            userId.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 5),
            userId.widthAnchor.constraint(equalToConstant: contentView.safeAreaLayoutGuide.layoutFrame.size.width - 5)
        ])
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: userId.bottomAnchor, constant: 5),
            title.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 5),
            title.widthAnchor.constraint(equalToConstant: contentView.safeAreaLayoutGuide.layoutFrame.size.width - 5)
        ])
        NSLayoutConstraint.activate([
            body.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            body.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 5),
            body.widthAnchor.constraint(equalToConstant: contentView.safeAreaLayoutGuide.layoutFrame.size.width - 5)
        ])
        
        collectionView?.topAnchor.constraint(equalTo: body.bottomAnchor, constant: 5).isActive = true
        collectionView?.widthAnchor.constraint(equalToConstant: contentView.safeAreaLayoutGuide.layoutFrame.width - 50).isActive = true
        collectionView?.heightAnchor.constraint(equalToConstant: 300).isActive = true
        collectionView?.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor).isActive = true
    
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell {
            itemCell.postData = postData
            itemCell.config()
            return itemCell
        }
        print("error")
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: contentView.safeAreaLayoutGuide.layoutFrame.width - 60, height: 280)
        }
    
}
