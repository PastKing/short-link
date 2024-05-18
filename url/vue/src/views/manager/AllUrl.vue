<template>
    <div>
        <div class="search" style="text-align: center;">
            <el-input placeholder="请输入账号ID查询" style="width: 200px" v-model="userId"></el-input>
            <el-button type="info" plain style="margin-left: 10px" @click="load(1)">查询</el-button>
            <el-button type="warning" plain style="margin-left: 10px" @click="reset">重置</el-button>
        </div>

        <div class="main-content">
            <el-card style="width: 70%; margin: 30px auto">
                <el-table :data="urls" border style="width: 100%">
                    <el-table-column prop="id" label="ID"></el-table-column>
                    <el-table-column label="短链接">
                        <template slot-scope="scope">
                            <span>http://localhost:9090/{{ scope.row.dwz }}</span>
                        </template>
                    </el-table-column>
                    <el-table-column prop="llurl" label="长链接"></el-table-column>
                    <el-table-column prop="time" label="生成时间"></el-table-column>
                    <el-table-column prop="userId" label="所述用户"></el-table-column>
                    <el-table-column label="操作">
                        <template slot-scope="scope">
                            <el-button type="primary" @click="handleEdit(scope.row)">修改</el-button>
                            <el-button type="danger" @click="handleDelete(scope.row.id)">删除</el-button>
                        </template>
                    </el-table-column>
                </el-table>

                <div class="pagination" style="text-align: center;">
                    <el-pagination
                        background
                        @current-change="handleCurrentChange"
                        :current-page="pageNum"
                        :page-sizes="[10, 20, 30]"
                        :page-size="pageSize"
                        layout="total, prev, pager, next"
                        :total="total">
                    </el-pagination>
                </div>
            </el-card>

            <!-- 编辑链接对话框 -->
            <el-dialog :visible.sync="dialogVisible" title="编辑链接">
                <el-form :model="editForm" ref="editForm" label-width="80px">
                    <el-table-column prop="dwz" label="短链接">
                        <template slot-scope="scope">
                            <span>{{ 'http://localhost:9090/' + scope.row.dwz }}</span>
                        </template>
                    </el-table-column>
                    <el-form-item label="长链接" prop="llurl">
                        <el-input v-model="editForm.llurl"></el-input>
                    </el-form-item>
                    <el-form-item label="用户ID" prop="userId">
                        <el-input v-model="editForm.userId"></el-input>
                    </el-form-item>
                </el-form>
                <div slot="footer" class="dialog-footer">
                    <el-button @click="dialogVisible = false">取消</el-button>
                    <el-button type="primary" @click="handleUpdate">确定</el-button>
                </div>
            </el-dialog>
        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            userId: '', // 用于存储输入的用户ID
            urls: [],
            dialogVisible: false,
            editForm: {
                dwz: '',
                llurl: '',
                userId: ''
            },
            pageNum: 1, // 初始化页码为1
            pageSize: 10, // 每页显示10条数据
            total: 0 // 数据总数
        };
    },
    created() {
        this.fetchPageUrls();
        this.fetchTotalCount();
    },
    methods: {
        fetchTotalCount() {
            this.$request.get('/allUrls').then(res => {
                if (res.code === 200) {
                    this.total = res.data.length;
                    console.log('total: ', this.total)
                } else {
                    this.$message.error(res.msg);
                }
            });
        },
        fetchPageUrls() {
            this.$request.get('/pageUrls', {
                params: {
                    page: this.pageNum,
                    pageSize: this.pageSize,
                }
            }).then(res => {
                if (res.code === 200) {
                    this.urls = res.data;
                } else {
                    this.$message.error(res.msg);
                }
            });
        },
        handleEdit(row) {
            // 将当前行数据填充到编辑表单中
            this.editForm = Object.assign({}, row);
            this.dialogVisible = true;
        },
        handleUpdate() {
            // 发送修改请求
            this.$request.put('/updateUrl', this.editForm).then(res => {
                if (res.code === 200) {
                    this.$message.success('更新成功');
                    this.dialogVisible = false;
                    this.fetchPageUrls(); // 更新链接列表
                } else {
                    this.$message.error(res.msg);
                }
            });
        },
        handleDelete(id) {
            // 发送删除请求
            this.$request.delete(`/deleteUrl/${id}`).then(res => {
                if (res.code === 200) {
                    this.$message.success('删除成功');
                    this.fetchPageUrls(); // 更新链接列表
                } else {
                    this.$message.error(res.msg);
                }
            });
        },
        load(pageNum) {
            // 根据输入获取用户数据
            this.$request.get('/userUrls', {
                params: {
                    id: this.userId
                }
            }).then(res => {
                if (res.code === 200) {
                    this.urls = res.data;
                    this.total = res.data.length; // 更新数据总数
                } else {
                    this.$message.error(res.msg);
                }
            });
        },
        handleCurrentChange(pageNum) {
            this.pageNum = pageNum;
            this.fetchPageUrls();
        },
        reset() {
            // 清空输入框和数据
            this.userId = '';
            this.urls = [];
            this.total = 0;
            this.fetchTotalCount();
            this.fetchPageUrls();
        },
    }
};
</script>

<style scoped>
/* 样式 */
</style>
