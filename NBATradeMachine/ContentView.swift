import SwiftUI

struct ContentView: View {
    @StateObject private var teamsVM = TeamsViewModel()
    @StateObject private var rulesVM = LeagueRulesViewModel()

    var body: some View {
        TabView {
            TeamsListView()
                .tabItem { Label("Teams", systemImage: "shield.lefthalf.filled") }

            PlayersListView()
                .tabItem { Label("Players", systemImage: "person.2.fill") }

            TradeMachineView()
                .tabItem { Label("Trade", systemImage: "arrow.left.arrow.right.circle.fill") }
        }
        .environmentObject(teamsVM)
        .environmentObject(rulesVM)
        .task {
            await rulesVM.load()
            await teamsVM.load()
        }
    }
}

#Preview {
    ContentView()
}
