SRC=/home/htf/soft/php-8.1.3
ROOT=$(pwd)
export CC=clang
export CXX=clang++
export LD=ld.lld
export PKG_CONFIG_PATH=/usr/libwebp/lib/pkgconfig:/usr/freetype/lib/pkgconfig:/usr/libjpeg/lib64/pkgconfig:/usr/libpng/lib/pkgconfig:/usr/giflib/lib/pkgconfig:/usr/gmp/lib/pkgconfig:/usr/imagemagick/lib/pkgconfig:/usr/curl/lib/pkgconfig:/usr/openssl/lib/pkgconfig:$PKG_CONFIG_PATH
OPTIONS="--disable-all \
--with-openssl=/usr/openssl --with-openssl-dir=/usr/openssl \
--with-curl=/usr/curl \
--with-iconv=/usr/libiconv \
--with-bz2 \
--enable-bcmath \
--enable-pcntl \
--enable-filter \
--enable-session \
--enable-tokenizer \
--enable-mbstring \
--enable-ctype \
--with-zlib \
--with-zip \
--enable-posix \
--enable-sockets \
--enable-pdo \
--with-sqlite3 \
--enable-phar \
--enable-mysqlnd \
--with-mysqli \
--enable-intl \
--enable-fileinfo \
--with-pdo_mysql \
--with-pdo-sqlite \
--enable-soap \
--with-xsl \
--with-gmp=/usr/gmp \
--enable-exif \
--with-sodium \
--enable-xml --enable-simplexml --enable-xmlreader --enable-xmlwriter --enable-dom --with-libxml \
--enable-gd --with-jpeg=/usr/libjpeg  --with-freetype=/usr/freetype \
--enable-swoole --enable-sockets --enable-mysqlnd --enable-http2 --enable-swoole-json --enable-swoole-curl --enable-cares \
--enable-redis \
--with-imagick=/usr/imagemagick \
--with-yaml=/usr/libyaml \
"

make_openssl() {
    cd /work/libs
    echo "build openssl"
    mkdir -p /work/libs/openssl && \
    tar --strip-components=1 -C /work/libs/openssl -xf /work/pool/lib/openssl-1.1.1m.tar.gz  && \
    cd openssl && \
    echo  "./config -static --static no-shared --prefix=/usr/openssl"
        ./config -static --static no-shared --prefix=/usr/openssl && \
        make -j 8   && \
    make install
    cd -
}

clean_openssl() {
    cd /work/libs
    echo "clean openssl"
    cd /work/libs/openssl && make clean
    cd -
}

make_curl() {
    cd /work/libs
    echo "build curl"
    mkdir -p /work/libs/curl && \
    tar --strip-components=1 -C /work/libs/curl -xf /work/pool/lib/curl-7.80.0.tar.gz  && \
    cd curl && \
    echo  "autoreconf -fi && ./configure --prefix=/usr/curl --enable-static --disable-shared --with-openssl=/usr/openssl"
        autoreconf -fi && ./configure --prefix=/usr/curl --enable-static --disable-shared --with-openssl=/usr/openssl && \
        make -j 8   && \
    make install
    cd -
}

clean_curl() {
    cd /work/libs
    echo "clean curl"
    cd /work/libs/curl && make clean
    cd -
}

make_libiconv() {
    cd /work/libs
    echo "build libiconv"
    mkdir -p /work/libs/libiconv && \
    tar --strip-components=1 -C /work/libs/libiconv -xf /work/pool/lib/libiconv-1.16.tar.gz  && \
    cd libiconv && \
    echo  "./configure --prefix=/usr/libiconv enable_static=yes enable_shared=no"
        ./configure --prefix=/usr/libiconv enable_static=yes enable_shared=no && \
        make -j 8   && \
    make install
    cd -
}

clean_libiconv() {
    cd /work/libs
    echo "clean libiconv"
    cd /work/libs/libiconv && make clean
    cd -
}

