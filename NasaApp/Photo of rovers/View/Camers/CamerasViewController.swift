//
//  CamerasViewController.swift
//  NasaApp
//
//  Created by Владислав Моисеев on 21.07.2022.
//

import UIKit

class CamerasViewController: UIViewController {
    
    let constantFile = Constant()
    let urlRover = UrlRover()
    let networkDataFetcher = NetworkDataFetcher()
    
    public var roverName: String = "Curiosity"
    let date = "2017-5-26"
    
    private let navigationLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.7215686275, green: 0.7607843137, blue: 0.8, alpha: 1)
        label.font = UIFont(name: "Helvetica", size: 11)
        label.font = UIFont.boldSystemFont(ofSize: 11)
        return label
    }()
    
    let camerasTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.backgroundColor = .white
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.identifier)
        tableView.register(TitleHeaderTableView.self, forHeaderFooterViewReuseIdentifier: TitleHeaderTableView.identifier)
        return tableView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.color = .black
        return indicator
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "This rover \n has not images."
        label.font = UIFont(name: "Helvetica", size: 13)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
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
        let url = urlRover.setupData(name: roverName, apiKey: constantFile.apiKey, earthDate: date)
        networkDataFetcher.fetchData(url) { [weak self] in
            DispatchQueue.main.async {                
                self?.activityIndicator.stopAnimating()
                self?.camerasTableView.reloadData()
            }
        }
    }
    
    private func patterns() {
        camerasTableView.dataSource = self
        camerasTableView.delegate = self
        networkDataFetcher.delegate = self
    }
    
    private func navigationTitles(topTitle: String?) {
        title = RoverSettings.roverName
        roverName = RoverSettings.roverName ?? "Unknown rover"
        navigationLabel.text = topTitle
        navigationLabel.translatesAutoresizingMaskIntoConstraints = false
        navigationController?.navigationBar.prefersLargeTitles = true
        titleConstraint()
    }
    
    private func titleConstraint() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(navigationLabel)
        navigationLabel.leftAnchor.constraint(equalTo: navigationBar.leftAnchor, constant: 16).isActive = true
        navigationLabel.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: 22).isActive = true
        navigationLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        navigationLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
    }
    
    private func setupConstrain() {
        view.addSubview(camerasTableView)
        camerasTableView.frame = view.bounds
        
        camerasTableView.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.centerYAnchor.constraint(equalTo: camerasTableView.centerYAnchor, constant: -100).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: camerasTableView.centerXAnchor).isActive = true
        
        camerasTableView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: camerasTableView.centerYAnchor,constant: -100).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: camerasTableView.centerXAnchor).isActive = true
    }
}

extension CamerasViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return networkDataFetcher.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as? ImageTableViewCell else { return UITableViewCell() }
        cell.configure(with: networkDataFetcher.sections[indexPath.section])
        cell.selectionStyle = .none
        return cell
    }
}

extension CamerasViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 122
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = camerasTableView.dequeueReusableHeaderFooterView(withIdentifier: TitleHeaderTableView.identifier) as? TitleHeaderTableView else { return UITableViewHeaderFooterView() }
        switch networkDataFetcher.sections[section].template {
        case .photos(let camera):
            headerView.set(photoCamera: camera)
        }
        headerView.delegate = self
        return headerView
    }
}

extension CamerasViewController: NetworkDataDelegate {
    func refresh() {
        camerasTableView.reloadData()
        print("HH")
    }
}

extension CamerasViewController: TitleDelegate {
    func did(select camera: Photo.Camera) {
        let vc = GalleryViewController()
        vc.cameraName = camera.name
        navigationController?.pushViewController(vc, animated: true)
    }
}





