//
//  NewsArticleRow.swift
//  RescueRooster
//
//  Created by Роман Главацкий on 02.09.2025.
//

import SwiftUI

// MARK: - News Article Row
struct NewsArticleRow: View {
    let article: NewsArticle
    
    var body: some View {
        NavigationLink(destination: NewsDetailView(article: article)) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(article.title)
                            .font(.headline)
                            .lineLimit(2)
                            .foregroundColor(.primary)
                        
                        if let description = article.description {
                            Text(description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(3)
                        }
                    }
                    
                    Spacer()
                    
                    if let imageURL = article.urlToImage {
                        AsyncImage(url: URL(string: imageURL)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .overlay(
                                    Image(systemName: "photo")
                                        .foregroundColor(.gray)
                                )
                        }
                        .frame(width: 80, height: 80)
                        .cornerRadius(8)
                        .clipped()
                    }
                }
                
                HStack {
                    Text(article.source.name)
                        .font(.caption)
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    Text(formatDate(article.publishedAt))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .background(Color(.white).opacity(0.6))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func formatDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        if let date = formatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .short
            displayFormatter.timeStyle = .short
            return displayFormatter.string(from: date)
        }
        
        return dateString
    }
}

#Preview {
    let sampleArticle = NewsArticle(
        title: "Sample News Title About Fire Emergency",
        description: "This is a sample news description that shows how the article row looks in the list.",
        url: "https://example.com",
        urlToImage: "https://via.placeholder.com/300x200",
        publishedAt: "2025-01-01T12:00:00Z",
        source: NewsSource(id: "sample", name: "Sample News Source")
    )
    
    NavigationView {
        List {
            NewsArticleRow(article: sampleArticle)
        }
    }
}