make_libxml2() {
    cd /work/libs
    echo "build libxml2"
    mkdir -p /work/libs/libxml2 && \
    tar --strip-components=1 -C /work/libs/libxml2 -xf /work/pool/lib/libxml2-v2.9.10.tar.gz  && \
    cd libxml2 && \
    echo  "./autogen.sh && ./configure --prefix=/usr --enable-static=yes --enable-shared=no"
        ./autogen.sh && ./configure --prefix=/usr --enable-static=yes --enable-shared=no && \
        make -j 8   && \
    make install
    cd -
}

clean_libxml2() {
    cd /work/libs
    echo "clean libxml2"
    cd /work/libs/libxml2 && make clean
    cd -
}

make_libxslt() {
    cd /work/libs
    echo "build libxslt"
    mkdir -p /work/libs/libxslt && \
    tar --strip-components=1 -C /work/libs/libxslt -xf /work/pool/lib/libxslt-v1.1.34.tar.gz  && \
    cd libxslt && \
    echo  "./autogen.sh && ./configure --prefix=/usr --enable-static=yes --enable-shared=no"
        ./autogen.sh && ./configure --prefix=/usr --enable-static=yes --enable-shared=no && \
        make -j 8   && \
    make install
    cd -
}

clean_libxslt() {
    cd /work/libs
    echo "clean libxslt"
    cd /work/libs/libxslt && make clean
    cd -
}

make_imagemagick() {
    cd /work/libs
    echo "build imagemagick"
    mkdir -p /work/libs/imagemagick && \
    tar --strip-components=1 -C /work/libs/imagemagick -xf /work/pool/lib/7.1.0-19.tar.gz  && \
    cd imagemagick && \
    echo  "./configure --prefix=/usr/imagemagick --enable-static --disable-shared"
        ./configure --prefix=/usr/imagemagick --enable-static --disable-shared && \
        make -j 8   && \
    make install
    cd -
}

clean_imagemagick() {
    cd /work/libs
    echo "clean imagemagick"
    cd /work/libs/imagemagick && make clean
    cd -
}

make_gmp() {
    cd /work/libs
    echo "build gmp"
    mkdir -p /work/libs/gmp && \
    tar --strip-components=1 -C /work/libs/gmp -xf /work/pool/lib/gmp-6.2.1.tar.lz  && \
    cd gmp && \
    echo  "./configure --prefix=/usr/gmp --enable-static --disable-shared"
        ./configure --prefix=/usr/gmp --enable-static --disable-shared && \
        make -j 8   && \
    make install
    cd -
}

clean_gmp() {
    cd /work/libs
    echo "clean gmp"
    cd /work/libs/gmp && make clean
    cd -
}

make_giflib() {
    cd /work/libs
    echo "build giflib"
    mkdir -p /work/libs/giflib && \
    tar --strip-components=1 -C /work/libs/giflib -xf /work/pool/lib/giflib-5.2.1.tar.gz  && \
    cd giflib && \
    echo  ""
        make -j 8  libgif.a && \
    make install
    cd -
}

clean_giflib() {
    cd /work/libs
    echo "clean giflib"
    cd /work/libs/giflib && make clean
    cd -
}

make_libpng() {
    cd /work/libs
    echo "build libpng"
    mkdir -p /work/libs/libpng && \
    tar --strip-components=1 -C /work/libs/libpng -xf /work/pool/lib/libpng-1.6.37.tar.gz  && \
    cd libpng && \
    echo  "./configure --prefix=/usr/libpng --enable-static --disable-shared"
        ./configure --prefix=/usr/libpng --enable-static --disable-shared && \
        make -j 8   && \
    make install
    cd -
}

clean_libpng() {
    cd /work/libs
    echo "clean libpng"
    cd /work/libs/libpng && make clean
    cd -
}

