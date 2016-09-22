#### tesla source

##### TeslaServiceScanner

- com.mogujie.tesla.server.TeslaServiceScanner is predefined in [META-INF/tesla/core/expose.xml]，init() method is specified when spring load the configuration.
	
- TeslaServiceScanner is a ApplycationContextAware
	
- TeslaServiceScanner 的加载过程
	
	1. private final String appName =
            TeslaConfiguration._instance().getProperty(TeslaConfiguration.APP_NAME) 在TeslaServiceScanner被spring初始化实例时，TeslaConfiguration会被初始化！TeslaConfiguration默认会加载tesla.properties! TeslaConfiguration通过getProperty提供获取设置的渠道！
    2. FrameworkContext的启动!
        - FrameworkContext单例，私有构造函数，构造函数里指定了shutdown hook！调用FrameworkContext的shutdown()函数！shutdown函数任务：1.停掉所有暴露的service 2.sentry关闭
    3. 发送事件通知
    
##### FrameWorkLauncher
+ 主要成员	FrameworkContext
+ 启动时绑定ShutDownHook
+ 启动过程
	- 初始化FrameWorkContext(主要是加载所有的services: Iterable<TeslaModule>)
	- 
        	
##### **FrameworkContext** 
- List<TeslaModule> loadedServices; //所有的teslaModule
- Map<Class<? extends TeslaEvent>, List<EventListener<? extends TeslaEvent>>> listenersMapping; //teslaEvent对应的Listener，在publishEvent时，循环触发所有的Listener
	
- **InvokerFactory<ReferConfig<?>> invokerFactory** //待定
	
- 启动 com.mogujie.tesla.framework.FrameworkLauncher#launch
	
- FrameworkContext构造函数把所有的TeslaModule加载（通过ServiceLoader）,赋值给属性：List<TeslaModule> loadedServices
		
	- 循环初始化所有的TeslaModule: module.init(frameworkContext);
	
+ **TeslaExposeModule **
	- 设置exposeListeners，包含：ServerInvokerLookup、TeslaRegistrar
	- 注册ServiceExposeEvent事件的EventListeners: **context.registerEventListener(ServiceExposeEvent.class, exposeEventListener);**
	
##### TeslaExposeModule（tesla-server module下）

###### TeslaExposer
###### TeslaRegistrar
###### ReferConfig<T>
+ targetClass
+ targetAddress
+ timeout
###### ExposeConfig
+ String service
+ serviceVersion
+ targetBean
###### TeslaReferModule
###### TeslaExposer
###### ServiceExposeEvent
	+ TeslaServiceScanner会publish ServiceExposeEvent事件
		
        	
#### 框架问题
-         	


#### 技术问题
- class的getProtectionDomain的getCodeSource
- ServiceLoader加载策略
	- 指定classLoader时加载策略:SystemClassLoader,BootStrapClassLoader,extClassLoader
- javasistProxy等
- tesla自定义注解实现
- tesla自定义spring tag
	- tesla.xsd定义
	- META-INF/spring.schemas(spring-framework reference有说明)
	- META-INF/spring.handlers(spring-framework reference有说明)