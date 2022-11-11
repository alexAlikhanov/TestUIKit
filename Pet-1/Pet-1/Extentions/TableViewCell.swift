//
//  TableViewCell.swift
//  Pet-1
//
//  Created by Алексей on 11/10/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var data : PostModel!
    private let loadIndicator = UIActivityIndicatorView()
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
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
        return body
    }()

 
    
    func config(){
        userId.text = String(data.userId)
        title.text = data.title
        body.text = data.body
    }
    
    override func prepareForReuse() {
        //myImageView.image = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: "Cell")
        //contentView.addSubview(myImageView)
        //contentView.addSubview(loadIndicator)
        //selectionStyle = .none
        contentView.addSubview(userId)
        contentView.addSubview(id)
        contentView.addSubview(title)
        contentView.addSubview(body)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        loadIndicator.translatesAutoresizingMaskIntoConstraints = false
        userId.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        body.translatesAutoresizingMaskIntoConstraints = false
        
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
