//
//  ButtonView.swift
//  BattleOfMonsters
//
//  Created by Francisco Cordoba on 18/9/24.
//

import SwiftUI

struct ButtonView: View {
    @EnvironmentObject var store: AppStore

    private let networkClient: NetworkClient = ApiNetworkClient()

    @State var battleResult = ""
    @State var isPresentingBattleResult = false

    @State private var isPresentingAlert2 = false
    @State private var alertMessage = ""

    var isDisabled: Bool {
        store.state.selectedMonster == nil
    }

    var buttonColor: Color {
        isDisabled ? Color.gray : Color(.systemGreen)
    }

    var body: some View {

        ZStack {
            Button{
                sendRequest()
            } label: {
                ScreenTitleView(title: "Battle", font: .headline, weight: .bold)
                    .frame(maxWidth: .infinity, maxHeight: 50)
            }
            .background(buttonColor)
            .foregroundColor(.white)
            .cornerRadius(10)
            .frame(height: 50)
            .disabled(isDisabled)
            .overlay {

                if isPresentingBattleResult {
                    Text("\(battleResult.uppercased())")
                        .lineLimit(26)
                        .font(.system(size: 22, weight: .regular))
                        .multilineTextAlignment(.leading)
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: 61,
                            alignment: .leading
                        )
                        .padding(.all, 17)
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .background(Color(.systemOrange))
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .shadow(color: .black.opacity(0.25), radius: 4, x: -2, y: 3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(.black, lineWidth: 1)
                        )
                        .alert(isPresented: $isPresentingAlert2) {
                            Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
                        }
                }
            }
        }
    }

    private func sendRequest() {
        guard let monster1 = store.state.selectedMonster,
              let monster2 = store.state.computerMonster else {
            return
        }

        let battleBody = BattleBody(monster1Id: monster1.id, monster2Id: monster2.id)

        networkClient.battle(battleBody: battleBody) { result in
            switch result {
                case .success(let battle):

                    battleResult = battle.tie ? "It was a tie!" : "\(battle.winner?.name ?? "") won!".uppercased()
                    isPresentingBattleResult = true

                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isPresentingBattleResult = false
                        store.dispatch(.setSelected(nil))
                    }

                case .failure(let error):
                    isPresentingAlert2 = true
                    alertMessage = error.localizedDescription
            }
        }
    }
}

#Preview {
    ButtonView()
        .environmentObject(previewStore)
}
