spring data jpa

- 核心：repository, entity
  - @Entity 注解domain类，一般和DB的某张表对应
  - 继承自org.springframework.data.jpa.repository.JpaRepository的子接口(经常直接继承CrudRepository)，接口中定义findBy等函数：如findByName(String name)默认根据传入的name从DB查询
- 定义查询方法的3种方式
  - 通过方法名
  - 通过@Query注解。通过@Query注解时，sql中参数有2种方式定义
    - SELECT * FROM USERS WHERE LASTNAME = ?1
    - SELECT * FROM USERS WHERE LASTNAME = :lastname    使用这种方式时方法参数前可加@Param("lastname")来映射sql中的变量名
    - 需要注意的是这里的from后面的表名，对应的的@Entity(name="USERS")的name属性，如果没有name属性，则对应Entity的SimpleClassName。可以设置@Query中的nativeQuery为true用native sql。
    - 在spring data jpa 1.4之后，可以用select x from #{#entityName} x 这样的方式，好处是@Entity变化或者是@Entity name属性指定后，代码可以不用修改。另外，在自定义一个repository时，@Query写在基类的时候，就能避免实体类重复写entityName了
          @NoRepositoryBean
          public interface MappedTypeRepository<T extends AbstractMappedType>
          extends Repository<T, Long> {
          @Query("select t from #{#entityName} t where t.attribute = ?1")
          List<T> findAllByAttribute(String attribute);
          }
  - 通过@NamedQuery
- 各种查询方式实现
  - 查询
    - 上面已经介绍了3种方式
  - 修改
    -     @Modifying
          @Query("update User u set u.firstname = ?1 where u.lastname = ?2")
          int setFixedFirstnameFor(String firstname, String lastname);
  - 删除
- 事务
  - @Transactional

- 自定义Repository
- Web Support
  - 通过 @EnableSpringDataWebSupport 支持Web属性
        @Configuration
        @EnableWebMvc
        @EnableSpringDataWebSupport
        class WebConfiguration { }
        @Controller
        @RequestMapping("/users")
        public class UserController {
        @RequestMapping("/{id}")
          //通過repository管理的User這個domain類，直接可以通過@PathVariable或者ReqParam映射
        public String showUserForm(@PathVariable("id") User user, Model model) {
        model.addAttribute("user", user);
        return "userForm";
        }
        }
- 没看懂的章节
  - Specifications
  - Example
