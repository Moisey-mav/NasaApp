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
    
    let camerasTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.identifier)
        tableView.register(TitleHeaderTableViewCell.self, forHeaderFooterViewReuseIdentifier: TitleHeaderTableViewCell.identifier)
        return tableView
    }()
    
    public var roverName: String = "Curiosity"
    let date = "2015-6-3"
    public var sections: Section?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTitleRover()
    }
    
    private func setupTitleRover() {
        if RoverSettings.roverName != roverName {
            title = RoverSettings.roverName
            roverName = RoverSettings.roverName ?? "Unknow rover"
            networkData()
            camerasTableView.reloadData()
        } else {
            title = RoverSettings.roverName
            roverName = RoverSettings.roverName ?? "Unknow rover"
            networkData()
            camerasTableView.reloadData()
        }
    }

    private func setupUI() {
        view.backgroundColor = .white
        setupNavigationController(topTitle: "23.08.22", bottomTitle: roverName)
        configureTableView()
    }
    
    private func networkData() {
        let url = urlRover.setupData(name: roverName, apiKey: constantFile.apiKey, earthDate: date)
        networkDataFetcher.fetchData(url)
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
    
    private func configureTableView() {
        view.addSubview(camerasTableView)
        camerasTableView.frame = view.bounds
        camerasTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        camerasTableView.backgroundColor = .white
        camerasTableView.dataSource = self
        camerasTableView.delegate = self
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
        cell.section = networkDataFetcher.sections[indexPath.section]
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
        let headerView = camerasTableView.dequeueReusableHeaderFooterView(withIdentifier: TitleHeaderTableViewCell.identifier) as! TitleHeaderTableViewCell 
        switch networkDataFetcher.sections[section].template {
        case .photos(let camera):
            headerView.set(photoCamera: camera)
        }
        headerView.delegate = self
        return headerView
    }
}

extension CamerasViewController: TitleDelegate {
    func did(select camera: Photo.Camera) {
        let vc = GalleryViewController()
        vc.cameraName = camera.name
        navigationController?.pushViewController(vc, animated: true)
    }
}



