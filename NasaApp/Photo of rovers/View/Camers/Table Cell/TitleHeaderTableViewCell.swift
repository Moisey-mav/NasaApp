//
//  TitleHeaderTableViewCell.swift
//  NasaApp
//
//  Created by Владислав Моисеев on 22.07.2022.
//

import UIKit

class TitleHeaderTableViewCell: UITableViewCell {

    static let identifier = "TitleHeaderTableViewCell"
    
    let cameraLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "CustomBlack")
        label.numberOfLines = 1
        label.font = UIFont(name: "Helvetica", size: 16)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Hello"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let indicatorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Disclosure Indicator")
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupUI() {
        setupConstraint()
    }
    
    private func setupConstraint() {
        contentView.addSubview(cameraLabel)
        cameraLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        cameraLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18).isActive = true
        cameraLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9).isActive = true
        cameraLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.1).isActive = true
        contentView.addSubview(indicatorImage)
        indicatorImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        indicatorImage.leftAnchor.constraint(equalTo: cameraLabel.rightAnchor, constant: 10).isActive = true
        indicatorImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        indicatorImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
