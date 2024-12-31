import SwiftUI

struct HomePage: View {
    // Define the exact colors using RGB values
    // BD0910 -> R: 189, G: 9, B: 16
    // 121826 -> R: 18, G: 24, B: 38
    let redCardColor = Color(red: 189/255, green: 9/255, blue: 16/255)
    let darkCardColor = Color(red: 18/255, green: 24/255, blue: 38/255)
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Welcome Text
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Welcome Back to Redde Online")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("What would you like to do today?")
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    
                    // Balance Card
                    VStack(spacing: 0) {
                        // Red Section with all corners rounded
                        VStack(spacing: 8) {
                            Text("Your available balance")
                                .foregroundColor(.white)
                            Text("GHS 23,540.00")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                            HStack {
                                Text("GH 12,450.34")
                                    .foregroundColor(.white)
                                Text("↑ 10%")
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.white.opacity(0.2))
                                    .cornerRadius(12)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.vertical, 24)
                        .frame(maxWidth: .infinity)
                        .background(
                            redCardColor
                                .cornerRadius(16)
                        )
                        
                        // Dark Section with Action Buttons (only bottom corners rounded)
                        HStack(spacing: 40) {
                            ActionButton(title: "Transfer", systemImage: "arrow.2.squarepath")
                            ActionButton(title: "Topup", systemImage: "arrow.up")
                            ActionButton(title: "History", systemImage: "clock")
                        }
                        .padding(.vertical, 24)
                        .frame(maxWidth: .infinity)
                        .background(
                            darkCardColor
                                .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
                        )
                        .offset(y: -16)
                    }
                    .padding(.horizontal, 8)
                    
                    // Recent Transactions
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Recent transactions")
                                .font(.title3)
                                .fontWeight(.bold)
                            Spacer()
                            Button("View All") {
                                // Action
                            }
                            .foregroundColor(.gray)
                        }
                        
                        VStack(spacing: 16) {
                            TransactionRow(
                                name: "Jerome Bell",
                                accountNumber: "6776 4553 3332 4992",
                                amount: -834,
                                isDebit: true
                            )
                            
                            TransactionRow(
                                name: "Esther Howard",
                                accountNumber: "6553 8754 3322 2235",
                                amount: 72,
                                isDebit: false
                            )
                            
                            TransactionRow(
                                name: "Albert Flores",
                                accountNumber: "4554 3321 1209 9981",
                                amount: -234,
                                isDebit: true
                            )
                            TransactionRow(
                                name: "Albert Flores",
                                accountNumber: "4554 3321 1209 9981",
                                amount: -234,
                                isDebit: true
                            )
                            TransactionRow(
                                name: "Esther Howard",
                                accountNumber: "6553 8754 3322 2235",
                                amount: 72,
                                isDebit: false
                            )
                            TransactionRow(
                                name: "Esther Howard",
                                accountNumber: "6553 8754 3322 2235",
                                amount: 72,
                                isDebit: false
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
            }
            .navigationBarItems(trailing: Button(action: {}) {
                Image(systemName: "bell")
                    .foregroundColor(.black)
            })
        }
        
        // Bottom Tab Bar
        .safeAreaInset(edge: .bottom) {
            HStack(spacing: 0) {
                TabBarButton(title: "Home", systemImage: "house.fill", isSelected: true)
                TabBarButton(title: "Stats", systemImage: "chart.bar")
                TabBarButton(title: "", systemImage: "plus.circle.fill", isCenter: true)
                TabBarButton(title: "Wallets", systemImage: "creditcard")
                TabBarButton(title: "Account", systemImage: "person")
            }
            .padding(.top, 8)
            .background(Color.white)
        }
    }
}

// Extension to support custom corner radius
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

// Custom shape for rounded corners
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct ActionButton: View {
    let title: String
    let systemImage: String
    
    var body: some View {
        VStack {
            Image(systemName: systemImage)
                .font(.system(size: 20))
                .foregroundColor(.white)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.white)
        }
    }
}

struct TransactionRow: View {
    let name: String
    let accountNumber: String
    let amount: Double
    let isDebit: Bool
    
    var body: some View {
        HStack {
            Image(systemName: isDebit ? "arrow.up.right" : "arrow.down.left")
                .font(.system(size: 16))
                .foregroundColor(isDebit ? .black : .green)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .fontWeight(.medium)
                Text(accountNumber)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text("\(isDebit ? "-" : "+")GHS \(abs(amount))")
                .fontWeight(.medium)
                .foregroundColor(isDebit ? .black : .green)
        }
    }
}

struct TabBarButton: View {
    let title: String
    let systemImage: String
    var isSelected: Bool = false
    var isCenter: Bool = false
    
    var body: some View {
        VStack(spacing: 4) {
            if isCenter {
                ZStack {
                    Circle()
                        .fill(Color(red: 189/255, green: 9/255, blue: 16/255))
                        .frame(width: 48, height: 48) // Circle size

                    Image(systemName: systemImage)
                        .font(.system(size: 24)) // Plus icon size
                        .foregroundColor(.white)
                }
            } else {
                Image(systemName: systemImage)
                    .font(.system(size: 24))
                    .frame(width: 24, height: 24) // Adjust sizes for other buttons
                    .foregroundColor(isSelected ? Color(red: 189/255, green: 9/255, blue: 16/255) : .gray)

                Text(title)
                    .font(.caption2)
                    .foregroundColor(isSelected ? Color(red: 189/255, green: 9/255, blue: 16/255) : .gray)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
