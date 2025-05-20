FROM gitpod/workspace-full

# Android SDK Pfad setzen
ENV ANDROID_SDK_ROOT=/usr/lib/android-sdk
ENV ANDROID_HOME=/usr/lib/android-sdk

# Android SDK Tools zum PATH hinzufügen
ENV PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/tools

# Optional: Java JDK Pfad (kann je nach Setup variieren)
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin

# Flutter Installation - falls nicht schon vorinstalliert
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="$PATH:/usr/local/flutter/bin"

# Flutter Channel und Upgrade
RUN flutter channel stable && flutter upgrade

# Android SDK Lizenz akzeptieren (sonst blockiert Build)
RUN yes | $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager --licenses

# Flutter Web aktivieren
RUN flutter config --enable-web
