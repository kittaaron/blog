####  打jar包  ####

#### 这里以https://start.spring.io/ 默认生成的demo为例

+ 默认运行mvn package应该在target目录下会生成两个文件(demo-*.jar和demo-*.jar.original)和几个目录，我们主要关注这两个文件。

+ 先看一下根pom文件：

  > ```
  > <plugins>
  >    <plugin>
  >       <groupId>org.springframework.boot</groupId>
  >       <artifactId>spring-boot-maven-plugin</artifactId>
  >    </plugin>
  > </plugins>
  > ```

  指定了这个插件，最终才会打出来两个包！一个demo-*.jar 可以直接运行，另外一个是后缀original的包。original包就是只包含项目中的代码和resources文件以及META-INF目录下MANIFEST.MF信息，我们忽略这个，只关注demo-*.jar这个包

####  demo*.jar

+ jar包解压后结构如下：

![./imgs/包结构.PNG](./imgs/包结构.PNG) 

+ 先看MANIFEST.MF内容

  + ```
    Main-Class: org.springframework.boot.loader.JarLauncher //启动类
    ```

  + ```
    Start-Class: com.example.DemoApplication
    Spring-Boot-Classes: BOOT-INF/classes
    Spring-Boot-Lib: BOOT-INF/lib/
    ```

  + 通过MANIFEST.MF文件中上面这些内容我们大概可以猜出来：启动的时候运行org.springframework.boot.loader.JarLauncher类，然后它应该会初始化ClassLoader，加载Boot-INF下的lib以及classed，发现这些类，然后初始化Spring Boot

+ 看一下JarLaucher启动代码(github链接：https://github.com/spring-projects/spring-boot/tree/master/spring-boot-tools/spring-boot-loader/src/main/java/org/springframework/boot/loader)

  + main函数	new JarLauncher().launch(args); 调用了launch方法。些方法在间接父类org.springframework.boot.loader.Launcher 中，launch函数:

    ```java
    	protected void launch(String[] args) throws Exception {
    		JarFile.registerUrlProtocolHandler();
    		ClassLoader classLoader = createClassLoader(getClassPathArchives());
    		launch(args, getMainClass(), classLoader);
    	}
    ```

  + 比较关键的是创建ClassLoader

    ```
    	protected ClassLoader createClassLoader(List<Archive> archives) throws Exception {
    		List<URL> urls = new ArrayList<URL>(archives.size());
    		for (Archive archive : archives) {
    			urls.add(archive.getUrl());
    		}
    		return createClassLoader(urls.toArray(new URL[urls.size()]));
    	}
    ```

    ```
    	@Override
    	protected List<Archive> getClassPathArchives() throws Exception {
    		List<Archive> archives = new ArrayList<Archive>(
    				this.archive.getNestedArchives(new EntryFilter() {

    					@Override
    					public boolean matches(Entry entry) {
    						return isNestedArchive(entry); //在JarLauncher中实现,把BOOT-INF/classes和BOOT-INF/lib下的包都会加载到
    					}

    				}));
    		postProcessClassPathArchives(archives);
    		return archives;
    	} //在org.springframework.boot.loader.ExecutableArchiveLauncher中实现
    ```

  + 以上保证依赖包能被找到后，createMainMethodRunner(mainClass, args, classLoader).run();

    就可以运营Application主类了(实现是从MANIFEST中读取Start-Class)

##### 关于可执行jar，Spring Boot官方说明：http://docs.spring.io/spring-boot/docs/current/reference/html/executable-jar.html