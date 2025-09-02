//
//  NewsDetailView.swift
//  RescueRooster
//
//  Created by Роман Главацкий on 02.09.2025.
//

import SwiftUI

// MARK: - News Detail View
struct NewsDetailView: View {
    let article: NewsArticle
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Image(.fireBack)
                .resizable()
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Изображение новости
                    if let imageURL = article.urlToImage {
                        AsyncImage(url: URL(string: imageURL)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        } placeholder: {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .overlay(
                                    VStack {
                                        Image(systemName: "photo")
                                            .font(.system(size: 40))
                                            .foregroundColor(.gray)
                                                                            Text("Loading image...")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    }
                                )
                        }
                        .frame(height: 250)
                        .clipped()
                        .cornerRadius(12)
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                                            // Title
                    Text(article.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    // Source and date information
                        HStack {
                            Label(article.source.name, systemImage: "newspaper")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                            
                            Spacer()
                            
                            Label(formatDate(article.publishedAt), systemImage: "clock")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Divider()
                        
                                            // News description
                    if let description = article.description {
                        Text("Description")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text(description)
                            .font(.body)
                            .foregroundColor(.primary)
                            .lineSpacing(4)
                    }
                    
                    // Action buttons
                        VStack(spacing: 12) {
                           
                            
                            Button(action: {
                                shareArticle()
                            }) {
                                HStack {
                                    Image(systemName: "square.and.arrow.up")
                                    Text("Share")
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.4))
                                .foregroundColor(.primary)
                                .cornerRadius(10)
                            }
                        }
                        .padding(.top, 8)
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
            
        }
    }
    
    private func formatDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        if let date = formatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .long
            displayFormatter.timeStyle = .short
            displayFormatter.locale = Locale(identifier: "en_US")
            return displayFormatter.string(from: date)
        }
        
        return dateString
    }
    
    private func shareArticle() {
        let activityViewController = UIActivityViewController(
            activityItems: [article.title, article.url],
            applicationActivities: nil
        )
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController?.present(activityViewController, animated: true)
        }
    }
}

#Preview {
    let sampleArticle = NewsArticle(
        title: "Sample News Title",
        description: "This is a sample news description that shows how the detail view looks.",
        url: "https://example.com",
        urlToImage: nil,
        publishedAt: "2025-01-01T12:00:00Z",
        source: NewsSource(id: "sample", name: "Sample Source")
    )
    
    NavigationView {
        NewsDetailView(article: sampleArticle)
    }
}
