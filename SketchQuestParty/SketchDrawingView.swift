import SwiftUI

// MARK: - Supported Sketch Categories

enum SketchCategory: String, CaseIterable, Identifiable {
    case apple
    case bicycle
    case car
    case cat
    case fish
    case house
    case star
    case tree

    var id: String { rawValue }

    var title: String {
        rawValue.capitalized
    }
}

// MARK: - Reusable Sketch View

struct SketchDrawingView: View {

    let category: SketchCategory

    var body: some View {

        GeometryReader { geometry in

            let side = min(
                geometry.size.width,
                geometry.size.height
            ) * 0.82

            SketchLines(category: category)
                .stroke(
                    Color.black,
                    style: StrokeStyle(
                        lineWidth: 5,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
                .frame(width: side, height: side)
                .position(
                    x: geometry.size.width / 2,
                    y: geometry.size.height / 2
                )
        }
        .background(Color.white)
    }
}

// MARK: - Custom Vector Drawings

private struct SketchLines: Shape {

    let category: SketchCategory

    func path(in rect: CGRect) -> Path {

        var path = Path()

        // Use normalized coordinates from 0 to 100.
        func point(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
            CGPoint(
                x: rect.minX + rect.width * x / 100,
                y: rect.minY + rect.height * y / 100
            )
        }

        func box(
            _ x: CGFloat,
            _ y: CGFloat,
            _ w: CGFloat,
            _ h: CGFloat
        ) -> CGRect {
            CGRect(
                x: point(x, y).x,
                y: point(x, y).y,
                width: rect.width * w / 100,
                height: rect.height * h / 100
            )
        }

        func draw(_ coordinates: [(CGFloat, CGFloat)]) {

            guard let first = coordinates.first else {
                return
            }

            path.move(to: point(first.0, first.1))

            for coordinate in coordinates.dropFirst() {
                path.addLine(
                    to: point(coordinate.0, coordinate.1)
                )
            }
        }

        switch category {

        // MARK: 1 - APPLE

        case .apple:

            path.move(to: point(50, 28))

            path.addCurve(
                to: point(25, 27),
                control1: point(42, 19),
                control2: point(31, 19)
            )

            path.addCurve(
                to: point(19, 62),
                control1: point(9, 29),
                control2: point(13, 51)
            )

            path.addCurve(
                to: point(43, 86),
                control1: point(24, 80),
                control2: point(35, 89)
            )

            path.addQuadCurve(
                to: point(50, 83),
                control: point(47, 82)
            )

            path.addQuadCurve(
                to: point(57, 86),
                control: point(53, 82)
            )

            path.addCurve(
                to: point(81, 62),
                control1: point(67, 89),
                control2: point(77, 80)
            )

            path.addCurve(
                to: point(75, 27),
                control1: point(87, 51),
                control2: point(91, 29)
            )

            path.addCurve(
                to: point(50, 28),
                control1: point(69, 19),
                control2: point(58, 19)
            )

            // Stem
            draw([
                (50, 28),
                (53, 13)
            ])

            // Leaf
            path.move(to: point(53, 19))
            path.addQuadCurve(
                to: point(76, 11),
                control: point(65, 6)
            )
            path.addQuadCurve(
                to: point(53, 19),
                control: point(67, 27)
            )

        // MARK: 2 - BICYCLE

        case .bicycle:

            // Wheels
            path.addEllipse(in: box(7, 51, 32, 32))
            path.addEllipse(in: box(61, 51, 32, 32))

            // Bicycle frame
            draw([
                (23, 67),
                (43, 43),
                (55, 67),
                (23, 67)
            ])

            draw([
                (43, 43),
                (75, 67),
                (55, 67)
            ])

            // Front fork and handlebar
            draw([
                (75, 67),
                (68, 34),
                (80, 34)
            ])

            draw([
                (68, 34),
                (72, 28)
            ])

            // Seat
            draw([
                (43, 43),
                (40, 35),
                (32, 35),
                (50, 35)
            ])

            // Pedal
            path.addEllipse(in: box(51, 63, 8, 8))

            draw([
                (55, 67),
                (64, 76)
            ])

        // MARK: 3 - CAR

        case .car:

            // Car body
            draw([
                (10, 55),
                (14, 45),
                (30, 45),
                (40, 29),
                (66, 29),
                (80, 45),
                (89, 49),
                (91, 73),
                (10, 73),
                (10, 55)
            ])

            // Windows
            draw([
                (36, 45),
                (44, 33),
                (52, 33),
                (52, 45),
                (36, 45)
            ])

            draw([
                (57, 33),
                (64, 33),
                (74, 45),
                (57, 45),
                (57, 33)
            ])

            // Wheels
            path.addEllipse(in: box(21, 66, 18, 18))
            path.addEllipse(in: box(64, 66, 18, 18))

            // Lights
            draw([(10, 57), (18, 57)])
            draw([(83, 57), (91, 57)])

        // MARK: 4 - CAT

        case .cat:

            // Head and ears
            draw([
                (23, 42),
                (23, 14),
                (42, 28),
                (58, 28),
                (77, 14),
                (77, 42)
            ])

            path.move(to: point(23, 42))
            path.addCurve(
                to: point(50, 84),
                control1: point(15, 65),
                control2: point(32, 84)
            )

            path.addCurve(
                to: point(77, 42),
                control1: point(68, 84),
                control2: point(85, 65)
            )

            // Eyes
            path.addEllipse(in: box(34, 49, 7, 9))
            path.addEllipse(in: box(59, 49, 7, 9))

            // Nose
            draw([
                (45, 64),
                (55, 64),
                (50, 70),
                (45, 64)
            ])

            // Mouth
            draw([
                (50, 70),
                (50, 75),
                (45, 79)
            ])

            draw([
                (50, 75),
                (55, 79)
            ])

            // Whiskers
            draw([(40, 68), (14, 63)])
            draw([(40, 73), (14, 75)])
            draw([(60, 68), (86, 63)])
            draw([(60, 73), (86, 75)])

        // MARK: 5 - FISH

        case .fish:

            // Fish body
            path.addEllipse(in: box(15, 28, 62, 44))

            // Tail
            draw([
                (75, 50),
                (94, 29),
                (94, 72),
                (75, 50)
            ])

            // Eye
            path.addEllipse(in: box(29, 42, 7, 7))

            // Gill
            path.move(to: point(45, 34))
            path.addQuadCurve(
                to: point(45, 66),
                control: point(35, 50)
            )

            // Top fin
            draw([
                (44, 29),
                (54, 13),
                (64, 29)
            ])

            // Bottom fin
            draw([
                (45, 70),
                (55, 84),
                (63, 70)
            ])

            // Water bubbles
            path.addEllipse(in: box(5, 18, 7, 7))
            path.addEllipse(in: box(14, 8, 5, 5))

        // MARK: 6 - HOUSE

        case .house:

            // Roof
            draw([
                (10, 43),
                (50, 10),
                (90, 43),
                (10, 43)
            ])

            // Main structure
            draw([
                (20, 43),
                (20, 91),
                (80, 91),
                (80, 43)
            ])

            // Door
            draw([
                (43, 91),
                (43, 66),
                (57, 66),
                (57, 91)
            ])

            // Windows
            path.addRect(box(27, 53, 12, 12))
            path.addRect(box(62, 53, 12, 12))

            // Door handle
            path.addEllipse(in: box(52, 79, 2, 2))

        // MARK: 7 - STAR

        case .star:

            draw([
                (50, 7),
                (62, 37),
                (94, 38),
                (69, 58),
                (78, 90),
                (50, 71),
                (22, 90),
                (31, 58),
                (6, 38),
                (38, 37),
                (50, 7)
            ])

        // MARK: 8 - TREE

        case .tree:

            // Tree branches / foliage
            draw([
                (50, 7),
                (30, 35),
                (39, 35),
                (19, 61),
                (32, 61),
                (12, 79),
                (88, 79),
                (68, 61),
                (81, 61),
                (61, 35),
                (70, 35),
                (50, 7)
            ])

            // Trunk
            draw([
                (42, 79),
                (42, 96),
                (58, 96),
                (58, 79)
            ])

            // Interior branches
            draw([
                (50, 36),
                (50, 79)
            ])

            draw([
                (50, 63),
                (37, 53)
            ])

            draw([
                (50, 70),
                (64, 55)
            ])
        }

        return path
    }
}

// MARK: - Preview All Drawings

#Preview {

    LazyVGrid(
        columns: Array(
            repeating: GridItem(.flexible()),
            count: 4
        ),
        spacing: 25
    ) {

        ForEach(SketchCategory.allCases) { category in

            VStack(spacing: 12) {

                SketchDrawingView(category: category)
                    .frame(width: 230, height: 190)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 18)
                    )

                Text(category.title)
                    .font(.system(size: 23, weight: .bold))
                    .foregroundStyle(.white)
            }
        }
    }
    .padding(60)
    .background(
        Color(red: 0.10, green: 0.06, blue: 0.25)
    )
}
