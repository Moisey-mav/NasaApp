//
//  NetworkDataFetcher.swift
//  NasaApp
//
//  Created by Владислав Моисеев on 23.07.2022.
//

import Foundation

protocol NetworkDataDelegate: AnyObject {
    func refresh()
}

class NetworkDataFetcher {
    
    public weak var delegate: NetworkDataDelegate?
    
    public var sections: [Section] = []
    public var photosArray: [Photo.Camera: [Photo]] = [:]
    
    
    // декодируем полученные JSON данные в модель
    func fetchData(_ urlString: String?, completion: @escaping () -> Void) {
        sections.removeAll()
        
        delegate?.refresh()
        guard let jsonUrLString = urlString else { return }
        guard let url = URL(string: jsonUrLString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let photosData = try JSONDecoder().decode(PhotoModel.self, from: data)
                var sections: [Photo.Camera: [Photo]] = [:]
                for photo in photosData.photos {
                    guard let camera = photo.camera else { continue }
                    if var section = sections[camera] {
                        section.append(photo)
                        sections[camera] = section
                    } else {
                        sections[camera] = [photo]
                    }
                }
                var modernSections: [Section] = []
                for camera in sections.keys {
                    guard let photos = sections[camera] else { continue }
                    modernSections.append(Section(template: .photos(camera: camera), items: photos.compactMap({Item(template: .photo($0))}), title: .camera(camera)))
                }
                self.photosArray = sections
                self.sections = modernSections
                completion()
            } catch let error {
                print("Error serialization json", error)
            }
        }.resume()
    }
}
