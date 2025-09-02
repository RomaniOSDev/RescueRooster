//
//  NewsService.swift
//  RescueRooster
//
//  Created by Роман Главацкий on 02.09.2025.
//

import Foundation
import Combine

// MARK: - News Service
class NewsService: ObservableObject {
    private let keychainService = KeychainService.shared
    private let baseURL = "https://newsapi.org/v2/everything"
    
    @Published var articles: [NewsArticle] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    var currentSearchIndex = 0
    let searchQueries = [
        "wildfire",
        "forest fire", 
        "fire emergency",
        "fire news",
        "california fire"
    ]
    
    func fetchFireNews() {
        isLoading = true
        errorMessage = nil
        
        // Get API key from Keychain
        guard let apiKey = keychainService.getAPIKey() else {
            errorMessage = "API key not found. Please check settings."
            isLoading = false
            return
        }
        
        // Use current search query
        let query = searchQueries[currentSearchIndex]
        let urlString = "\(baseURL)?q=\(query)&language=en&sortBy=publishedAt&pageSize=20&apiKey=\(apiKey)"
        
        print("🔍 Fetching news with URL: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL: \(urlString)"
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    print("❌ Network error: \(error.localizedDescription)")
                    self?.errorMessage = "Network error: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    print("❌ No data received")
                    self?.errorMessage = "No data received"
                    return
                }
                
                // Выводим ответ для отладки
                if let responseString = String(data: data, encoding: .utf8) {
                    print("📰 API Response: \(responseString.prefix(500))...")
                }
                
                do {
                    let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                    print("✅ Successfully decoded \(newsResponse.articles.count) articles")
                    
                    if newsResponse.articles.isEmpty && self?.currentSearchIndex ?? 0 < (self?.searchQueries.count ?? 0) - 1 {
                        // If no news found, try next query
                        self?.currentSearchIndex += 1
                        self?.fetchFireNews()
                    } else {
                        self?.articles = newsResponse.articles
                    }
                } catch {
                    print("❌ Decode error: \(error)")
                    self?.errorMessage = "Failed to decode news: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
    
    func tryAlternativeSearch() {
        currentSearchIndex = 0
        fetchFireNews()
    }
    
    /// Initialize API key on first launch
    func initializeAPIKey() {
        keychainService.initializeAPIKey()
    }
    
    /// Initialize API key (alternative method)
    func setupAPIKey() {
        KeychainService.shared.initializeAPIKey()
    }
    
    /// Update API key
    func updateAPIKey(_ newAPIKey: String) -> Bool {
        return keychainService.saveAPIKey(newAPIKey)
    }
    
    /// Check if API key exists
    func hasAPIKey() -> Bool {
        return keychainService.hasAPIKey()
    }
}