make_libjpeg() {
    cd /work/libs
    echo "build libjpeg"
    mkdir -p /work/libs/libjpeg && \
    tar --strip-components=1 -C /work/libs/libjpeg -xf /work/pool/lib/libjpeg-turbo-2.1.2.tar.gz  && \
    cd libjpeg && \
    echo  "cmake -G"Unix Makefiles" -DCMAKE_INSTALL_PREFIX=/usr/libjpeg ."
        cmake -G"Unix Makefiles" -DCMAKE_INSTALL_PREFIX=/usr/libjpeg . && \
        make -j 8   && \
    make install
    cd -
}

clean_libjpeg() {
    cd /work/libs
    echo "clean libjpeg"
    cd /work/libs/libjpeg && make clean
    cd -
}

make_freetype() {
    cd /work/libs
    echo "build freetype"
    mkdir -p /work/libs/freetype && \
    tar --strip-components=1 -C /work/libs/freetype -xf /work/pool/lib/freetype-2.10.4.tar.gz  && \
    cd freetype && \
    echo  "./configure --prefix=/usr/freetype --enable-static --disable-shared"
        ./configure --prefix=/usr/freetype --enable-static --disable-shared && \
        make -j 8   && \
    make install
    cd -
}

clean_freetype() {
    cd /work/libs
    echo "clean freetype"
    cd /work/libs/freetype && make clean
    cd -
}

make_libwebp() {
    cd /work/libs
    echo "build libwebp"
    mkdir -p /work/libs/libwebp && \
    tar --strip-components=1 -C /work/libs/libwebp -xf /work/pool/lib/libwebp-1.2.1.tar.gz  && \
    cd libwebp && \
    echo  "./autogen.sh && ./configure --prefix=/usr/libwebp --enable-static --disable-shared"
        ./autogen.sh && ./configure --prefix=/usr/libwebp --enable-static --disable-shared && \
        make -j 8   && \
    make install
    cd -
}

clean_libwebp() {
    cd /work/libs
    echo "clean libwebp"
    cd /work/libs/libwebp && make clean
    cd -
}

make_sqlite3() {
    cd /work/libs
    echo "build sqlite3"
    mkdir -p /work/libs/sqlite3 && \
    tar --strip-components=1 -C /work/libs/sqlite3 -xf /work/pool/lib/sqlite-autoconf-3370000.tar.gz  && \
    cd sqlite3 && \
    echo  "./configure --prefix=/usr --enable-static --disable-shared"
        ./configure --prefix=/usr --enable-static --disable-shared && \
        make -j 8   && \
    make install
    cd -
}

clean_sqlite3() {
    cd /work/libs
    echo "clean sqlite3"
    cd /work/libs/sqlite3 && make clean
    cd -
}

make_zlib() {
    cd /work/libs
    echo "build zlib"
    mkdir -p /work/libs/zlib && \
    tar --strip-components=1 -C /work/libs/zlib -xf /work/pool/lib/zlib-1.2.11.tar.gz  && \
    cd zlib && \
    echo  "./configure --prefix=/usr --static"
        ./configure --prefix=/usr --static && \
        make -j 8   && \
    make install
    cd -
}

clean_zlib() {
    cd /work/libs
    echo "clean zlib"
    cd /work/libs/zlib && make clean
    cd -
}

make_bzip2() {
    cd /work/libs
    echo "build bzip2"
    mkdir -p /work/libs/bzip2 && \
    tar --strip-components=1 -C /work/libs/bzip2 -xf /work/pool/lib/bzip2-1.0.8.tar.gz  && \
    cd bzip2 && \
    echo  ""
        make -j 8  PREFIX=/usr/bzip2 && \
    make install
    cd -
}

clean_bzip2() {
    cd /work/libs
    echo "clean bzip2"
    cd /work/libs/bzip2 && make clean
    cd -
}

make_icu() {
    cd /work/libs
    echo "build icu"
    mkdir -p /work/libs/icu && \
    tar --strip-components=1 -C /work/libs/icu -xf /work/pool/lib/icu4c-60_3-src.tgz  && \
    cd icu && \
    echo  "source/runConfigureICU Linux --prefix=/usr --enable-static --disable-shared"
        source/runConfigureICU Linux --prefix=/usr --enable-static --disable-shared && \
        make -j 8   && \
    make install
    cd -
}

