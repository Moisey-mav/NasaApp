//
//  SettingsTableViewCell.swift
//  NasaApp
//
//  Created by Владислав Моисеев on 21.07.2022.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    static let identifier = "SettingsTableViewCell"

    var labelRover: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 16)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let selectionIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupConstraint() {
        contentView.addSubview(labelRover)
        labelRover.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        labelRover.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        labelRover.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9).isActive = true
        labelRover.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5).isActive = true
        contentView.addSubview(selectionIcon)
        selectionIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        selectionIcon.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        selectionIcon.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        selectionIcon.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
    }

}
