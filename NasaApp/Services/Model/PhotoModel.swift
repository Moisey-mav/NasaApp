//
//  PhotoModel.swift
//  NasaApp
//
//  Created by Владислав Моисеев on 23.07.2022.
//

import Foundation

public struct PhotoModel: Codable {
    public let photos: [Photo]
}

public struct Photo: Codable {
    public let id: Int
    public let sol: Int
    public let camera: Camera?
    public let img_src: String?
    public let earth_date: String?
}

extension Photo {
    public struct Camera: Codable, Hashable {
        public let id: Int
        public let name: String
        public let full_name: String
    }
}

public struct Section {
    public let id = UUID()
    public let template: Template
    public var items: [Item]
    public let title: Title?
}

extension Section {
    public enum Template {
        case photos(camera: Photo.Camera)
    }
}

extension Section {
    public enum Title {
        case camera(Photo.Camera)
    }
}

public struct Item {
    public let id = UUID()
    public let template: Template
}

extension Item {
    public enum Template {
        case photo(Photo)
    }
}
