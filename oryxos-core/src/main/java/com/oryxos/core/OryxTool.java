package com.oryxos.core;

/**
 * Contract implemented by every tool available to an OryxOS agent.
 */
public interface OryxTool {

    String name();

    String description();
}
