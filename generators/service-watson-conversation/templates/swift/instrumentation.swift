import Foundation
import LoggerAPI
import ConversationV1

var conversation: Conversation!

func initializeServiceWatsonConversation() throws {
    // Load credentials for Watson conversation using CloudEnvironment
    guard let convCredentials = cloudEnv.getWatsonConversationCredentials(name: "{{servLookupKey}}") else {
        throw InitializationError("Could not load credentials for Watson conversation.")
    }
    // For version, use today's date for the most recent version
    // https://github.com/watson-developer-cloud/swift-sdk#conversation
    let version = getVersion()
    let conversationLocal: Conversation = Conversation(
        username: convCredentials.username,
        password: convCredentials.password,
        version: version
    )
    conversation = conversationLocal
    Log.info("Found and loaded credentials for Watson conversation.")
}

private func getVersion() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let dateStr = dateFormatter.string(from: Date())
    return dateStr
}
