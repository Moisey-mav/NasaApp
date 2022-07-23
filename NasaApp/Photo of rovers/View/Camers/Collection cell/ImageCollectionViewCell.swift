//
//  ImageCollectionViewCell.swift
//  NasaApp
//
//  Created by Владислав Моисеев on 22.07.2022.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ImageCollectionViewCell"
    
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
        label.text = "id #10212"
        label.textColor = UIColor(named: "CustomBlack")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let solLavel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 8)
        label.numberOfLines = 1
        label.text = "СОЛ #1000"
        label.textColor = UIColor(named: "CustomWhiteText")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.color = .black
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        setupContent()
    }
    
    private func setupContent() {
        contentView.addSubview(photoImage)
        photoImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        photoImage.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        photoImage.heightAnchor.constraint(equalToConstant: 76).isActive = true
        photoImage.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        contentView.addSubview(idLabel)
        idLabel.topAnchor.constraint(equalTo: photoImage.bottomAnchor, constant: 12).isActive = true
        idLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        idLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        idLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        contentView.addSubview(solLavel)
        solLavel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 1).isActive = true
        solLavel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        solLavel.heightAnchor.constraint(equalToConstant: 8).isActive = true
        solLavel.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        contentView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: photoImage.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: photoImage.centerYAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 50).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 50).isActive = true
        activityIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
