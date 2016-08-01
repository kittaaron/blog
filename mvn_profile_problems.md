#### mvn profile不生效的问题（因为继承了spring-boot导致）

工程描述文件继承了spring-boot
	
	<parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>1.3.3.RELEASE</version>
    </parent>
    
spring-boot-starter-parent 描述文件中maven-resources-plugin插件指定了delimiter

				<plugin>
					<groupId>org.apache.maven.plugins</groupId>
					<artifactId>maven-resources-plugin</artifactId>
					<version>2.6</version>
					<configuration>
						<delimiters>
							<delimiter>${resource.delimiter}</delimiter>
						</delimiters>
						<useDefaultDelimiters>false</useDefaultDelimiters>
					</configuration>
				</plugin>
				
关于maven-resources-plugin delimiter的说明：

[https://maven.apache.org/plugins/maven-resources-plugin/resources-mojo.html](https://maven.apache.org/plugins/maven-resources-plugin/resources-mojo.html)