clean_icu() {
    cd /work/libs
    echo "clean icu"
    cd /work/libs/icu && make clean
    cd -
}

make_oniguruma() {
    cd /work/libs
    echo "build oniguruma"
    mkdir -p /work/libs/oniguruma && \
    tar --strip-components=1 -C /work/libs/oniguruma -xf /work/pool/lib/oniguruma-6.9.7.tar.gz  && \
    cd oniguruma && \
    echo  "./autogen.sh && ./configure --prefix=/usr --enable-static --disable-shared"
        ./autogen.sh && ./configure --prefix=/usr --enable-static --disable-shared && \
        make -j 8   && \
    make install
    cd -
}

clean_oniguruma() {
    cd /work/libs
    echo "clean oniguruma"
    cd /work/libs/oniguruma && make clean
    cd -
}

make_zip() {
    cd /work/libs
    echo "build zip"
    mkdir -p /work/libs/zip && \
    tar --strip-components=1 -C /work/libs/zip -xf /work/pool/lib/libzip-1.8.0.tar.gz  && \
    cd zip && \
    echo  "cmake . -DBUILD_SHARED_LIBS=OFF -DOPENSSL_USE_STATIC_LIBS=TRUE -DCMAKE_INSTALL_PREFIX=/usr"
        cmake . -DBUILD_SHARED_LIBS=OFF -DOPENSSL_USE_STATIC_LIBS=TRUE -DCMAKE_INSTALL_PREFIX=/usr && \
        make -j 8   && \
    make install
    cd -
}

clean_zip() {
    cd /work/libs
    echo "clean zip"
    cd /work/libs/zip && make clean
    cd -
}

make_cares() {
    cd /work/libs
    echo "build cares"
    mkdir -p /work/libs/cares && \
    tar --strip-components=1 -C /work/libs/cares -xf /work/pool/lib/c-ares-1.18.1.tar.gz  && \
    cd cares && \
    echo  "./configure --prefix=/usr --enable-static --disable-shared"
        ./configure --prefix=/usr --enable-static --disable-shared && \
        make -j 8   && \
    make install
    cd -
}

clean_cares() {
    cd /work/libs
    echo "clean cares"
    cd /work/libs/cares && make clean
    cd -
}

make_libsodium() {
    cd /work/libs
    echo "build libsodium"
    mkdir -p /work/libs/libsodium && \
    tar --strip-components=1 -C /work/libs/libsodium -xf /work/pool/lib/libsodium-1.0.18.tar.gz  && \
    cd libsodium && \
    echo  "./configure --prefix=/usr --enable-static --disable-shared"
        ./configure --prefix=/usr --enable-static --disable-shared && \
        make -j 8   && \
    make install
    cd -
}

clean_libsodium() {
    cd /work/libs
    echo "clean libsodium"
    cd /work/libs/libsodium && make clean
    cd -
}

make_libyaml() {
    cd /work/libs
    echo "build libyaml"
    mkdir -p /work/libs/libyaml && \
    tar --strip-components=1 -C /work/libs/libyaml -xf /work/pool/lib/yaml-0.2.5.tar.gz  && \
    cd libyaml && \
    echo  "./configure --prefix=/usr/libyaml --enable-static --disable-shared"
        ./configure --prefix=/usr/libyaml --enable-static --disable-shared && \
        make -j 8   && \
    make install
    cd -
}

clean_libyaml() {
    cd /work/libs
    echo "clean libyaml"
    cd /work/libs/libyaml && make clean
    cd -
}


