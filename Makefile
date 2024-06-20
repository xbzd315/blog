REMOTE=117.你的.IP.地址
APPNAME=blog

.PHONY: deploy
deploy:
    @echo "\n--- 开始构建可执行文件 ---"
    GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -v -o tmp/$(APPNAME)_tmp

    @echo "\n--- 上传可执行文件 ---"
    scp tmp/$(APPNAME)_tmp root@$(REMOTE):/data/www/blog.com/

    @echo "\n--- 停止服务 ---"
    ssh root@$(REMOTE) "supervisorctl stop $(APPNAME)"

    @echo "\n--- 替换新文件 ---"
    ssh root@$(REMOTE) "cd /data/www/blog.com/ \
                            && rm $(APPNAME) \
                            && mv $(APPNAME)_tmp $(APPNAME) \
                            && chown www-data:www-data $(APPNAME)"

    @echo "\n--- 开始服务 ---"
    ssh root@$(REMOTE) "supervisorctl start $(APPNAME)"

    @echo "\n--- 部署完毕 ---\n"