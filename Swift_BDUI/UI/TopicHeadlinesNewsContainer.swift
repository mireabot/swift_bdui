//
//  TopicHeadlinesNewsContainer.swift
//  Swift_BDUI
//
//  Created by Mikhail Kolkov on 1/27/25.
//

import SwiftUI
import Kingfisher

struct TopicHeadlinesNewsComponent: UIComponent {
    let newsResult: NewsResult
    var uniqueId: String
    
    init(result: NewsResult) {
        self.newsResult = result
        self.uniqueId = result.title ?? "Topic headlines"
    }

    func render(uiDelegate: UIDelegate) -> AnyView {
        TopicHeadlinesNewsContainer(newsResult: newsResult).toAny()
    }
}

struct TopicHeadlinesNewsContainer: View {
    let newsResult: NewsResult
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Headlines from \(newsResult.title ?? "No title")")
                        .font(.system(.headline, weight: .semibold))
                    Text("Check out the tech world")
                        .font(.system(.footnote, weight: .regular))
                        .foregroundStyle(.secondary)
                }
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "arrow.up.right")
                        .font(.system(.subheadline, weight: .medium))
                }
                .foregroundStyle(.secondary)
            }
            VStack(alignment: .leading, spacing: 8) {
                ForEach(newsResult.articles[0...3], id: \.publishedAt) { article in
                    HStack(alignment: .top, spacing: 8, content: {
                        KFImage(URL(string: article.urlToImage ?? ""))
                            .placeholder {
                                Image(systemName: "arrow.2.circlepath.circle")
                                    .font(.largeTitle)
                                    .opacity(0.3)
                            }
                            .resizable()
                            .frame(width: 90, height: 65)
                            .aspectRatio(contentMode: .fill)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                            
                        VStack(alignment: .leading, spacing: 0, content: {
                            Text(article.title ?? "No title")
                                .font(.system(.subheadline, weight: .medium))
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                            Text(article.author ?? "No author")
                                .font(.system(.footnote, weight: .regular))
                                .foregroundStyle(.secondary)
                        })
                    }).fixedSize(horizontal: false, vertical: true)
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
    TopicHeadlinesNewsContainer(newsResult: NewsResult(articles: [], title: "Headlines")).padding(.horizontal, 16)
}