make_all_library() {
    make_openssl && echo "[SUCCESS] make openssl"
    make_curl && echo "[SUCCESS] make curl"
    make_libiconv && echo "[SUCCESS] make libiconv"
    make_libxml2 && echo "[SUCCESS] make libxml2"
    make_libxslt && echo "[SUCCESS] make libxslt"
    make_imagemagick && echo "[SUCCESS] make imagemagick"
    make_gmp && echo "[SUCCESS] make gmp"
    make_giflib && echo "[SUCCESS] make giflib"
    make_libpng && echo "[SUCCESS] make libpng"
    make_libjpeg && echo "[SUCCESS] make libjpeg"
    make_freetype && echo "[SUCCESS] make freetype"
    make_libwebp && echo "[SUCCESS] make libwebp"
    make_sqlite3 && echo "[SUCCESS] make sqlite3"
    make_zlib && echo "[SUCCESS] make zlib"
    make_bzip2 && echo "[SUCCESS] make bzip2"
    make_icu && echo "[SUCCESS] make icu"
    make_oniguruma && echo "[SUCCESS] make oniguruma"
    make_zip && echo "[SUCCESS] make zip"
    make_cares && echo "[SUCCESS] make cares"
    make_libsodium && echo "[SUCCESS] make libsodium"
    make_libyaml && echo "[SUCCESS] make libyaml"
}

config_php() {
    rm ./configure
    ./buildconf --force
    mv main/php_config.h.in /tmp/cnt
    echo -ne '#ifndef __PHP_CONFIG_H\n#define __PHP_CONFIG_H\n' > main/php_config.h.in
    cat /tmp/cnt >> main/php_config.h.in
    echo -ne '\n#endif\n' >> main/php_config.h.in
    echo $OPTIONS
    echo $PKG_CONFIG_PATH
    ./configure $OPTIONS
}

make_php() {
    make EXTRA_CFLAGS='-fno-ident -Xcompiler -march=nehalem -Xcompiler -mtune=haswell -Os' \
    EXTRA_LDFLAGS_PROGRAM='-all-static -fno-ident -L/usr/openssl/lib -L/usr/curl/lib -L/usr/libiconv/lib -L/usr/imagemagick/lib -L/usr/gmp/lib -L/usr/giflib/lib -L/usr/libpng/lib -L/usr/libjpeg/lib64 -L/usr/freetype/lib -L/usr/libwebp/lib -L/usr/bzip2/lib -L/usr/libyaml/lib '  -j 8 && echo ""
}

help() {
    echo "./make.sh config"
    echo "./make.sh build"
    echo "./make.sh archive"
}

if [ "$1" = "docker-build" ] ;then
  sudo docker build -t phpswoole/swoole_cli_os:1.1 .
elif [ "$1" = "docker-bash" ] ;then
    sudo docker run -it -v $ROOT:/work -v /home/htf/workspace/swoole:/work/ext/swoole phpswoole/swoole_cli_os:1.1 /bin/bash
elif [ "$1" = "all-library" ] ;then
    make_all_library
elif [ "$1" = "openssl" ] ;then
    make_openssl && echo "[SUCCESS] make openssl"
elif [ "$1" = "curl" ] ;then
    make_curl && echo "[SUCCESS] make curl"
elif [ "$1" = "libiconv" ] ;then
    make_libiconv && echo "[SUCCESS] make libiconv"
elif [ "$1" = "libxml2" ] ;then
    make_libxml2 && echo "[SUCCESS] make libxml2"
elif [ "$1" = "libxslt" ] ;then
    make_libxslt && echo "[SUCCESS] make libxslt"
elif [ "$1" = "imagemagick" ] ;then
    make_imagemagick && echo "[SUCCESS] make imagemagick"
elif [ "$1" = "gmp" ] ;then
    make_gmp && echo "[SUCCESS] make gmp"
elif [ "$1" = "giflib" ] ;then
    make_giflib && echo "[SUCCESS] make giflib"
elif [ "$1" = "libpng" ] ;then
    make_libpng && echo "[SUCCESS] make libpng"
elif [ "$1" = "libjpeg" ] ;then
    make_libjpeg && echo "[SUCCESS] make libjpeg"
elif [ "$1" = "freetype" ] ;then
    make_freetype && echo "[SUCCESS] make freetype"
