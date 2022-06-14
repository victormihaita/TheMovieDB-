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
            .aspectRatio(contentMode: .fit)
            .clipped()
            .cornerRadius(16)
            .onTapGesture { showModal.toggle() }
            .sheet(isPresented: $showModal) {
                ShowInfoView(viewModel: ShowInfoViewModel(show: show), showModal: $showModal)
            }
    }
}

struct ShowCardGridView: View {
    var show: Show

    @State private var showModal = false

    var body: some View {
        VStack {
            WebImage(url: show.getPosterUrl(.low))
                .placeholder(Image(systemName: "photo"))
                .resizable()
                .transition(.fade(duration: 0.5))
                .aspectRatio(contentMode: .fit)
                .cornerRadius(16)
                .clipped()
                .onTapGesture { showModal.toggle() }
                .sheet(isPresented: $showModal) {
                    ShowInfoView(viewModel: ShowInfoViewModel(show: show), showModal: $showModal)
                }
            VStack(alignment: .leading, spacing: 4) {
                Text(show.name)
                    .font(.subheadline)
                    .foregroundColor(Color(UIColor.label))
                if let overview = show.overview {
                    Text(overview)
                        .font(.caption)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                }
            }
        }
    }
}
