install_shadowsocks_libev(){
    cd ${CUR_DIR}
    tar zxf ${shadowsocks_libev_file}.tar.gz
    cd ${shadowsocks_libev_file}
    ./configure --disable-documentation && make && make install
    if [ $? -eq 0 ]; then
        chmod +x ${SHADOWSOCKS_LIBEV_INIT}
        local service_name=$(basename ${SHADOWSOCKS_LIBEV_INIT})
        if check_sys packageManager yum; then
            chkconfig --add ${service_name}
            chkconfig ${service_name} on
        elif check_sys packageManager apt; then
            update-rc.d -f ${service_name} defaults
        fi
        [ -f ${SHADOWSOCKS_LIBEV_BIN_PATH} ] && ln -fs ${SHADOWSOCKS_LIBEV_BIN_PATH} /usr/bin
        echo -e "${Info} shadowsocks-libev安装成功."
    else
        echo
        echo -e "${Error} shadowsocks-libev安装失败."
        echo
        install_cleanup
        exit 1
    fi
}

install_shadowsocks_rust(){
    cd ${CUR_DIR}
    tar xf ${shadowsocks_rust_file}.tar.xz
    chmod +x sslocal ssserver ssurl ssmanager ssservice
    mv sslocal ssserver ssurl ssmanager ssservice ${SHADOWSOCKS_RUST_INSTALL_PATH}
    if [ $? -eq 0 ]; then
        chmod +x ${SHADOWSOCKS_RUST_INIT}
        local service_name=$(basename ${SHADOWSOCKS_RUST_INIT})
        if check_sys packageManager yum; then
            chkconfig --add ${service_name}
            chkconfig ${service_name} on
        elif check_sys packageManager apt; then
            update-rc.d -f ${service_name} defaults
        fi
        [ -f ${SHADOWSOCKS_RUST_BIN_PATH} ] && ln -fs ${SHADOWSOCKS_RUST_BIN_PATH} /usr/bin
        echo -e "${Info} shadowsocks-rust安装成功."
    else
        echo
        echo -e "${Error} shadowsocks-rust安装失败."
        echo
        install_cleanup
        exit 1
    fi
}

install_go_shadowsocks2(){
    cd ${CUR_DIR}

    if [ ! "$(command -v gunzip)" ]; then
        package_install "gunzip" > /dev/null 2>&1
    fi

    gunzip -q ${go_shadowsocks2_file}.gz
    chmod +x ${go_shadowsocks2_file}
    mv ${go_shadowsocks2_file} ${GO_SHADOWSOCKS2_BIN_PATH}
    if [ $? -eq 0 ]; then
        chmod +x ${GO_SHADOWSOCKS2_INIT}
        local service_name=$(basename ${GO_SHADOWSOCKS2_INIT})
        if check_sys packageManager yum; then
            chkconfig --add ${service_name}
            chkconfig ${service_name} on
        elif check_sys packageManager apt; then
            update-rc.d -f ${service_name} defaults
        fi
        [ -f ${GO_SHADOWSOCKS2_BIN_PATH} ] && ln -fs ${GO_SHADOWSOCKS2_BIN_PATH} /usr/bin
        echo -e "${Info} go-shadowsocks2安装成功."
    else
        echo
        echo -e "${Error} go-shadowsocks2安装失败."
        echo
        install_cleanup
        exit 1
    fi
}
