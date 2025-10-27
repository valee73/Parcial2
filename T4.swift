import SwiftUI
import SDWebImageSwiftUI

struct RouletteView: View {
    @State private var rotation: Double = 0
    @State private var isSpinning = false
    
    let segments = [
        ("Premio 1", Color.red),
        ("Premio 2", Color.blue),
        ("Premio 3", Color.green),
        ("Premio 4", Color.orange),
        ("Premio 5", Color.purple),
        ("Premio 6", Color.yellow),
        ("Premio 7", Color.pink),
        ("Premio 8", Color.cyan)
    ]
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // Ruleta con flecha
            ZStack {
                // Gráfica de pastel
                ZStack {
                    ForEach(0..<segments.count, id: \.self) { index in
                        PieSlice(
                            startAngle: angle(for: index),
                            endAngle: angle(for: index + 1)
                        )
                        .fill(segments[index].1)
                        .overlay(
                            PieSlice(
                                startAngle: angle(for: index),
                                endAngle: angle(for: index + 1)
                            )
                            .stroke(Color.white, lineWidth: 3)
                        )
                    }
                }
                .frame(width: 300, height: 300)
                .rotationEffect(.degrees(rotation))
                
                // Círculo blanco central
                Circle()
                    .fill(Color.white)
                    .frame(width: 60, height: 60)
                    .shadow(radius: 3)
                
                // Flecha indicadora (derecha)
                Image(systemName: "arrowtriangle.left.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.red)
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
                    .offset(x: 170)
            }
            
            // Botón de girar
            Button(action: spinWheel) {
                Text(isSpinning ? "Girando..." : "¡GIRAR!")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 60)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.orange, Color.red]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(30)
                    .shadow(radius: 5)
            }
            .disabled(isSpinning)
            
            Spacer()
            
            // GIF animado con SDWebImageSwiftUI
            AnimatedImage(url: URL(string: "https://media.giphy.com/media/26u4cqiYI30juCOGY/giphy.gif"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 120)
                .padding(.bottom, 20)
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.purple.opacity(0.3), Color.blue.opacity(0.3)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }
    
    func angle(for index: Int) -> Angle {
        let degreesPerSegment = 360.0 / Double(segments.count)
        return .degrees(Double(index) * degreesPerSegment)
    }
    
    func spinWheel() {
        guard !isSpinning else { return }
        
        isSpinning = true
        
        // Generar rotación aleatoria (3-5 vueltas completas + ángulo aleatorio)
        let randomSpins = Double.random(in: 3...5)
        let randomAngle = Double.random(in: 0...360)
        let totalRotation = (randomSpins * 360) + randomAngle
        
        withAnimation(.easeOut(duration: 3.0)) {
            rotation += totalRotation
        }
        
        // Resetear el estado después de girar
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            isSpinning = false
        }
    }
}

struct PieSlice: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        path.move(to: center)
        path.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle - .degrees(90),
            endAngle: endAngle - .degrees(90),
            clockwise: false
        )
        path.closeSubpath()
        
        return path
    }
}

struct RouletteView_Previews: PreviewProvider {
    static var previews: some View {
        RouletteView()
    }
}
