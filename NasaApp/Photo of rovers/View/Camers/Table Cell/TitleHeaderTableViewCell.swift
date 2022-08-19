//
//  TitleHeaderTableViewCell.swift
//  NasaApp
//
//  Created by Владислав Моисеев on 22.07.2022.
//

import UIKit

protocol TitleDelegate: AnyObject {
    func did(select camera: Photo.Camera)
}

class TitleHeaderTableViewCell: UITableViewHeaderFooterView {

    static let identifier = "TitleHeaderTableViewCell"
    
    var photoCamera: Photo.Camera?
    public weak var delegate: TitleDelegate?
    
    let cameraLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "CustomBlack")
        label.numberOfLines = 1
        label.font = UIFont(name: "Helvetica", size: 16)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let indicatorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "disclosure Indicator")
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        setupUI()
    }

    
    private func setupUI() {
        setupConstraint()
        setupGestures()
    }
    
    private func setupConstraint() {
        contentView.addSubview(cameraLabel)
        cameraLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        cameraLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18).isActive = true
        contentView.addSubview(indicatorImage)
        indicatorImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        indicatorImage.leftAnchor.constraint(equalTo: cameraLabel.rightAnchor, constant: 10).isActive = true
        indicatorImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        indicatorImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoCamera = nil
        cameraLabel.text = nil
    }
    
    public func set(photoCamera: Photo.Camera) {
        self.photoCamera = photoCamera
        self.cameraLabel.text = "\(photoCamera.name)"
        self.indicatorImage.image = UIImage(named: "disclosure indicator")
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupGestures() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(titleTaped)))
    }
    
    @objc private func titleTaped() {
        guard let photoCamera = photoCamera else { return }
        delegate?.did(select: photoCamera)
    }
}