elif [ "$1" = "libwebp" ] ;then
    make_libwebp && echo "[SUCCESS] make libwebp"
elif [ "$1" = "sqlite3" ] ;then
    make_sqlite3 && echo "[SUCCESS] make sqlite3"
elif [ "$1" = "zlib" ] ;then
    make_zlib && echo "[SUCCESS] make zlib"
elif [ "$1" = "bzip2" ] ;then
    make_bzip2 && echo "[SUCCESS] make bzip2"
elif [ "$1" = "icu" ] ;then
    make_icu && echo "[SUCCESS] make icu"
elif [ "$1" = "oniguruma" ] ;then
    make_oniguruma && echo "[SUCCESS] make oniguruma"
elif [ "$1" = "zip" ] ;then
    make_zip && echo "[SUCCESS] make zip"
elif [ "$1" = "cares" ] ;then
    make_cares && echo "[SUCCESS] make cares"
elif [ "$1" = "libsodium" ] ;then
    make_libsodium && echo "[SUCCESS] make libsodium"
elif [ "$1" = "libyaml" ] ;then
    make_libyaml && echo "[SUCCESS] make libyaml"
elif [ "$1" = "config" ] ;then
    config_php
elif [ "$1" = "build" ] ;then
    make_php
elif [ "$1" = "archive" ] ;then
    cd bin
    SWOOLE_VERSION=$(./swoole-cli -r "echo SWOOLE_VERSION;")
    SWOOLE_CLI_FILE=swoole-cli-v${SWOOLE_VERSION}-linux-x64.tar.xz
    strip swoole-cli
    tar -cJvf ${SWOOLE_CLI_FILE} swoole-cli LICENSE
    mv ${SWOOLE_CLI_FILE} ../
    cd -
elif [ "$1" = "clean-library" ] ;then
    clean_openssl && echo "[SUCCESS] make clean [openssl]"
    clean_curl && echo "[SUCCESS] make clean [curl]"
    clean_libiconv && echo "[SUCCESS] make clean [libiconv]"
    clean_libxml2 && echo "[SUCCESS] make clean [libxml2]"
    clean_libxslt && echo "[SUCCESS] make clean [libxslt]"
    clean_imagemagick && echo "[SUCCESS] make clean [imagemagick]"
    clean_gmp && echo "[SUCCESS] make clean [gmp]"
    clean_giflib && echo "[SUCCESS] make clean [giflib]"
    clean_libpng && echo "[SUCCESS] make clean [libpng]"
    clean_libjpeg && echo "[SUCCESS] make clean [libjpeg]"
    clean_freetype && echo "[SUCCESS] make clean [freetype]"
    clean_libwebp && echo "[SUCCESS] make clean [libwebp]"
    clean_sqlite3 && echo "[SUCCESS] make clean [sqlite3]"
    clean_zlib && echo "[SUCCESS] make clean [zlib]"
    clean_bzip2 && echo "[SUCCESS] make clean [bzip2]"
    clean_icu && echo "[SUCCESS] make clean [icu]"
    clean_oniguruma && echo "[SUCCESS] make clean [oniguruma]"
    clean_zip && echo "[SUCCESS] make clean [zip]"
    clean_cares && echo "[SUCCESS] make clean [cares]"
    clean_libsodium && echo "[SUCCESS] make clean [libsodium]"
    clean_libyaml && echo "[SUCCESS] make clean [libyaml]"
elif [ "$1" = "diff-configure" ] ;then
  meld $SRC/configure.ac ./configure.ac
