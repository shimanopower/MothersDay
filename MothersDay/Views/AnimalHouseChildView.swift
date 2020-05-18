//
//  AnimalHouseChildView.swift
//  MothersDay
//
//  Created by shimanopower on 5/10/20.
//  Copyright © 2020 shimanopower. All rights reserved.
//

import SwiftUI
import UIKit

struct AnimalHouseChildView: View {
    var child: AnimalHouseChild
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("Happy Mother's Day!")
                    .font(.largeTitle)
                Spacer()
                child.image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
                Text(child.mothersDayMessage)
                    .font(.title)
                Spacer()
            }
            ConfettiView()
        }
    }
}

