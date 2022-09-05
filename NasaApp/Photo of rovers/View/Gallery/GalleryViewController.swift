//
//  GalleryViewController.swift
//  NasaApp
//
//  Created by Владислав Моисеев on 22.07.2022.
//

import UIKit

class GalleryViewController: UIViewController {
    
    var cameraName = String()
    var roverName = String()
    let date = "2017-5-26"
    
    let urlRover = UrlRover()
    let constantFile = Constant()
    
    let networkDataFetcher = NetworkDataFetcher()
    var cameraArray: [Section] = []
    
    private let navigationLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.7215686275, green: 0.7607843137, blue: 0.8, alpha: 1)
        label.font = UIFont(name: "Helvetica", size: 11)
        label.font = UIFont.boldSystemFont(ofSize: 11)
        return label
    }()
    
    var galleryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.identifier)
        return collectionView
    }()
    
    let itemsPerRow: CGFloat = 2
    let sectionInserts = UIEdgeInsets(top: 38, left: 9, bottom: 11, right: 9)
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.color = .black
        return indicator
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupConstrain()
        patterns()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTitle()
    }
    
    private func setupTitle() {
        navigationTitles(topTitle: "23.08.22")
        activityIndicator.startAnimating()
        networkData()
    }
    
    private func networkData() {
        let url = urlRover.setupData(name: roverName, earthDate: date, apiKey: constantFile.apiKey)
        networkDataFetcher.fetchData(url) { [weak self] in
            DispatchQueue.main.async {
                self?.filterCamera()
                self?.activityIndicator.stopAnimating()
                self?.galleryCollectionView.reloadData()
            }
        }
    }
    
    private func filterCamera() {
        var modernSection: [Section] = []
        let networkArray = networkDataFetcher.photosArray
        for camera in networkArray.keys {
            if camera.name == cameraName {
                guard let photos = networkArray[camera] else { continue }
                modernSection.append(Section(template: .photos(camera: camera), items: photos.compactMap({Item(template: .photo($0))}), title: .camera(camera)))
            }
        }
        cameraArray = modernSection
    }
    
    private func patterns() {
        galleryCollectionView.dataSource = self
        galleryCollectionView.delegate = self
        networkDataFetcher.delegate = self
    }
    
    private func navigationTitles(topTitle: String?) {
        title = RoverSettings.roverName
        roverName = RoverSettings.roverName ?? "Unknown rover"
        navigationController?.navigationBar.prefersLargeTitles = true
        titleConstraint()
    }
    
    private func titleConstraint() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(navigationLabel)
        navigationLabel.translatesAutoresizingMaskIntoConstraints = false
        navigationLabel.leftAnchor.constraint(equalTo: navigationBar.leftAnchor, constant: 16).isActive = true
        navigationLabel.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: 22).isActive = true
        navigationLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        navigationLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
    }
    
    private func setupConstrain() {
        view.addSubview(galleryCollectionView)
        galleryCollectionView.frame = view.bounds
        
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cameraArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cameraArray[section].items.count
    }
            
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        switch cameraArray[indexPath.section].items[indexPath.item].template {
        case .photo(let photo):
            guard let photoCell = galleryCollectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identifier, for: indexPath) as? GalleryCollectionViewCell else { return cell }
            photoCell.set(photo: photo)
            cell = photoCell
        }
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

extension GalleryViewController: NetworkDataDelegate {
    func refresh() {
        galleryCollectionView.reloadData()
    }
}
