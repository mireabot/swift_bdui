//
//  HeadScrollNewsContainer.swift
//  Swift_BDUI
//
//  Created by Mikhail Kolkov on 1/27/25.
//

import SwiftUI
import Kingfisher

struct HeadScrollNewsComponent: UIComponent {
    let newsResult: NewsResult
    var uniqueId: String
    
    init(result: NewsResult) {
        self.newsResult = result
        self.uniqueId = result.title ?? "Country news"
    }

    func render(uiDelegate: UIDelegate) -> AnyView {
        HeadScrollNewsContainer(newsResult: newsResult).toAny()
    }
}

struct HeadScrollNewsContainer: View {
    let newsResult: NewsResult
    var body: some View {
        VStack(spacing: 16) {
            // Head news article
            VStack(alignment: .leading, spacing: 8, content: {
                Text(newsResult.articles.first?.title ?? "No title")
                    .font(.system(.title2, weight: .bold))
                VStack(alignment: .leading, spacing: 6, content: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(newsResult.articles.first?.source?.name ?? "No author")
                            .font(.system(.callout, weight: .medium))
                            .foregroundStyle(.purple)
                        Text(newsResult.articles.first?.publishedAt?.formatReadableDate() ?? "No date")
                            .font(.system(.footnote, weight: .regular))
                            .foregroundStyle(.secondary)
                    }
                    
                    KFImage(URL(string: newsResult.articles.first?.urlToImage ?? ""))
                        .placeholder {
                            Image(systemName: "arrow.2.circlepath.circle")
                                .font(.largeTitle)
                                .opacity(0.3)
                        }
                        .resizable()
                        .frame(height: 200)
                        .aspectRatio(contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                    
                    Button(action: {}, label: {
                        HStack {
                            Text("Read more")
                            Image(systemName: "arrow.up.right")
                        }
                        .font(.system(.footnote, weight: .medium))
                    })
                    .foregroundStyle(.secondary)
                })
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            
            // Scrollable news
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
                .padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
    HeadScrollNewsContainer(newsResult: NewsResult(articles: [], title: ""))
}

extension String {
    func formatReadableDate() -> String? {
        let isoFormatter = ISO8601DateFormatter()
        guard let date = isoFormatter.date(from: self) else {
            return "Sometime ago"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale.current
        
        return dateFormatter.string(from: date)
    }
}

