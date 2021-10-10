class HelperFunctions {
  static String getConvoIDFromHash({
    required String currentUserId,
    required String currentUserName,
    required String peerUserId,
    required String peerUserName,
  }) {
    return currentUserId.hashCode <= peerUserId.hashCode
        ? currentUserName + '_' + peerUserName
        : peerUserName + '_' + currentUserName;
  }
}
