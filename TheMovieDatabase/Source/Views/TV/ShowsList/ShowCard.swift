//
//  ShowCell.swift
//  TheMovieDatabase
//
//  Created by Victor Mihaita on 02/12/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct ShowCard: View {
    var show: Show

    @State private var showModal = false

    var body: some View {
        WebImage(url: show.getPosterUrl(.low))
            .resizable()
            .transition(.fade(duration: 0.5))
            .scaledToFit()
            .clipped()
            .cornerRadius(16)
            .onTapGesture { showModal.toggle() }
            .sheet(isPresented: $showModal) {
                ShowInfoView(viewModel: ShowInfoViewModel(show: show), showModal: $showModal)
            }
    }
}
