//
//  ImageTableViewCell.swift
//  NasaApp
//
//  Created by Владислав Моисеев on 22.07.2022.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    static let identifier = "ImageTableViewCell"
    
    private let imageCollectionView: UICollectionView
    private var section: Section?
    
    let sectionInserts = UIEdgeInsets(top: 1, left: 9, bottom: 1, right: 9)
    let itemsPerRow: CGFloat = 1
    
    public func configure(with section: Section?) {
        self.section = section
        imageCollectionView.reloadData()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        setupCollectionView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        section = nil
    }
    
    private func setupCollectionView() {
        let collectionView = imageCollectionView
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints(collectionView: collectionView)
    }
    
    private func setupConstraints(collectionView: UICollectionView) {
        contentView.addSubview(collectionView)
        collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 9).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImageTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.section?.items.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell,
              let section = section
        else { return UICollectionViewCell() }
        switch section.items[indexPath.item].template {
        case .photo(let photo):
            cell.set(photo: photo)
        }
        return cell
    }
}

extension ImageTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 137, height: 120)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}
