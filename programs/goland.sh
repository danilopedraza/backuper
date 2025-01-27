#!/usr/bin/env bash

set -e

export DEBIAN_FRONTEND=noninteractive

targetUser=$1
homeFolder=$2

wget --content-disposition https://download.jetbrains.com/go/goland-2023.3.2.tar.gz \
-O $homeFolder/GoLand.tar.gz

pushd $homeFolder
echo "d11c9ff18323f121eeb643bd093cd4cc9b3ca5f64e1e1dbe4b9b8139217032d1 *GoLand.tar.gz" | sha256sum -c
popd

tar -xvf $homeFolder/GoLand.tar.gz -C $homeFolder/

mv $homeFolder/GoLand-* $homeFolder/GoLand

cp -r $homeFolder/GoLand /opt/GoLand

chown -R $targetUser:$targetUser /opt/GoLand

cat > $homeFolder/.local/share/applications/goland.desktop << END 
[Desktop Entry]
Type=Application
Name=GoLand
Exec=/opt/GoLand/bin/goland.sh
Icon=/opt/GoLand/bin/goland.png
END

cat <<END
+----------------------------------------------------------------+
  Golang successfully installed.
+----------------------------------------------------------------+
END