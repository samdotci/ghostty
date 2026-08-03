import Testing
@testable import Ghostty

struct QuickTerminalControllerTests {
    private typealias Decision = QuickTerminalController.PreviousAppRestorationDecision

    @Test func restoresPreviousAppWhenGhosttyRemainsFrontmost() {
        #expect(QuickTerminalController.previousAppRestorationDecision(
            frontmostBundleIdentifier: "com.mitchellh.ghostty",
            ghosttyBundleIdentifier: "com.mitchellh.ghostty") == Decision.restorePrevious)
    }

    @Test func preservesNewlyFocusedApp() {
        #expect(QuickTerminalController.previousAppRestorationDecision(
            frontmostBundleIdentifier: "com.tinyspeck.slackmacgap",
            ghosttyBundleIdentifier: "com.mitchellh.ghostty") == Decision.preserveCurrent)
    }

    @Test func preservesCurrentAppWhenApplicationIdentityIsUnavailable() {
        #expect(QuickTerminalController.previousAppRestorationDecision(
            frontmostBundleIdentifier: nil,
            ghosttyBundleIdentifier: "com.mitchellh.ghostty") == Decision.preserveCurrent)
        #expect(QuickTerminalController.previousAppRestorationDecision(
            frontmostBundleIdentifier: "com.mitchellh.ghostty",
            ghosttyBundleIdentifier: nil) == Decision.preserveCurrent)
    }
}
