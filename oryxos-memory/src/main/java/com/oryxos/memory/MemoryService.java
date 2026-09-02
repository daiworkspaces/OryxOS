package com.oryxos.memory;

import java.util.List;

/**
 * Unified boundary for session and long-term memory implementations.
 */
public interface MemoryService {

    List<String> recall(String query);
}
