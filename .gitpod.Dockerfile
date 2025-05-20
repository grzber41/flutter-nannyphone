# Verwende das offizielle Gitpod Flutter-Image als Basis
FROM gitpod/workspace-full:latest

# Java 11 installieren (für Android SDK und Flutter)
RUN sudo apt-get update && sudo apt-get install -y openjdk-11-jdk unzip wget

# Android SDK Pfad definieren
ENV ANDROID_SDK_ROOT=/usr/lib/android-sdk
ENV PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/tools

# Android SDK Commandline Tools installieren
RUN mkdir -p $ANDROID_SDK_ROOT/cmdline-tools

RUN wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O /tmp/cmdline-tools.zip && \
    unzip /tmp/cmdline-tools.zip -d $ANDROID_SDK_ROOT/cmdline-tools && \
    mv $ANDROID_SDK_ROOT/cmdline-tools/cmdline-tools $ANDROID_SDK_ROOT/cmdline-tools/latest && \
    rm /tmp/cmdline-tools.zip

# Akzeptiere Lizenzen automatisch
RUN yes | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --licenses

# Installiere Plattform-Tools, Build-Tools und Android Plattform
RUN sdkmanager --sdk_root=${ANDROID_SDK_ROOT} "platform-tools" "platforms;android-33" "build-tools;33.0.0"

# Flutter Upgrade und Konfiguration (optional hier, kann auch im .gitpod.yml gemacht werden)
RUN flutter channel stable && flutter upgrade

