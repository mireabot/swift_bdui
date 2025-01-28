//
//  UIComponent.swift
//  Swift_BDUI
//
//  Created by Mikhail Kolkov on 1/27/25.
//

import Foundation
import SwiftUI

protocol UIDelegate {}

protocol UIComponent {
    var uniqueId: String  { get }
    func render(uiDelegate: UIDelegate) -> AnyView
}

extension View {
    func toAny() -> AnyView {
        return AnyView(self)
    }
}

func renderPage(ui: [UIComponent], uiDelegate: UIDelegate) -> AnyView {
    return
        ScrollView(.vertical) {
            VStack(spacing: 16) {
                ForEach(ui, id: \.uniqueId) { uiComponent in
                    uiComponent.render(uiDelegate: uiDelegate)
                }
                .transition(AnyTransition.scale)
            }
        }
        .toAny()
}

