mixin MemoryCacheHelper<Info> {
  Duration get refreshDuration;

  Info? _internalCache;
  DateTime? timeStamp;
  DateTime? lastRetry;

  void clear() {
    _internalCache = null;
    timeStamp = null;
    lastRetry = null;
  }

  Info? get cache {
    lastRetry = DateTime.now();
    return _internalCache;
  }

  set cache(Info? cache) {
    if (cache != null) {
      timeStamp = DateTime.now();
    }
    _internalCache = cache;
  }

  bool isRefreshRequired() {
    if (!isCached()) {
      return true;
    }
    final actualTime = DateTime.now();
    final diff = actualTime.difference((timeStamp ?? actualTime));
    if (diff.inMilliseconds >= refreshDuration.inMilliseconds) {
      return true;
    }
    return false;
  }

  bool isCached() => _internalCache != null;
}
