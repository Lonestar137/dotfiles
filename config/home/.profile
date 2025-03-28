export EDITOR="helix"
export SHELL=/usr/bin/nu

# >>> JVM installed by coursier >>>
export JAVA_HOME="/home/jonesgc/.cache/coursier/arc/https/github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.21%252B9/OpenJDK11U-jdk_x64_linux_hotspot_11.0.21_9.tar.gz/jdk-11.0.21+9"
export PATH="$PATH:/home/jonesgc/.cache/coursier/arc/https/github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.21%252B9/OpenJDK11U-jdk_x64_linux_hotspot_11.0.21_9.tar.gz/jdk-11.0.21+9/bin"
# <<< JVM installed by coursier <<<

# >>> coursier install directory >>>
export PATH="$PATH:/home/jonesgc/.local/share/coursier/bin"
# <<< coursier install directory <<<

. "$HOME/.cargo/env"
