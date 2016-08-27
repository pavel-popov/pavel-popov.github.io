---
title: Setting up proxy in CentOS
date: 2016-08-16 13:49:00 +03:00
layout: post
categories:
- how-to
tags:
- centos
- proxy
---

If you're behind corporate proxy, then you need to configure your proxy settings so all applications can bypass.

Here I put proxy configuration for CentOS.

*Following examples suppose your proxy is at "proxy.intranet.com:8080", your username is "user" and your password is "pass".*

### Setting up environment variables

There are environment variables that various application may use for proxy:

* `HTTP_PROXY`
* `HTTPS_PROXY`

*Note, that some applications require lower-case environment variables, so I'm
duplicating them.*

To set them up for entire system put their values in `/etc/environment` file:

    HTTP_PROXY="http://user:pass@proxy.intranet.com:8080/"
    HTTPS_PROXY="https://user:pass@proxy.intranet.com:443/"
    http_proxy="http://user:pass@proxy.intranet.com:8080/"
    https_proxy="https://user:pass@proxy.intranet.com:443/"

### Setting up YUM

You need to edit `/etc/yum.conf` file and add the following lines there:

    proxy=http://proxy.intranet.com:8080/
    proxy_username=user
    proxy_password=pass

### Setting up Maven

You need to edit Maven settings in `{M2_HOME}/conf/settings.xml` and add your proxy details:

    <proxies>
      <proxy>
        <id>proxyid</id>
        <active>true</active>
        <protocol>http</protocol>
        <username>user</username>
        <password>pass</password>
        <host>proxy.intranet.com</host>
        <port>8080</port>
        <nonProxyHosts>local.net|some.host.com</nonProxyHosts>
      </proxy>
      <proxy>
        <id>proxyid</id>
        <active>true</active>
        <protocol>https</protocol>
        <username>user</username>
        <password>pass</password>
        <host>proxy.intranet.com</host>
        <port>443</port>
        <nonProxyHosts>local.net|some.host.com</nonProxyHosts>
      </proxy>
    </proxies>

### Open questions

1. Doublecheck that HTTPS proxy is working. In my current setup I have http-only proxy (http://...:8080) which correctly works with HTTPS traffic

2. Once you change your password you need to update it in above configurations. How to automate it?

3. **You keep your password in plain text. Everyone who has access to your machine and has corresponding privileges can read it. Be careful!**

There is a `cntlm` virtual proxy which will route all the traffic through it thus resolving questions 2 and 3. This is the subject for followup post.
