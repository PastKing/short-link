<template>
  <div class="main-content">
      <div class="url-box">
          <el-card class="url-card" :body-style="{ padding: '20px' }">
              <el-input v-model="longUrl" placeholder="请输入长链接"></el-input>
              <el-button type="primary" @click="generateShortUrl">生成短链接</el-button>
          </el-card>
      </div>
  </div>
</template>

<script>
export default {
    name: "urlMain",
    data() {
        return {
            longUrl: ""
        };
    },
    methods: {
        generateShortUrl() {
            if (!this.longUrl) {
                this.$message.error("请输入长链接");
                return;
            }

            // 简单检测是否是域名
            if (!this.isValidDomain(this.longUrl)) {
                this.$message.error("请输入有效的域名");
                return;
            }

            // 添加"http://"或"https://"前缀
            let url = this.longUrl;
            if (!url.startsWith("http://") && !url.startsWith("https://")) {
                url = `http://${url}`;
            }

            // 发送网络请求生成短链接
            url = `http://localhost:9090/generate?url=${encodeURIComponent(url)}`;

            fetch(url)
                .then(response => response.json())
                .then(data => {
                    // 处理返回的数据
                    if (data.code === 200) {
                        // 成功时显示消息框并复制到剪切板
                        this.$message({
                            type: "success",
                            message: data.msg,
                            onClose: () => {
                                this.copyToClipboard(data.data);
                            }
                        });
                    } else {
                        // 失败时显示错误消息
                        this.$message.error(data.msg);
                    }
                })
                .catch(error => {
                    // 发生错误时显示错误消息
                    console.error("Error:", error);
                    this.$message.error("网络请求失败");
                });
        },
        copyToClipboard(text) {
            const textarea = document.createElement("textarea");
            textarea.value = text;
            document.body.appendChild(textarea);
            textarea.select();
            document.execCommand("copy");
            document.body.removeChild(textarea);
            this.$message.success("已复制到剪切板");
        },
        isValidDomain(url) {
            // 简单的域名检测，以.开头的不合法
            return url.match(/^((?!-)[A-Za-z0-9-]{1,63}(?<!-)\.)+[A-Za-z]{2,6}$/);
        }
    }
};
</script>

<style scoped>
.url-box {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

.url-card {
    width: 300px;
}
</style>
