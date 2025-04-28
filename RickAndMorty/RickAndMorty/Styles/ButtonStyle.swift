import SwiftUI

struct RMButtonStyle: ButtonStyle {
    var color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("GetSchwifty", size: 22))
            .foregroundColor(.black)
            .padding()
            .frame(width: 250, height: 60)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(color)
                    .shadow(color: color.opacity(0.7), radius: 10, x: 0, y: 5)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
