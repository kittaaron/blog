直接mount -t nfs4默认用4.1的NFS协议，访问非常慢，指定用4.0版本后OK。

mount -t nfs -o vers=4.0,nfsvers=4 <挂载点域名>:<文件系统内目录>  <当前服务器上待挂载目标目录>  
