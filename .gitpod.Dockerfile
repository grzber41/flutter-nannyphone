FROM gitpod/workspace-full

# Flutter installieren
RUN sudo apt-get update && \
    sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa && \
    git clone https://github.com/flutter/flutter.git -b stable /home/gitpod/flutter

ENV PATH="/home/gitpod/flutter/bin:/home/gitpod/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Flutter vorbereiten
RUN flutter doctor
