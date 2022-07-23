//
//  CellModel.swift
//  NasaApp
//
//  Created by Владислав Моисеев on 22.07.2022.
//

import Foundation

enum CellModel {
    case collectionView(models: [CollectionTableCellModel], rows: Int)
}

struct CollectionTableCellModel {
    let tittle: String
    let imageName: String
}