elif [ "$1" = "pkg-check" ] ;then
    echo "openssl"
    pkg-config --libs openssl
    echo "curl"
    pkg-config --libs libcurl
    echo "libiconv"
    pkg-config --libs libiconv
    echo "libxml2"
    pkg-config --libs libxml2
    echo "libxslt"
    pkg-config --libs libxslt
    echo "imagemagick"
    pkg-config --libs ImageMagick
    echo "gmp"
    pkg-config --libs gmp
    echo "giflib"
    pkg-config --libs giflib
    echo "libpng"
    pkg-config --libs libpng
    echo "libjpeg"
    pkg-config --libs libjpeg
    echo "freetype"
    pkg-config --libs freetype
    echo "libwebp"
    pkg-config --libs libwebp
    echo "sqlite3"
    pkg-config --libs sqlite3
    echo "zlib"
    pkg-config --libs zlib
    echo "bzip2"
    pkg-config --libs bzip2
    echo "icu"
    pkg-config --libs icu
    echo "oniguruma"
    pkg-config --libs oniguruma
    echo "zip"
    pkg-config --libs zip
    echo "cares"
    pkg-config --libs cares
    echo "libsodium"
    pkg-config --libs libsodium
    echo "libyaml"
    pkg-config --libs libyaml
elif [ "$1" = "sync" ] ;then
  echo "sync"
  # ZendVM
  cp -r $SRC/Zend ./
  # Extension
  cp -r $SRC/ext/bcmath/ ./ext
  cp -r $SRC/ext/bz2/ ./ext
  cp -r $SRC/ext/calendar/ ./ext
  cp -r $SRC/ext/ctype/ ./ext
  cp -r $SRC/ext/curl/ ./ext
  cp -r $SRC/ext/date/ ./ext
  cp -r $SRC/ext/dom/ ./ext
  cp -r $SRC/ext/exif/ ./ext
  cp -r $SRC/ext/fileinfo/ ./ext
  cp -r $SRC/ext/filter/ ./ext
  cp -r $SRC/ext/gd/ ./ext
  cp -r $SRC/ext/gettext/ ./ext
  cp -r $SRC/ext/gmp/ ./ext
  cp -r $SRC/ext/hash/ ./ext
  cp -r $SRC/ext/iconv/ ./ext
  cp -r $SRC/ext/intl/ ./ext
  cp -r $SRC/ext/json/ ./ext
  cp -r $SRC/ext/libxml/ ./ext
  cp -r $SRC/ext/mbstring/ ./ext
  cp -r $SRC/ext/mysqli/ ./ext
  cp -r $SRC/ext/mysqlnd/ ./ext
  cp -r $SRC/ext/opcache/ ./ext
  cp -r $SRC/ext/openssl/ ./ext
  cp -r $SRC/ext/pcntl/ ./ext
  cp -r $SRC/ext/pcre/ ./ext
  cp -r $SRC/ext/pdo/ ./ext
  cp -r $SRC/ext/pdo_mysql/ ./ext
  cp -r $SRC/ext/pdo_sqlite/ ./ext
  cp -r $SRC/ext/phar/ ./ext
  cp -r $SRC/ext/posix/ ./ext
  cp -r $SRC/ext/readline/ ./ext
  cp -r $SRC/ext/reflection/ ./ext
  cp -r $SRC/ext/session/ ./ext
  cp -r $SRC/ext/simplexml/ ./ext
  cp -r $SRC/ext/soap/ ./ext
  cp -r $SRC/ext/sockets/ ./ext
  cp -r $SRC/ext/sodium/ ./ext
  cp -r $SRC/ext/spl/ ./ext
  cp -r $SRC/ext/sqlite3/ ./ext
  cp -r $SRC/ext/standard/ ./ext
  cp -r $SRC/ext/sysvshm/ ./ext
  cp -r $SRC/ext/tokenizer/ ./ext
  cp -r $SRC/ext/xml/ ./ext
  cp -r $SRC/ext/xmlreader/ ./ext
  cp -r $SRC/ext/xmlwriter/ ./ext
  cp -r $SRC/ext/xsl/ ./ext
  cp -r $SRC/ext/zip/ ./ext
  cp -r $SRC/ext/zlib/ ./ext
  # main
  cp -r $SRC/main ./main
  cp -r sapi/cli sapi/cli
  cp -r ./TSRM/TSRM.h main/TSRM.h
  exit 0
else
    help
fi
