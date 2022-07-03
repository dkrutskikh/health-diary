const _shortSize = 7;

String shortCommitHash(String hash) =>
    hash.length < _shortSize ? hash : hash.substring(0, _shortSize);
