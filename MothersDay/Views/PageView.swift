//
//  PageView.swift
//  MothersDay
//
//  Created by shimanopower on 5/8/20.
//  Copyright © 2020 shimanopower. All rights reserved.
//

import SwiftUI

struct PageView<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
    @State var currentPage = 0
    
    init(_ view: [Page]) {
        self.viewControllers = view.map { UIHostingController(rootView: $0) }
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            PageViewController(controllers: viewControllers, currentPage: $currentPage)
            PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage)
                .padding(.trailing)
        }
        
    }
}
