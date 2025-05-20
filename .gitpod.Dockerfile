# Basis-Image mit Ubuntu
FROM gitpod/workspace-full:latest

# Flutter Version und Android SDK Installieren
ENV FLUTTER_VERSION=3.29.3
ENV ANDROID_SDK_ROOT=/usr/lib/android-sdk

# Flutter SDK herunterladen
RUN git clone https://github.com/flutter/flutter.git -b stable /home/gitpod/flutter

# Flutter in PATH einfügen
ENV PATH="/home/gitpod/flutter/bin:/home/gitpod/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Android SDK Tools installieren
RUN sudo apt-get update && sudo apt-get install -y \
    unzip openjdk-11-jdk \
    libglu1-mesa && \
    sudo mkdir -p ${ANDROID_SDK_ROOT} && \
    cd /tmp && \
    curl -o sdk-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip && \
    unzip sdk-tools.zip -d ${ANDROID_SDK_ROOT} && \
    rm sdk-tools.zip

# Android SDK initialisieren
RUN yes | ${ANDROID_SDK_ROOT}/cmdline-tools/bin/sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --licenses
RUN ${ANDROID_SDK_ROOT}/cmdline-tools/bin/sdkmanager --sdk_root=${ANDROID_SDK_ROOT} "platform-tools" "platforms;android-33" "build-tools;33.0.2"

# Android SDK in PATH
ENV PATH="${PATH}:${ANDROID_SDK_ROOT}/platform-tools"

# Flutter-Abhängigkeiten laden (erste Ausführung)
RUN flutter doctor

# Arbeitsverzeichnis setzen
WORKDIR /workspace
