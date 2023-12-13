//
//  SwiftUIView.swift
//  UIKitSwiftUI
//
//  Created by Dongseok Lee on 12/13/23.
//

import SwiftUI

class SwiftUIViewModel: ObservableObject {
    @Published var title: String
    
    init(title: String) {
        self.title = title
    }
}

struct SwiftUIView: View {
    @StateObject var viewModel: SwiftUIViewModel

    var onBodyTapped: (() -> Void)?
    
    var body: some View {
        Button(viewModel.title) {
            onBodyTapped?()
        }
    }
}
