//
//  NewsFeedView.swift
//  Swift_BDUI
//
//  Created by Mikhail Kolkov on 1/27/25.
//

import SwiftUI

struct NewsFeedView: View, UIDelegate {
    @StateObject var controller = HomePageController()
    var body: some View {
        renderPage(ui: controller.uiComponents, uiDelegate: self)
            .onAppear(perform: {
                self.controller.loadPage()
            })
    }
}
