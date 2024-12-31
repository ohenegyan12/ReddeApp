import SwiftUI
import Charts

struct BankTransaction: Identifiable {
    let id = UUID()
    let name: String
    let accountNumber: String
    let amount: Double
    let isDebit: Bool
    let date: Date
    
    static let sample = BankTransaction(
        name: "Jerome Bell",
        accountNumber: "1234567890",
        amount: 834,
        isDebit: true,
        date: Date()
    )
}

struct DailyBalance: Identifiable {
    let id = UUID()
    let day: String
    let amount: Double
}

struct BankOverview: View {
    let weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    let dailyBalances = [
        DailyBalance(day: "Mon", amount: 2000),
        DailyBalance(day: "Tue", amount: 4000),
        DailyBalance(day: "Wed", amount: 7434),
        DailyBalance(day: "Thu", amount: 6000),
        DailyBalance(day: "Fri", amount: 8000),
        DailyBalance(day: "Sat", amount: 9000),
        DailyBalance(day: "Sun", amount: 10500)
    ]
    
    @State private var selectedTab = "Sent"
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                // Overview Text
                Text("Overview")
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                
                Text("Here all activities, and everything on your bank")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                // Sent/Received Tabs
                HStack(spacing: 0) {
                    TabButton(title: "Sent", isSelected: selectedTab == "Sent") {
                        selectedTab = "Sent"
                    }
                    TabButton(title: "Received", isSelected: selectedTab == "Received") {
                        selectedTab = "Received"
                    }
                }
                .padding(.horizontal)
                
                // Week Header
                HStack {
                    Text("September 2023")
                        .font(.title2)
                        .bold()
                    Spacer()
                    HStack(spacing: 20) {
                        Image(systemName: "chevron.left")
                        Image(systemName: "chevron.right")
                    }
                }
                .padding(.horizontal)
                
                Text("Week 1")
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                
                // Chart
                Chart {
                    ForEach(dailyBalances) { balance in
                        AreaMark(
                            x: .value("Day", balance.day),
                            y: .value("Amount", balance.amount)
                        )
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.red.opacity(0.5), .red.opacity(0.2)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        
                        LineMark(
                            x: .value("Day", balance.day),
                            y: .value("Amount", balance.amount)
                        )
                        .foregroundStyle(.red)
                    }
                }
                .frame(height: 200)
                .padding()
                
                // Recent Transactions
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Recent transactions")
                            .font(.title3)
                            .bold()
                        Spacer()
                        Text("View All")
                            .foregroundColor(.gray)
                    }
                    
                    TransactionRowView(transaction: BankTransaction.sample)
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Bottom Tab Bar
                HStack {
                    TabBarItem(icon: "house", text: "Home")
                    TabBarItem(icon: "chart.bar", text: "Stats", isSelected: true)
                    Circle()
                        .foregroundColor(.red)
                        .frame(width: 60, height: 60)
                        .overlay(
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .font(.title2)
                        )
                    TabBarItem(icon: "creditcard", text: "Wallets")
                    TabBarItem(icon: "person", text: "Account")
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
    }
}

struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Text(title)
                    .foregroundColor(isSelected ? .red : .gray)
                    .padding(.bottom, 8)
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(isSelected ? .red : .clear)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct TabBarItem: View {
    let icon: String
    let text: String
    var isSelected: Bool = false
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .foregroundColor(isSelected ? .red : .gray)
            Text(text)
                .font(.caption)
                .foregroundColor(isSelected ? .red : .gray)
        }
        .frame(maxWidth: .infinity)
    }
}

struct TransactionRowView: View {
    let transaction: BankTransaction
    
    var body: some View {
        HStack {
            Image(systemName: "arrow.right.circle.fill")
                .foregroundColor(.gray)
                .font(.title2)
            
            Text(transaction.name)
                .font(.body)
            
            Spacer()
            
            Text("\(transaction.isDebit ? "-" : "+")GHS \(String(format: "%.0f", transaction.amount))")
                .bold()
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    BankOverview()
}
