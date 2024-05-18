<template>
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
                <el-table-column label="操作">
                    <template slot-scope="scope">
                        <el-button type="primary" @click="handleEdit(scope.row)">修改</el-button>
                        <el-button type="danger" @click="handleDelete(scope.row.id)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
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
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取消</el-button>
                <el-button type="primary" @click="handleUpdate">确定</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
export default {
    data() {
        return {
            user: JSON.parse(localStorage.getItem('xm-user') || '{}'),
            urls: [],
            dialogVisible: false,
            editForm: {
                dwz: '',
                llurl: ''
            }
        };
    },
    created() {
        this.fetchUserUrls();
    },
    methods: {
        fetchUserUrls() {
            // 传递用户ID给后端接口
            this.$request.get('/userUrls?id=' + this.user.id).then(res => {
                if (res.code === 200) {
                    this.urls = res.data;
                } else {
                    this.$message.error(res.msg);
                }
            });
        },
        handleEdit(row) {
            this.editForm = Object.assign({}, row);
            this.dialogVisible = true;
        },
        handleUpdate() {
            this.$request.put('/updateUrl', this.editForm).then(res => {
                if (res.code === 200) {
                    this.$message.success('更新成功');
                    this.dialogVisible = false;
                    this.fetchUserUrls(); // 更新链接列表
                } else {
                    this.$message.error(res.msg);
                }
            });
        },
        handleDelete(id) {
            this.$request.delete(`/deleteUrl/${id}`).then(res => {
                if (res.code === 200) {
                    this.$message.success('删除成功');
                    this.fetchUserUrls(); // 更新链接列表
                } else {
                    this.$message.error(res.msg);
                }
            });
        }
    }
};
</script>

<style scoped>
/* 样式 */
</style>
