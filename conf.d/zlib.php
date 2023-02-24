<?php

use SwooleCli\Library;
use SwooleCli\Preprocessor;
use SwooleCli\Extension;

return function (Preprocessor $p) {
    $p->addExtension((new Extension('zlib'))->withOptions('--with-zlib --with-zlib-dir=' . ZLIB_PREFIX)->depends('zlib'));
};
