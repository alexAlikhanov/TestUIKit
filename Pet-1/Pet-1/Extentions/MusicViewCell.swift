//
//  MusicViewCell.swift
//  Pet-1
//
//  Created by Алексей on 11/15/22.
//

import UIKit

class MusicViewCell: UITableViewCell {

    private var data: Track?
    private var networkDataFetcher = NetworkDataFetcher()
    private var artworkImage: UIImageView = {
        var imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private var artistName: UILabel = {
        var label = UILabel()
        return label
    }()
    private var trackName: UILabel = {
        var label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style , reuseIdentifier: "cell")
        backgroundColor = nil
        contentView.addSubview(artistName)
        contentView.addSubview(trackName)
        contentView.addSubview(artworkImage)
    }
    
    func config(data: Track?){
        if let artistName = data?.artistName {self.artistName.text = artistName}
        if let trackName = data?.trackName {self.trackName.text = trackName}
        networkDataFetcher.fetchAlbumImage(imageUrlString: data?.artworkUrl100) { [weak self] (image) in
            DispatchQueue.main.async {
                if let image = image {
                    self?.artworkImage.image = image
                }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        artistName.translatesAutoresizingMaskIntoConstraints = false
        artworkImage.translatesAutoresizingMaskIntoConstraints = false
        trackName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            artworkImage.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor),
            artworkImage.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 5),
            artworkImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 5),
            artworkImage.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            artworkImage.widthAnchor.constraint(equalToConstant: contentView.safeAreaLayoutGuide.layoutFrame.size.height - 10)
        ])
        
        NSLayoutConstraint.activate([
            artistName.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            artistName.leftAnchor.constraint(equalTo: artworkImage.rightAnchor, constant: 10),
            artistName.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            trackName.topAnchor.constraint(equalTo: artistName.bottomAnchor, constant: 10),
            trackName.leftAnchor.constraint(equalTo: artworkImage.rightAnchor, constant: 10),
            trackName.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
