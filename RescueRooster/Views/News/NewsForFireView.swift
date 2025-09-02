//
//  NewsForFireView.swift
//  RescueRooster
//
//  Created by Роман Главацкий on 02.09.2025.
//

import SwiftUI
import Foundation

// MARK: - Main View
struct NewsForFireView: View {
    @StateObject private var newsService = NewsService()
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(.fireBack)
                    .resizable()
                    .ignoresSafeArea()
                VStack {
                                         if newsService.isLoading {
                         VStack(spacing: 16) {
                             ProgressView()
                                 .scaleEffect(1.2)
                             Text("Loading news...")
                                 .foregroundColor(.secondary)
                         }
                         .padding()
                         .background(Color(.systemBackground).opacity(0.8))
                         .cornerRadius(12)
                         .frame(maxWidth: .infinity, maxHeight: .infinity)
                                         } else if let errorMessage = newsService.errorMessage {
                         VStack(spacing: 16) {
                             Image(systemName: "exclamationmark.triangle")
                                 .font(.system(size: 50))
                                 .foregroundColor(.orange)
                             
                             Text("Loading Error")
                                 .font(.headline)
                             
                             Text(errorMessage)
                                 .font(.subheadline)
                                 .foregroundColor(.secondary)
                                 .multilineTextAlignment(.center)
                                 .padding(.horizontal)
                             
                             Button("Try Again") {
                                 newsService.fetchFireNews()
                             }
                             .buttonStyle(.borderedProminent)
                         }
                         .padding()
                         .background(Color(.systemBackground).opacity(0.8))
                         .cornerRadius(12)
                         .frame(maxWidth: .infinity, maxHeight: .infinity)
                                         } else if newsService.articles.isEmpty {
                         VStack(spacing: 16) {
                             Image(systemName: "newspaper")
                                 .font(.system(size: 50))
                                 .foregroundColor(.gray)
                             
                             Text("No News Found")
                                 .font(.headline)
                             
                             Text("Try refreshing the list")
                                 .font(.subheadline)
                                 .foregroundColor(.secondary)
                             
                             VStack(spacing: 12) {
                                 Button("Refresh") {
                                     newsService.fetchFireNews()
                                 }
                                 .buttonStyle(.borderedProminent)
                                 
                                 Button("Try Different Queries") {
                                     newsService.tryAlternativeSearch()
                                 }
                                 .buttonStyle(.bordered)
                             }
                         }
                         .padding()
                         .background(Color(.systemBackground).opacity(0.8))
                         .cornerRadius(12)
                         .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        List(newsService.articles) { article in
                            NewsArticleRow(article: article)
                                .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                        }
                        .listStyle(PlainListStyle())
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                        .refreshable {
                            newsService.fetchFireNews()
                        }
                    }
                }
                                 .navigationTitle("Fire News")
                .navigationBarTitleDisplayMode(.large)
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            newsService.fetchFireNews()
                        }) {
                            Image(systemName: "arrow.clockwise")
                        }
                    }
                }
            }
        }
        .onAppear {
            // Initialize API key on first launch
            KeychainService.shared.initializeAPIKey()
            
            if newsService.articles.isEmpty {
                newsService.fetchFireNews()
            }
        }
    }
}

#Preview {
    NewsForFireView()
}
