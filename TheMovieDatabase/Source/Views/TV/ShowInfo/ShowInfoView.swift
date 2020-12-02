//
//  ShowInfoView.swift
//  TheMovieDatabase
//
//  Created by Victor Mihaita on 02/12/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct ShowInfoView: View {
    @ObservedObject var viewModel: ShowInfoViewModel
    @Binding var showModal: Bool

    private let gradient = Gradient(colors: [Color(UIColor.systemBackground), .clear, .clear, Color(UIColor.systemBackground)])

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                ZStack(alignment: .bottom) {
                    ZStack {
                        WebImage(url: viewModel.show.getPosterUrl(.high))
                            .resizable()
                            .transition(.fade(duration: 0.5))
                            .scaledToFit()
                            .clipped()

                        Rectangle()
                            .foregroundColor(.clear)
                            .background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                    }
                }

                VStack(spacing: 16) {
                    HStack(alignment: .top) {
                        Text(viewModel.show.name)
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        Text(viewModel.show.getVoteAverage())
                            .font(.title)
                            .fontWeight(.bold)
                    }
                        .padding(.horizontal)

                    if let overview = viewModel.show.overview {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Description")
                                .font(.headline)

                            Text(overview)
                                .font(.subheadline)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarItems(leading:
                Button(action: { showModal.toggle() }) {
                    Image(systemName: "xmark.circle.fill")
                }
            )
        }
    }
}
