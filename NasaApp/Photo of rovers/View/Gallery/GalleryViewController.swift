//
//  GalleryViewController.swift
//  NasaApp
//
//  Created by Владислав Моисеев on 22.07.2022.
//

import UIKit

class GalleryViewController: UIViewController {

    private var galleryCollectionView: UICollectionView?
    let itemsPerRow: CGFloat = 2
    let sectionInserts = UIEdgeInsets(top: 38, left: 9, bottom: 11, right: 9)
    var roverTitle: String? = "Spirit"
    let sectionArray = ["IconCourse-UIKIt",
                        "IconCourse-WebKit",
                        "IconCourse-Api",
                        "IconCourse-CoreData",
                        "IconCourse-GCD",
                        "IconCourse-DesignPatterns",
                        "IconCourse-Notifications",
                        "IconCourse-Networking"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTitleRover()
    }
    
    private func setupUI() {
        settingsCollectionView()
        setupNavigationController(topTitle: "23.08.22", bottomTitle: roverTitle)
    }
    
    private func setupTitleRover() {
        if RoverSettings.roverName != roverTitle {
            title = RoverSettings.roverName
            roverTitle = RoverSettings.roverName
        } else {
            title = RoverSettings.roverName
            roverTitle = RoverSettings.roverName
        }
    }
    
    private func settingsCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        galleryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = galleryCollectionView else { return }
        collectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
    
    private func setupNavigationController(topTitle: String?, bottomTitle: String?) {
        title = bottomTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if let navigationBar = self.navigationController?.navigationBar {
            let topLable = UILabel()
            topLable.text = topTitle
            topLable.textColor = #colorLiteral(red: 0.7215686275, green: 0.7607843137, blue: 0.8, alpha: 1)
            topLable.font = UIFont(name: "Helvetica", size: 11)
            topLable.font = UIFont.boldSystemFont(ofSize: 11)
            topLable.translatesAutoresizingMaskIntoConstraints = false
            
            navigationBar.addSubview(topLable)
            topLable.leftAnchor.constraint(equalTo: navigationBar.leftAnchor, constant: 16).isActive = true
            topLable.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: 22).isActive = true
            topLable.widthAnchor.constraint(equalToConstant: 70).isActive = true
            topLable.heightAnchor.constraint(equalToConstant: 12).isActive = true
        }
    }
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionArray.count
    }
            
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = galleryCollectionView?.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identifier, for: indexPath) as? GalleryCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 179, height: 149)
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
