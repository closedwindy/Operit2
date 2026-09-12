#!/usr/bin/env python3
"""Remove ohos dependencies from pubspec.yaml and fix video_player version."""
import re
import sys

pubspec_path = sys.argv[1] if len(sys.argv) > 1 else "pubspec.yaml"
text = open(pubspec_path).read()

# Fix video_player version
text = text.replace("video_player: ^2.11.1", "video_player: ^2.10.1")

# Remove ohos dependency blocks (key + indented sub-keys)
for name in ["video_player_ohos", "path_provider_ohos", "record_ohos", "url_launcher_ohos", "file_selector_ohos"]:
    pattern = r"(?m)^  " + name + r":.*?\n(?:    .*\n)*"
    text = re.sub(pattern, "", text)

open(pubspec_path, "w").write(text)
print("Done: ohos deps removed, video_player fixed")# trigger build
# trigger
# trigger
# trigger v5
# trigger v6
