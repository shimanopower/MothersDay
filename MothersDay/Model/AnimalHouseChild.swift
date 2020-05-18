//
//  ChildModel.swift
//  MothersDay
//
//  Created by shimanopower on 5/8/20.
//  Copyright © 2020 shimanopower. All rights reserved.
//

import SwiftUI

struct AnimalHouseChild: Hashable, Codable, Identifiable {
    var id: UUID
    var name: String
    fileprivate var imageString: String
    var mothersDayMessage: String
    
    var image: Image? {
        return Image(
            ImageStore.loadImage(name: imageString),
            scale: 2,
            label: Text(name)
        )
    }
}
