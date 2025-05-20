FROM gitpod/workspace-full

# Flutter installieren
RUN git clone https://github.com/flutter/flutter.git -b stable /home/gitpod/flutter \
  && echo 'export PATH="/home/gitpod/flutter/bin:$PATH"' >> /home/gitpod/.bashrc
