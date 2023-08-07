<?php


use SwooleCli\Preprocessor;
use SwooleCli\Extension;

return function (Preprocessor $p) {
    //扩展依赖的静态链接库
    $depends = ['curl', 'openssl', 'cares', 'zlib', 'brotli', 'nghttp2'];
    $options = '--enable-swoole --enable-sockets --enable-mysqlnd --enable-swoole-curl --enable-cares ';
    $options .= ' --with-brotli-dir=' . BROTLI_PREFIX;
    $options .= ' --with-nghttp2-dir=' . NGHTTP2_PREFIX;

    //动态配置 依赖的的静态链接库
    if ($p->getInputOption('with-swoole-pgsql')) {
        $options .= ' --enable-swoole-pgsql';
        $depends[] = 'pgsql';
    }

    $rootDir = $p->getRootDir();
    //默认这个名称应该和扩展名称一致、和本文件名称一致 ；
    $ext = (new Extension('aaa_example'))
        /********************* 设置别名 start *****************************/
        //定义的名字和扩展名字不一致时，需要设置别名为扩展名
        ->withAliasName('swoole')
        /********************* 设置别名 end   *****************************/

        ->withOptions($options)
        ->withLicense('https://github.com/swoole/swoole-src/blob/master/LICENSE', Extension::LICENSE_APACHE2)
        ->withHomePage('https://github.com/swoole/swoole-src')
        ->withManual('https://wiki.swoole.com/#/')
        /*

        ->withDownloadWithOriginURL() //明确申明 使用源地址下载
        ->withAutoUpdateFile() //明确声明，每次都执行下载，不使用已下载的缓存文件
        ->withHttpProxy(false) //明确申明 不使用代理
        ->withBuildLibraryCached(false) //明确申明 不使用缓存缓存目录  例子： ext/swoole (每次都解压全新源代码到此目录）


         */


        //下载扩展源代码 四种方式 （任选一种即可，备注：PHP源码包含的扩展不需要下载）

        /********************* 下载扩展源代码方式一 start *****************************/
        // main分支 默认是这种方式 （去pecl.php.net 站点下载）
        //完整的下载地址 "https://pecl.php.net/get/swoole-5.0.3.tgz";
        ->withPeclVersion('5.0.3')  //pecl.php.net 站点 版本号
        /********************* 下载扩展源代码方式一 end   *****************************/


        /********************* 下载扩展源代码方式二 start *****************************/
        ->withUrl('https://github.com/swoole/swoole-src/archive/refs/tags/v5.0.3.tar.gz')
        ->withFile('swoole-v5.0.3.tar.gz')
        /********************* 下载扩展源代码方式二 end   *****************************/


        /********************* 下载扩展源代码方式三 start *****************************/
        # 使用 git clone 下载，然后打包为 后缀名为tar.gz 的文件
        ->withFile('swoole-latest.tar.gz')
        ->withDownloadScript(
            'swoole-src', # 待打包目录名称
            <<<EOF
            git clone -b master --depth=1 https://github.com/swoole/swoole-src.git
            # mirror
            # git clone -b master --depth=1 https://gitee.com/swoole/swoole.git
EOF
        )
        /********************* 下载扩展源代码方式三 end   *****************************/


        /********************* 下载扩展源代码方式四 start   *****************************/
        # 扩展作为本项目的一个模块
        # 使用时把 sapi/swoole 子模块源码打包为 pool/ext/swoole-git-submodule.tar.gz
        ->withFile('swoole-submodule.tar.gz')
        ->withDownloadScript(
            'swoole', # 待打包目录名称
            <<<EOF
            cd {$rootDir}/sapi
EOF
        )
        /********************* 下载扩展源代码方式四 end   *****************************/


        //明确申明不使用代理下载
        //例子： 下载扩展方式三，把下载地址更换为 https://gitee.com/swoole/swoole.git ，不使用代理下载
        ->withHttpProxy(false)
        //明确声明不使用缓存文件
        //例子： 下载扩展方式四 ，明确不使用  pool/ext/swoole-submodule.tar.gz 缓存文件；每一次都拉去最新的代码
        ->withBuildLibraryCached(false)

        //swoole 依赖的扩展
        ->withDependentExtensions('curl', 'openssl', 'sockets', 'mysqlnd', 'pdo')

        //swoole 依赖的静态链接库
        /********************* 依赖的静态链接库 写法一 start   *****************************/

        # 参数固定设置
        ->withDependentLibraries('curl', 'openssl', 'cares', 'zlib', 'brotli', 'nghttp2');

    /********************* 依赖的静态链接库 写法一 start   *****************************/


    /********************* 依赖的静态链接库 写法二 start   *****************************/
    # 根据传入的参数，动态设置
    call_user_func_array([$ext, 'withDependentLibraries'], $depends);
    /********************* 依赖的静态链接库 写法二 start   *****************************/


    $p->addExtension($ext);


    // 扩展钩子 （  PHP构建时 预处理阶段 之前执行的代码  ）
    $p->setExtHook('swoole', function (Preprocessor $p) {

        $workdir = $p->getWorkDir();
        $cmd = <<<EOF
        cd {$workdir}
        # 构建之前对 swoole 源码做一些特别处理
        # 比如加载一个补丁等
        # 比如修改 swoole 源码的构建文件
        # 实例 参考 protobuf.php 扩展配置 https://github.com/swoole/swoole-cli/blob/experiment/sapi/src/builder/extension/protobuf.php
EOF;

        return $cmd;
    });
};