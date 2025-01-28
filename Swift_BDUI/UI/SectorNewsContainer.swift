//
//  SectorNewsContainer.swift
//  Swift_BDUI
//
//  Created by Mikhail Kolkov on 1/27/25.
//

import SwiftUI
import Kingfisher

struct SectorNewsComponent: UIComponent {
    let newsResult: NewsResult
    var uniqueId: String
    
    init(result: NewsResult) {
        self.newsResult = result
        self.uniqueId = result.title ?? "Sector News"
    }

    func render(uiDelegate: UIDelegate) -> AnyView {
        SectorNewsContainer(newsResult: newsResult).toAny()
    }
}

struct SectorNewsContainer: View {
    let newsResult: NewsResult
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                Text("⚽️")
                    .padding(10)
                    .background(.white)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Everything about \(newsResult.title ?? "No title")")
                        .font(.system(.headline, weight: .semibold))
                    Text("From UCL to MLS")
                        .font(.system(.footnote, weight: .regular))
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(newsResult.articles[4...7], id: \.publishedAt) { article in
                        ZStack(alignment: .bottom, content: {
                            KFImage(URL(string: article.urlToImage ?? ""))
                                .placeholder {
                                    Image(systemName: "arrow.2.circlepath.circle")
                                        .font(.largeTitle)
                                        .opacity(0.3)
                                }
                                .onFailureImage(
                                    KFCrossPlatformImage(systemName: "xmark.octagon")
                                        )
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 200)
                            
                            HStack(alignment: .bottom, spacing: 0, content: {
                                VStack(alignment: .leading, spacing: 4, content: {
                                    Text(article.title ?? "No title")
                                        .font(.system(.subheadline, weight: .semibold))
                                        .foregroundStyle(.white)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(2)
                                    Text(article.source?.name ?? "No author")
                                        .font(.system(.caption, weight: .medium))
                                        .foregroundColor(Color(uiColor: .systemGray5))
                                    
                                })
                                Spacer()
                                Text(article.publishedAt?.formatReadableDate() ?? "No date")
                                    .font(.system(.caption, weight: .medium))
                                    .foregroundColor(Color(uiColor: .systemGray5))
                            })
                            .padding(8)
                            .frame(width: 320, alignment: .leading)
                            .background(.ultraThinMaterial.opacity(0.6))
                        })
                        .frame(width: 320)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                }
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color(uiColor: .systemGray6))
        .cornerRadius(4)
        .padding(.horizontal, 16)
    }
}

#Preview {
    SectorNewsContainer(newsResult: NewsResult(articles: [], title: "Soccer"))
}

