//
//  GalleryCollectionViewCell.swift
//  NasaApp
//
//  Created by Владислав Моисеев on 22.07.2022.
//

import UIKit
import Nuke

class GalleryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "GalleryCollectionViewCell"
    
    private var photo: Photo?
    
    private let photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(named: "CustomWhiteText")
        imageView.layer.cornerRadius = 4
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 13)
        label.numberOfLines = 1
        label.text = "id:"
        label.textColor = UIColor(named: "CustomBlack")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let solLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 8)
        label.numberOfLines = 1
        label.text = "СОЛ"
        label.textColor = UIColor(named: "CustomWhiteText")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        setupConstraint()
    }
    
    private func setupConstraint() {
        contentView.addSubview(photoImage)
        photoImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        photoImage.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        photoImage.heightAnchor.constraint(equalToConstant: 104).isActive = true
        photoImage.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        contentView.addSubview(idLabel)
        idLabel.topAnchor.constraint(equalTo: photoImage.bottomAnchor, constant: 12).isActive = true
        idLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        idLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        idLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        contentView.addSubview(solLabel)
        solLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 1).isActive = true
        solLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        solLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        solLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photo = nil
    }
    
    public func set(photo: Photo) {
        self.photo = photo
        self.idLabel.text = "id #\(String(photo.id))"
        self.solLabel.text = "СОЛ #\(String(photo.sol))"
        self.setupImage(by: photo.img_src)
    }
    
    fileprivate func setupImage(by url: String?) {
        if url != nil {
            guard let url = url else { return }
            guard let urlString = URL(string: url) else { return }
            let options = ImageLoadingOptions(placeholder: UIImage(), transition: .fadeIn(duration: 0.5))
            let nukeRequest = Nuke.ImageRequest(url: urlString)
            Nuke.loadImage(with: nukeRequest, options: options, into: photoImage)
        } else {
            photoImage.image = UIImage(named: "errorImage-icon")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

