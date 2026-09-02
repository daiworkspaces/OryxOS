package com.oryxos.provider;

/**
 * Entry point for explicitly named LLM providers.
 */
public interface ProviderService {

    boolean supports(String providerName);
}
