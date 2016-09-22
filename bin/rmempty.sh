#!/bin/bash
#### 删除空文件
find . -size 0 -exec rm {} \;
