package com.oryxos.tool;

import com.oryxos.core.OryxTool;

import java.util.Collection;

/**
 * Registry boundary for built-in, MCP and Java tools.
 */
public interface ToolRegistry {

    Collection<OryxTool> tools();
}
