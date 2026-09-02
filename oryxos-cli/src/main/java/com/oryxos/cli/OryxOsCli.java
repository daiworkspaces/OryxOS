package com.oryxos.cli;

import picocli.CommandLine;

@CommandLine.Command(
        name = "oryxos",
        description = "OryxOS command-line interface",
        mixinStandardHelpOptions = true,
        version = "OryxOS 0.1.0-SNAPSHOT"
)
public final class OryxOsCli implements Runnable {

    public static void main(String[] args) {
        String[] effectiveArgs = args.length == 0 ? new String[]{"--version"} : args;
        int exitCode = new CommandLine(new OryxOsCli()).execute(effectiveArgs);
        System.exit(exitCode);
    }

    @Override
    public void run() {
        CommandLine.usage(this, System.out);
    }
}
